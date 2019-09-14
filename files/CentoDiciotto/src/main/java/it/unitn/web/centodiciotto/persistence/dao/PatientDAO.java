package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.DAO;

public interface PatientDAO extends DAO<Patient, String> {

    void insert(Patient patient);

    void update(Patient patient);

    void delete(Patient patient);
}
