package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.utils.PhotoService;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import java.util.List;

public class PatientDAOBean implements Serializable {
    private VisitDAO visitDAO = null;
    private PatientDAO patientDAO = null;
    private ExamDAO examDAO = null;
    private String patientID = null;

    /*
    @PostConstruct
    public void init() {
        try {
            //TODO change with proper model
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);

        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }
     */
    public void setDAOFactory(String useless){
        try {
            //TODO change with proper model
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);

        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        System.out.println("Settato patientID a: " + patientID);
        this.patientID = patientID;
    }


    public Patient getPatient() throws DAOException {
        if (patientID == null) {
            throw new DAOException("PatientID is null");
        }

        Patient res = null;
        try {
            res = patientDAO.getByPrimaryKey(patientID);
        } catch (DAOException ex) {
            throw new DAOException("Error getting patient in patientDaoBean: ", ex);
        }
        return res;
    }

    public String getPhotoPath(Patient patient){
        return PhotoService.getLastPhoto(patient);
    }

    public Visit getLastVisit(Patient patient) throws DAOException {
        try {
            return visitDAO.getLastVisitByPatient(patient);
        } catch (DAOException ex) {
            throw new DAOException("Error getting lastVisit in patientDaoBean: ", ex);
        }
    }

    public List<Exam> getExams(Patient patient) throws DAOException {
        try {
            return examDAO.getByPatient(patient.getID());
        } catch (DAOException ex) {
            throw new DAOException("Error getting exams in patientDaoBean: ", ex);
        }
    }
}
