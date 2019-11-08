package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;

import java.sql.Timestamp;
import java.util.List;

public interface DrugPrescriptionDAO extends DAO<DrugPrescription, Integer> {

    List<DrugPrescription> getByPatient(String patientID) throws DAOException;

    List<DrugPrescription> getByPractitioner(String practitionerID) throws DAOException;

    List<DrugPrescription> getExpired() throws DAOException;

    List<DrugPrescription> getValid() throws DAOException;

    List<DrugPrescription> getValidByPatient(String patientID) throws DAOException;

    List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException;

    List<DrugPrescription> getByPatientNotPaid(String patientID) throws DAOException;

}
