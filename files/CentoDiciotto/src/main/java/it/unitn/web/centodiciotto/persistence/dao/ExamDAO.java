package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface ExamDAO extends DAO<Exam, Integer> {

    List<Exam> getByPatient(String PatientEmail) throws DAOException;

    List<Exam> getByPatientLastYear(String PatientEmail) throws DAOException;

}
