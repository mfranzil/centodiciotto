package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import java.io.Serializable;
import java.util.List;

public class PatientDAOBean implements Serializable {

    private VisitDAO visitDAO = null;
    private PatientDAO patientDAO = null;
    private GeneralPractitionerDAO practitionerDAO = null;
    private ExamDAO examDAO = null;

    private String patientID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public Patient getPatient() throws BeanException {
        if (patientID == null) {
            throw new BeanException("PatientID is null");
        }

        Patient res;
        try {
            res = patientDAO.getByPrimaryKey(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting patient in patientDaoBean: ", e);
        }
        return res;
    }

    public String getPhotoPath() throws BeanException {
        try {
            return PhotoService.getInstance().getLastPhoto(patientID);
        } catch (ServiceException e) {
            throw new BeanException("Error getting Photo path: ", e);
        }
    }

    public Visit getLastVisit() throws BeanException {
        try {
            return visitDAO.getLastVisitByPatientID(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in patientDaoBean: ", e);
        }
    }

    public List<Exam> getExams() throws BeanException {
        try {
            return examDAO.getByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    public List<Visit> getDoneVisits() throws BeanException {
        try {
            return visitDAO.getDoneByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    public Visit getPendingVisit() throws BeanException {
        try {
            return visitDAO.getPendingVisitByPractitionerAndPatient(getPatient().getPractitionerID(), patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    public GeneralPractitioner getPractitioner() throws BeanException {
        try {
            return practitionerDAO.getByPrimaryKey(getPatient().getPractitionerID());
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }
}
