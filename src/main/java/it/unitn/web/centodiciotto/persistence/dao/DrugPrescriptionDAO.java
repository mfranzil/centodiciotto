package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.sql.Timestamp;
import java.util.List;

public interface DrugPrescriptionDAO extends DAO<DrugPrescription, Integer> {

    List<DrugPrescription> getByPatient(String patientID) throws DAOException;

    List<DrugPrescription> getByPractitioner(String practitionerID) throws DAOException;

    List<DrugPrescription> getExpired() throws DAOException;

    List<DrugPrescription> getValid() throws DAOException;

    List<DrugPrescription> getValidByPatient(String patientID) throws DAOException;

    List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException;

}
