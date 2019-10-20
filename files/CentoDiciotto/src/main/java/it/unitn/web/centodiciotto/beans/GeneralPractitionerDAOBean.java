package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.utils.PhotoService;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public class GeneralPractitionerDAOBean implements Serializable {
    private PatientDAO patientDAO = null;
    private GeneralPractitionerDAO generalPractitionerDAO = null;
    private String practitionerID = null;

    public void setDAOFactory(String useless){
        try {
            //TODO change with proper model
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);

        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    public void setPractitionerID(String practitionerID) {
        System.out.println("Settato practitionerID a: " + practitionerID);
        this.practitionerID = practitionerID;
    }

    public List<Patient> getPatientsList() throws DAOException {
        List<Patient> patients = Collections.emptyList();

        if (practitionerID == null) {
            throw new DAOException("Practitioner is null");
        }

        try {
            patients = patientDAO.getPatientsByPractitionerId(practitionerID);
            System.out.println("Test: " + patients.size());

        } catch (DAOException ex) {
            throw new DAOException("Error getting patients list in practitionerDaoBean: ", ex);
        }
        return patients;
    }

    public String getFirstName(GeneralPractitioner generalPractitioner){
        return generalPractitioner.getFirstName();
    }

    public String getLastName(GeneralPractitioner generalPractitioner){
        return generalPractitioner.getLastName();
    }

    public GeneralPractitioner getGeneralPractitionerByID(String practitionerID) throws DAOException {
        try {
            return generalPractitionerDAO.getByPrimaryKey(practitionerID);
        } catch (DAOException ex) {
            throw new DAOException("Error getting lastVisit in practitionerDaoBean: ", ex);
        }
    }
}