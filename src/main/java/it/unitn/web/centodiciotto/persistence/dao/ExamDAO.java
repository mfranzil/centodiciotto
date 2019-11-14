package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Exam;

import java.sql.Timestamp;
import java.util.List;

public interface ExamDAO extends DAO<Exam, Integer> {

    List<Exam> getByPatient(String patientID) throws DAOException;

    List<Exam> getByPatientLastYear(String patientID) throws DAOException;

    List<Exam> getUnpaidByPatient(String patientID) throws DAOException;

    List<Exam> getNotPendingByPatient(String patientID) throws DAOException;

    List<Exam> getPendingByPatient(String patientID) throws DAOException;

    Exam getPendingByPatientAndExamType(String patientID, Integer examID) throws DAOException;

    List<Exam> getPendingByPatientDoctorHealthServiceNotSelected(String patientID) throws DAOException;

    List<Exam> getPendingByDoctor(String doctorID) throws DAOException;

    List<Exam> getBookedByDoctor(String doctorID) throws DAOException;

    List<Exam> getDoneByDoctor(String doctorID) throws DAOException;

    List<Exam> getPendingByHS(String healthServiceID) throws DAOException;

    List<Exam> getBookedByHS(String healthServiceID) throws DAOException;

    List<Exam> getDoneByHS(String healthServiceID) throws DAOException;

    Exam getPendingByDoctorAndPatient(String doctorID, String patientID, Integer examID) throws DAOException;

    Exam getPendingByHSAndPatient(String healthServiceID, String patientID, Integer examID) throws DAOException;

    List<Exam> getByDate(Timestamp ts) throws DAOException;

    Exam getPendingRecall(Integer examType, String healthServiceID, String patientID) throws DAOException;
}
