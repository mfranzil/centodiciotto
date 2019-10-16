package it.unitn.web.utils;

import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.List;

public class VEPService {
    private final static int MAX_EXAMS = 5;
    private static ServletContext sc;

    private static VisitDAO visitDAO;
    private static PrescriptionDAO prescriptionDAO;
    private static GeneralPractitionerDAO practitionerDAO;
    private static ExamDAO examDAO;
    private static ExamListDAO examListDAO;

    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws RuntimeException {
        sc = servletContext;

        if (daoFactory == null) {
            throw new RuntimeException("Impossible to get dao factory for user storage system");
        }
        try {
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            prescriptionDAO = daoFactory.getDAO(PrescriptionDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException ex) {
            throw new RuntimeException("Impossible to get dao factory for user storage system", ex);
        }
    }

    public static Visit getLastDoneVisit(Patient patient) throws RuntimeException {
        Visit visit = null;
        if (patient == null) {
            return null;
        }
        try {
            visit = visitDAO.getLastVisitByPatient(patient);

            if (visit == null) {
                return null;
            }

            GeneralPractitioner visitPr = practitionerDAO.getByPrimaryKey(visit.getPractitionerEmail());
            visit.setPractitionerFirstName(visitPr.getFirstName());
            visit.setPractitionerLastName(visitPr.getLastName());
        } catch (DAOException e) {
            throw new RuntimeException("Error contacting the DAO for visit retrieval", e);
        }

        return visit;
    }

    public static List<Exam> getLastDoneExams(Patient patient) throws RuntimeException {
        List<Exam> exams = new ArrayList<>();
        if (patient == null) {
            return null;
        }

        try {
            exams = examDAO.getByPatient(patient.getID());
            exams = exams.subList(0, Math.min(MAX_EXAMS + 1, exams.size()));

            for (Exam exam : exams) {
                exam.setExamDescription(examListDAO.getByPrimaryKey(exam.getType()).getDescription());
            }
        } catch (DAOException e) {
            throw new RuntimeException("Error contacting the DAO for exam retrieval", e);
        }

        return exams;
    }
/*
    public static List<String> getExamName(List<Exam> exams) throws RuntimeException {
        List<String> examsWithName = new ArrayList<>();
        try {
            for (Exam exam : exams) {
                String examDescription = examListDAO.getByPrimaryKey(exam.getExamType()).getExamDescription();
                examsWithName.add(examDescription);
            }
        } catch (DAOException e) {
            throw new RuntimeException("Error contacting the DAO for exam list retrieval", e);
        }
        return examsWithName;
    }

    public static String getExamName(Exam exam) throws RuntimeException {
        String examWithName;
        try {
            examWithName = examListDAO.getByPrimaryKey(exam.getExamType()).getExamDescription();
        } catch (DAOException e) {
            throw new RuntimeException("Error contacting the DAO for exam list retrieval", e);
        }
        return examWithName;
    }*/
}