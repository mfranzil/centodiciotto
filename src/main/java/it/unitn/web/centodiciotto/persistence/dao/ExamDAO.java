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
     * Returns a {@link List} of done {@link Exam}s from a given {@code patientID}.
     * <p>
     * An {@link Exam} is considered done if the specialized doctor marked it as such.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of done {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getDoneByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of not pending {@link Exam}s from a given {@code patientID}.
     * <p>
     * An {@link Exam} is considered pending if a date hasn't been assigned yet.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of not pending {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Exam> getNotPendingByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link Exam}s from a given {@code patientID} and {@code examType}.
     *
     * @param patientID the {@code patientID}
     * @param examType    the {@code examType}
     * @return a {@link List} of {@link Exam}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    Exam getPendingByPatientAndExamType(String patientID, Integer examType) throws DAOException;

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
