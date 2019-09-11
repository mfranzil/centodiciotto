package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;

public interface PatientDAO extends DAO<Patient, String> {

    public void insert(Patient patient);

    public void update(Patient patient);

    public void delete(Patient patient);

    public Patient getByEmail(String email);
}
