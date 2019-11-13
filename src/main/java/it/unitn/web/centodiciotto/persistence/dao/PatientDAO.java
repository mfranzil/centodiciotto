package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Patient;

import java.util.List;

public interface PatientDAO extends DAO<Patient, String> {

    List<Patient> getPatientsByPractitioner(String practitionerID) throws DAOException;

    List<Patient> getPatientsByProvince(String provinceAbbreviation) throws DAOException;
}

