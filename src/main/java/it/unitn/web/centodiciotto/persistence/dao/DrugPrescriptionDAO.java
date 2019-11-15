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
     * Gets by patient.
     *
     * @param patientID the patient id
     * @return the by patient
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getByPatient(String patientID) throws DAOException;

    /**
     * Gets by practitioner.
     *
     * @param practitionerID the practitioner id
     * @return the by practitioner
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getByPractitioner(String practitionerID) throws DAOException;

    /**
     * Gets expired.
     *
     * @return the expired
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getExpired() throws DAOException;

    /**
     * Gets valid.
     *
     * @return the valid
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getValid() throws DAOException;

    /**
     * Gets valid by patient.
     *
     * @param patientID the patient id
     * @return the valid by patient
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getValidByPatient(String patientID) throws DAOException;

    /**
     * Gets by date sold.
     *
     * @param ts the ts
     * @return the by date sold
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException;

    /**
     * Gets by patient not paid.
     *
     * @param patientID the patient id
     * @return the by patient not paid
     * @throws DAOException the dao exception
     */
    List<DrugPrescription> getByPatientNotPaid(String patientID) throws DAOException;

}
