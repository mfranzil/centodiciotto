package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface PatientDAO extends DAO<Patient, String> {

    void insert(Patient patient) throws DAOException;

    void update(Patient patient) throws DAOException;

    void delete(Patient patient) throws DAOException;

    Patient getByPrimaryKey(String email) throws DAOException;

    Patient mapRowToPatient(ResultSet resultSet) throws SQLException;

    void updatePractitioner(Patient patient) throws DAOException;
}

