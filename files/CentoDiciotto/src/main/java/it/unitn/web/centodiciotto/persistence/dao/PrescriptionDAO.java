package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Prescription;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface PrescriptionDAO extends DAO<Prescription, Integer> {

    void insert(Prescription prescription) throws DAOException;

    void update(Prescription prescription) throws DAOException;

    void delete(Prescription prescription) throws DAOException;

    List<Prescription> getByPatient(String patientEmail) throws DAOException;

    List<Prescription> getByPractitioner(String practitionerEmail) throws DAOException;

    List<Prescription> getExpired() throws DAOException;

    List<Prescription> getValid() throws DAOException;
}
