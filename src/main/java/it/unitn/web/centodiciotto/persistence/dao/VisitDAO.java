package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

import java.sql.Timestamp;
import java.util.List;

/**
 * The interface Visit dao.
 */
public interface VisitDAO extends DAO<Visit, Integer> {

    /**
     * Gets pending by practitioner.
     *
     * @param practictionerID the practictioner id
     * @return the pending by practitioner
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getPendingByPractitioner(String practictionerID) throws DAOException;

    /**
     * Gets booked by practitioner.
     *
     * @param practitionerID the practitioner id
     * @return the booked by practitioner
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getBookedByPractitioner(String practitionerID) throws DAOException;

    /**
     * Gets done by practitioner.
     *
     * @param practitionerID the practitioner id
     * @return the done by practitioner
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getDoneByPractitioner(String practitionerID) throws DAOException;

    /**
     * Gets done by patient.
     *
     * @param patientID the patient id
     * @return the done by patient
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getDoneByPatient(String patientID) throws DAOException;

    /**
     * Gets last by patient.
     *
     * @param patient the patient
     * @return the last by patient
     * @throws DAOException in case of a malformed input or query
     */
    Visit getLastByPatient(String patient) throws DAOException;

    /**
     * Gets pending by practitioner and patient.
     *
     * @param practictionerID the practictioner id
     * @param patientID       the patient id
     * @return the pending by practitioner and patient
     * @throws DAOException in case of a malformed input or query
     */
    Visit getPendingByPractitionerAndPatient(String practictionerID, String patientID) throws DAOException;

    /**
     * Gets by date.
     *
     * @param ts the ts
     * @return the by date
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getByDate(Timestamp ts) throws DAOException;

}
