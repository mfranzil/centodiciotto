package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public class SpecializedDoctorDAOBean implements Serializable {
    private PatientDAO patientDAO = null;
    private SpecializedDoctorDAO specializedDoctorDAO = null;
    private String specialistID = null;

    public void setDAOFactory(String useless){
        try {
            //TODO change with proper model
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);

        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    public void setSpecialistID(String specialistID) {
        this.specialistID = specialistID;
    }

    public List<Patient> getPatientsList() throws DAOException {
        List<Patient> patients;

        if (specialistID == null) {
            throw new DAOException("Specialist is null");
        }

        try {
            patients = patientDAO.getPatientsByPractitionerID(specialistID);
            System.out.println("Test: " + patients.size());

        } catch (DAOException ex) {
            throw new DAOException("Error getting patients list in SpecializedDoctorDaoBean: ", ex);
        }
        return patients;
    }

    public SpecializedDoctor getSpecializedDoctorByID() throws DAOException {
        try {
            return specializedDoctorDAO.getByPrimaryKey(specialistID);
        } catch (DAOException ex) {
            throw new DAOException("Error getting lastVisit in specialistDaoBean: ", ex);
        }

    }
}
