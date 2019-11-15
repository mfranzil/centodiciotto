package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;

import java.sql.Timestamp;
import java.util.List;

/**
 * The interface Drug prescription dao.
 */
public interface DrugPrescriptionDAO extends DAO<DrugPrescription, Integer> {

    /**
     * Gets valid by patient.
     *
     * @param patientID the patient id
     * @return the valid by patient
     * @throws DAOException in case of a malformed input or query
     */
    List<DrugPrescription> getValidByPatient(String patientID) throws DAOException;

    /**
     * Gets by date sold.
     *
     * @param ts the ts
     * @return the by date sold
     * @throws DAOException in case of a malformed input or query
     */
    List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException;

    /**
     * Gets by patient not paid.
     *
     * @param patientID the patient id
     * @return the by patient not paid
     * @throws DAOException in case of a malformed input or query
     */
    List<DrugPrescription> getUnpaidByPatient(String patientID) throws DAOException;

}
