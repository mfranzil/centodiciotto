package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Exam;

import java.sql.Timestamp;
import java.util.List;

public interface ExamDAO extends DAO<Exam, Integer> {

    List<Exam> getByPatient(String patientID) throws DAOException;

    List<Exam> getByPatientLastYear(String patientID) throws DAOException;

    List<Exam> getByPatientNotPaid(String patientID) throws DAOException;

    List<Exam> getPendingByPatientNotBooked(String patientID) throws DAOException;

    List<Exam> getPendingByPatientDoctorNotSelected(String patientID) throws DAOException;

    List<Exam> getByDate(Timestamp ts) throws DAOException;

    List<Exam> getRecallsByHealthService(String healthServiceID) throws DAOException;

    Exam getPendingRecall(Integer examType, String healthServiceID, String patientID) throws DAOException;
}
