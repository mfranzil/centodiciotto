package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;

import java.sql.Timestamp;
import java.util.List;

/**
 * DAO interface for a {@link DrugPrescription} entity.
 */
public interface DrugPrescriptionDAO extends DAO<DrugPrescription, Integer> {

    /**
     * Returns a {@link List} of valid {@link DrugPrescription}s from a given {@code patientID}.
     * <p>
     * A prescription is considered valid if it hasn't been used and paid yet
     * and was prescribed no more than a month ago.
     *
     * @param patientID the {@code patientID}
     * @return {@link List} of valid {@link DrugPrescription}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<DrugPrescription> getValidByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link DrugPrescription}s from a given {@code patientID}.
     *
     * @param patientID the {@code patientID}
     * @return {@link List} of {@link DrugPrescription}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<DrugPrescription> getByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link DrugPrescription}s from a given
     * {@link Timestamp}, representing the date it was sold.
     * <p>
     * Eventual prescriptions with date sold set to {@code null} will be discarded.
     *
     * @param ts the {@link Timestamp} representing the date the prescription was sold
     * @return {@link List} of {@link DrugPrescription}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException;

}
