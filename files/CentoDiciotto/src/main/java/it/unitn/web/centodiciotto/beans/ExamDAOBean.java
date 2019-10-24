package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public class ExamDAOBean implements Serializable {
    private ExamDAO examDAO = null;
    private String examID = null;

    public void setDAOFactory(String useless){
        try {
            //TODO change with proper model
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            examDAO = daoFactory.getDAO(ExamDAO.class);
        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    public void setExamID(String examID) {
        System.out.println("Settato practitionerID a: " + examID);
        this.examID = examID;
    }

    public List<Exam> getPatientsNotPaid() throws DAOException {
        List<Exam> exams;

        if (examID == null) {
            throw new DAOException("Practitioner is null");
        }

        try {
            exams = examDAO.getByPatientNotPaid(examID);
            System.out.println("Test: " + exams.size());
        } catch (DAOException ex) {
            throw new DAOException("Error getting exam list in examDaoBean: ", ex);
        }
        return exams;
    }
}
