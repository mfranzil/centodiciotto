package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface ExamPrescriptionDAO extends DAO<ExamPrescription, Integer> {
    List<ExamPrescription> getByPatient(String PatientEmail) throws DAOException;

}
