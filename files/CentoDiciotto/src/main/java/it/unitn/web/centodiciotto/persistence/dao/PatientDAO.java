package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface PatientDAO extends DAO<Patient, String> {

    public void insert(Patient patient);

    public void update(Patient patient);

    public void delete(Patient patient);

    public Patient getByPrimaryKey(String email);

    public Patient mapRowToPatient(ResultSet resultSet) throws SQLException;

    void updatePractitioner(Patient patient);
}

