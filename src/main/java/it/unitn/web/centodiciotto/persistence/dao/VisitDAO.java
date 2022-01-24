package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

import java.sql.Timestamp;
import java.util.List;

/**
 * DAO interface for a {@link Visit} entity.
 */
public interface VisitDAO extends DAO<Visit, Integer> {

    /**
     * Returns a {@link List} of pending {@link Visit}s from a given {@code practitionerID}.
     * <p>
     * An {@link Visit} is considered pending if a date hasn't been assigned yet.
     *
     * @param practitionerID the {@code practitionerID}
     * @return a {@link List} of pending {@link Visit}s from a given {@code practitionerID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getPendingByPractitioner(String practitionerID) throws DAOException;

    /**
     * Returns a {@link List} of booked {@link Visit}s from a given {@code practitionerID}.
     * <p>
     * An {@link Visit} is considered booked if a date has been assigned,
     * but a result hasn't been assigned yet and the done flag has been
     * set to {@code false}
     *
     * @param practitionerID the {@code practitionerID}
     * @return a {@link List} of booked {@link Visit}s from a given {@code practitionerID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getBookedByPractitioner(String practitionerID) throws DAOException;

    /**
     * Returns a {@link List} of booked but not done {@link Visit}s from a given {@code practitionerID}.
     * <p>
     * An {@link Visit} is considered not done if it is booked
     * and the done flag has been set to {@code false}
     *
     * @param practitionerID the {@code practitionerID}
     * @return a {@link List} of booked {@link Visit}s from a given {@code practitionerID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getNotDoneByPractitioner(String practitionerID) throws DAOException;

    /**
     * Returns a {@link List} of done {@link Visit}s from a given {@code practitionerID}.
     * <p>
     * An {@link Visit} is considered booked when the done flag has been set to {@code true}.
     *
     * @param practitionerID the {@code practitionerID}
     * @return a {@link List} of done {@link Visit}s from a given {@code practitionerID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getDoneByPractitioner(String practitionerID) throws DAOException;

    /**
     * Returns a {@link List} of done {@link Visit}s from a given {@code patientID}.
     * <p>
     * An {@link Visit} is considered booked when the done flag has been set to {@code true}.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of done {@link Visit}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getDoneByPatient(String patientID) throws DAOException;

    /**
     * Returns the last done {@link Visit} by {@code patientID}.
     *
     * @param patientID the {@code patientID}
     * @return the last done {@link Visit} by {@code patientID}.
     * @throws DAOException in case of a malformed input or query
     */
    Visit getLastByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of pending {@link Visit}s from a given {@code practitionerID} and {@code patientID}.
     * <p>
     * An {@link Visit} is considered pending if a date hasn't been assigned yet.
     *
     * @param practictionerID the {@code practitionerID}
     * @param patientID       the {@code patientID}
     * @return a {@link List} of pending {@link Visit}s from a given {@code practitionerID} and {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    Visit getPendingByPractitionerAndPatient(String practictionerID, String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link Visit}s from a given {@link Timestamp}.
     *
     * @param ts the {@link Timestamp} representing the date (discarding hours to milliseconds and considering the whole day)
     * @return a {@link List} of {@link Visit}s from a given {@link Timestamp}
     * @throws DAOException in case of a malformed input or query
     */
    List<Visit> getByDate(Timestamp ts) throws DAOException;
}
