package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface PatientDAO extends DAO<Patient, String> {

    void updatePractitioner(Patient patient) throws DAOException;

    List<Patient> getPatientsByPractitionerID(String practitionerID) throws DAOException;

    List<Patient> getPatientsBySSNOrPartialName(String query) throws DAOException;

}

