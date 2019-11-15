package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Exam;

import java.sql.Timestamp;
import java.util.List;

/**
 * The interface Exam dao.
 */
public interface ExamDAO extends DAO<Exam, Integer> {

    /**
     * Gets by patient.
     *
     * @param patientID the patient id
     * @return the by patient
     * @throws DAOException the dao exception
     */
    List<Exam> getByPatient(String patientID) throws DAOException;

    /**
     * Gets by patient last year.
     *
     * @param patientID the patient id
     * @return the by patient last year
     * @throws DAOException the dao exception
     */
    List<Exam> getByPatientLastYear(String patientID) throws DAOException;

    /**
     * Gets unpaid by patient.
     *
     * @param patientID the patient id
     * @return the unpaid by patient
     * @throws DAOException the dao exception
     */
    List<Exam> getUnpaidByPatient(String patientID) throws DAOException;

    /**
     * Gets not pending by patient.
     *
     * @param patientID the patient id
     * @return the not pending by patient
     * @throws DAOException the dao exception
     */
    List<Exam> getNotPendingByPatient(String patientID) throws DAOException;

    /**
     * Gets pending by patient.
     *
     * @param patientID the patient id
     * @return the pending by patient
     * @throws DAOException the dao exception
     */
    List<Exam> getPendingByPatient(String patientID) throws DAOException;

    /**
     * Gets pending by patient and exam type.
     *
     * @param patientID the patient id
     * @param examID    the exam id
     * @return the pending by patient and exam type
     * @throws DAOException the dao exception
     */
    Exam getPendingByPatientAndExamType(String patientID, Integer examID) throws DAOException;

    /**
     * Gets pending by patient doctor health service not selected.
     *
     * @param patientID the patient id
     * @return the pending by patient doctor health service not selected
     * @throws DAOException the dao exception
     */
    List<Exam> getPendingByPatientDoctorHealthServiceNotSelected(String patientID) throws DAOException;

    /**
     * Gets pending by doctor.
     *
     * @param doctorID the doctor id
     * @return the pending by doctor
     * @throws DAOException the dao exception
     */
    List<Exam> getPendingByDoctor(String doctorID) throws DAOException;

    /**
     * Gets booked by doctor.
     *
     * @param doctorID the doctor id
     * @return the booked by doctor
     * @throws DAOException the dao exception
     */
    List<Exam> getBookedByDoctor(String doctorID) throws DAOException;

    /**
     * Gets done by doctor.
     *
     * @param doctorID the doctor id
     * @return the done by doctor
     * @throws DAOException the dao exception
     */
    List<Exam> getDoneByDoctor(String doctorID) throws DAOException;

    /**
     * Gets pending by hs.
     *
     * @param healthServiceID the health service id
     * @return the pending by hs
     * @throws DAOException the dao exception
     */
    List<Exam> getPendingByHS(String healthServiceID) throws DAOException;

    /**
     * Gets booked by hs.
     *
     * @param healthServiceID the health service id
     * @return the booked by hs
     * @throws DAOException the dao exception
     */
    List<Exam> getBookedByHS(String healthServiceID) throws DAOException;

    /**
     * Gets done by hs.
     *
     * @param healthServiceID the health service id
     * @return the done by hs
     * @throws DAOException the dao exception
     */
    List<Exam> getDoneByHS(String healthServiceID) throws DAOException;

    /**
     * Gets pending by doctor and patient.
     *
     * @param doctorID  the doctor id
     * @param patientID the patient id
     * @param examID    the exam id
     * @return the pending by doctor and patient
     * @throws DAOException the dao exception
     */
    Exam getPendingByDoctorAndPatient(String doctorID, String patientID, Integer examID) throws DAOException;

    /**
     * Gets pending by hs and patient.
     *
     * @param healthServiceID the health service id
     * @param patientID       the patient id
     * @param examID          the exam id
     * @return the pending by hs and patient
     * @throws DAOException the dao exception
     */
    Exam getPendingByHSAndPatient(String healthServiceID, String patientID, Integer examID) throws DAOException;

    /**
     * Gets by date.
     *
     * @param ts the ts
     * @return the by date
     * @throws DAOException the dao exception
     */
    List<Exam> getByDate(Timestamp ts) throws DAOException;

    /**
     * Gets pending recall.
     *
     * @param examType        the exam type
     * @param healthServiceID the health service id
     * @param patientID       the patient id
     * @return the pending recall
     * @throws DAOException the dao exception
     */
    Exam getPendingRecall(Integer examType, String healthServiceID, String patientID) throws DAOException;
}
