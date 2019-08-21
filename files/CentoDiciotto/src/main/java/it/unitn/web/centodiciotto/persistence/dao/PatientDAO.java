package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;

public interface PatientDAO {

    public void insert(Patient patient);

    public void update(Patient patient);

    public void delete(Patient patient);

    public Patient getByEmail(String email);
}
