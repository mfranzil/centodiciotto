package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface DrugPrescriptionDAO extends DAO<DrugPrescription, Integer> {

    List<DrugPrescription> getByPatient(String patientEmail) throws DAOException;

    List<DrugPrescription> getByPractitioner(String practitionerEmail) throws DAOException;

    List<DrugPrescription> getExpired() throws DAOException;

    List<DrugPrescription> getValid() throws DAOException;

    public List<DrugPrescription> getValidByPatient(String patientID) throws DAOException;
}
