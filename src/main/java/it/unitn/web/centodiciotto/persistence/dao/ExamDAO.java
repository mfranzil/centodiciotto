package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.sql.Timestamp;
import java.util.List;

public interface ExamDAO extends DAO<Exam, Integer> {

    List<Exam> getByPatient(String patientID) throws DAOException;

    List<Exam> getByPatientLastYear(String patientID) throws DAOException;

    List<Exam> getByPatientNotPaid(String patientID) throws DAOException;

    List<Exam> getByDate(Timestamp ts) throws DAOException;

}
