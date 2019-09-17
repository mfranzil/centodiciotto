package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Prescription;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface PrescriptionDAO extends DAO<Prescription, Integer> {

    void insert(Prescription prescription);

    void update(Prescription prescription);

    void delete(Prescription prescription);

    List<Prescription> getByPatient(String patientEmail);

    List<Prescription> getByPractitioner(String practitionerEmail);

    List<Prescription> getExpired();

    List<Prescription> getValid();
}
