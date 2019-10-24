package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface ExamDAO extends DAO<Exam, Integer> {

    List<Exam> getByPatient(String patientEmail) throws DAOException;

    List<Exam> getByPatientLastYear(String patientEmail) throws DAOException;

    List<Exam> getByPatientNotPaid(String patientEmail) throws DAOException;

}
