package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.utils.exceptions.BeanException;

import java.io.Serializable;
import java.util.List;

public class SpecializedDoctorDAOBean implements Serializable {

    private PatientDAO patientDAO = null;
    private SpecializedDoctorDAO specializedDoctorDAO = null;

    private String specialistID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setSpecialistID(String specialistID) {
        this.specialistID = specialistID;
    }

    public List<Patient> getPatientsList() throws BeanException {
        List<Patient> patients;

        if (specialistID == null) {
            throw new BeanException("Specialist is null");
        }

        try {
            patients = patientDAO.getPatientsByPractitioner(specialistID);

        } catch (DAOException e) {
            throw new BeanException("Error getting patients list in SpecializedDoctorDaoBean: ", e);
        }
        return patients;
    }

    public SpecializedDoctor getSpecializedDoctorByID() throws BeanException {
        try {
            return specializedDoctorDAO.getByPrimaryKey(specialistID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in specialistDaoBean: ", e);
        }

    }
}
