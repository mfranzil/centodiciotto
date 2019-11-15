package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Recall;

import java.sql.Timestamp;
import java.util.List;

/**
 * DAO interface for a {@link Exam} entity.
 */
public interface ExamDAO extends DAO<Exam, Integer> {

    /**
     * Returns a {@link List} of {@link Exam}s from a given {@code patientID}.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link Exam}s made in the last year from a given {@code patientID}.
     * <p>
     * Eventual {@link Exam}s with {@code null} date will be discarded.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of {@link Exam}s made in the last year from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getByPatientLastYear(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of unpaid {@link Exam}s from a given {@code patientID}.
     * <p>
     * An {@link Exam} is considered unpaid if it has been done, but the ticket hasn't been paid yet.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of unpaid {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getUnpaidByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of not pending {@link Exam}s from a given {@code patientID}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     * <p>
     * An SQL UNION between this and {@link #getPendingByPatient(String)} must yield the
     * same results as {@link #getByPatient(String)}.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of not pending {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getNotPendingByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of not pending {@link Exam}s from a given {@code patientID}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     * <p>
     * An SQL UNION between this and {@link #getNotPendingByPatient(String)} must yield the
     * same results as {@link #getByPatient(String)}.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of not pending {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getPendingByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link Exam}s from a given {@code patientID} and {@code examID}.
     *
     * @param patientID the {@code patientID}
     * @param examID    the {@code examID}
     * @return a {@link List} of {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    Exam getPendingByPatientAndExamType(String patientID, Integer examID) throws DAOException;

    /**
     * Returns a {@link List} of unassigned {@link Exam}s from a given {@code patientID}.
     * <p>
     * An {@link Exam} is considered unassigned if both {@link Exam#getDoctorID}
     * and {@link Exam#getHealthServiceID} are {@code null}.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of unassigned {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getUnassignedByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of pending {@link Exam}s from a given {@code doctorID}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     *
     * @param doctorID the {@code doctorID}
     * @return a {@link List} of pending {@link Exam}s from a given {@code doctorID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getPendingByDoctor(String doctorID) throws DAOException;

    /**
     * Returns a {@link List} of booked {@link Exam}s from a given {@code doctorID}.
     * <p>
     * An {@link Exam} is considered booked if a date has been assigned,
     * but a result hasn't been assigned yet and the done flag has been
     * set to {@code false}
     *
     * @param doctorID the {@code doctorID}
     * @return a {@link List} of booked {@link Exam}s from a given {@code doctorID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getBookedByDoctor(String doctorID) throws DAOException;

    /**
     * Returns a {@link List} of done {@link Exam}s from a given {@code doctorID}.
     * <p>
     * An {@link Exam} is considered booked when the done flag has been set to {@code true}.
     *
     * @param doctorID the {@code doctorID}
     * @return a {@link List} of done {@link Exam}s from a given {@code doctorID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getDoneByDoctor(String doctorID) throws DAOException;

    /**
     * Returns a {@link List} of pending {@link Exam}s from a given {@code healthServiceID}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     *
     * @param healthServiceID the {@code healthServiceID}
     * @return a {@link List} of pending {@link Exam}s from a given {@code healthServiceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getPendingByHS(String healthServiceID) throws DAOException;

    /**
     * Returns a {@link List} of booked {@link Exam}s from a given {@code healthServiceID}.
     * <p>
     * An {@link Exam} is considered booked if a date has been assigned,
     * but a result hasn't been assigned yet and the done flag has been
     * set to {@code false}
     *
     * @param healthServiceID the {@code healthServiceID}
     * @return a {@link List} of booked {@link Exam}s from a given {@code healthServiceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getBookedByHS(String healthServiceID) throws DAOException;

    /**
     * Returns a {@link List} of done {@link Exam}s from a given {@code healthServiceID}.
     * <p>
     * An {@link Exam} is considered booked when the done flag has been set to {@code true}.
     *
     * @param healthServiceID the {@code healthServiceID}
     * @return a {@link List} of done {@link Exam}s from a given {@code healthServiceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getDoneByHS(String healthServiceID) throws DAOException;

    /**
     * Returns a {@link List} of pending {@link Exam}s from a given
     * {@code doctorID}, {@code patientID} and {@code examType}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     *
     * @param doctorID  the {@code doctorID}
     * @param patientID the {@code patientID}
     * @param examType  the {@code examType}
     * @return a {@link List} of pending {@link Exam}s from a given {@code doctorID}, {@code patientID} and {@code examType}.
     * @throws DAOException in case of a malformed input or query
     */
    Exam getPendingByDoctorPatientType(String doctorID, String patientID, Integer examType) throws DAOException;

    /**
     * Returns a {@link List} of pending {@link Exam}s from a given
     * {@code healthServiceID}, {@code patientID} and {@code examType}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     *
     * @param healthServiceID the {@code healthServiceID}
     * @param patientID       the {@code patientID}
     * @param examType        the {@code examType}
     * @return a {@link List} of pending {@link Exam}s from a given {@code healthServiceID}, {@code patientID} and {@code examType}.
     * @throws DAOException in case of a malformed input or query
     */
    Exam getPendingByHSPatientType(String healthServiceID, String patientID, Integer examType) throws DAOException;

    /**
     * Returns a {@link List} of {@link Exam}s from a given {@link Timestamp}.
     *
     * @param ts the {@link Timestamp} representing the date (discarding hours to milliseconds and considering the whole day)
     * @return a {@link List} of {@link Exam}s from a given {@link Timestamp}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getByDate(Timestamp ts) throws DAOException;

    /**
     * Returns a pending {@link Exam}, if exists, from a given {@code healthServiceID}, {@code patientID} and {@code examType}.
     * <p>
     * An {@link Exam} is considered a {@link Recall} if the column recall_id is not null
     * and points to a valid entry in the Recall table.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     *
     * @param healthServiceID the {@code healthServiceID}
     * @param patientID       the {@code patientID}
     * @param examType        the {@code examType}
     * @return a pending {@link Exam}, if exists, from a given {@code healthServiceID}, {@code patientID} and {@code examType}
     * @throws DAOException in case of a malformed input or query
     */
    Exam getPendingRecallByHSPatientType(String healthServiceID, String patientID, Integer examType) throws DAOException;
}
