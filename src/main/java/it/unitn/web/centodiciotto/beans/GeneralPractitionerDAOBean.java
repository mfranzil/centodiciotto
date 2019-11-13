package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public class GeneralPractitionerDAOBean implements Serializable {

    private VisitDAO visitDAO = null;
    private PatientDAO patientDAO = null;
    private GeneralPractitionerDAO generalPractitionerDAO = null;
    private String practitionerID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    public List<Patient> getPatientsList() throws BeanException {
        List<Patient> patients = Collections.emptyList();

        if (practitionerID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            patients = patientDAO.getByPractitioner(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting patients list in practitionerDaoBean: ", e);
        }
        return patients;
    }

    public GeneralPractitioner getGeneralPractitioner() throws BeanException {
        if (practitionerID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return generalPractitionerDAO.getByPrimaryKey(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in practitionerDaoBean: ", e);
        }
    }

    public List<Visit> getPendingVisits() throws BeanException {
        if (practitionerID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return visitDAO.getPendingByPractitioner(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Visits: ", e);
        }
    }

    public List<Visit> getBookedVisits() throws BeanException {
        if (practitionerID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return visitDAO.getBookedByPractitioner(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Visits: ", e);
        }
    }
}
