package it.unitn.web.centodiciotto.beans;


import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.HealthServiceDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;

import java.io.Serializable;
import java.util.List;

public class HealthServiceDAOBean implements Serializable {

    private ExamDAO examDAO = null;
    private PatientDAO patientDAO = null;
    private HealthServiceDAO healthServiceDAO = null;

    private String healthServiceID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setHealthServiceID(String healthServiceID) {
        this.healthServiceID = healthServiceID;
    }
    public HealthService getHealthService() throws BeanException {
        try {
            return healthServiceDAO.getByPrimaryKey(healthServiceID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in healthServiceDaoBean: ", e);
        }

    }

    public List<Exam> getPendingExams() throws BeanException {
        if (healthServiceID == null) {
            throw new BeanException("HealthServiceID is null");
        }

        try {
            return examDAO.getPendingByHS(healthServiceID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Exams: ", e);
        }
    }

    public List<Exam> getBookedExams() throws BeanException {
        if (healthServiceID == null) {
            throw new BeanException("HealthServiceID is null");
        }

        try {
            return examDAO.getBookedByHS(healthServiceID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Visits: ", e);
        }
    }


}
