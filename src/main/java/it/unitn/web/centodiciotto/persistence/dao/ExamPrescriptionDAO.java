package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;

import java.util.List;

public interface ExamPrescriptionDAO extends DAO<ExamPrescription, Integer> {
    List<ExamPrescription> getByPatient(String PatientID) throws DAOException;

    List<ExamPrescription> getByPatientNotBooked(String PatientID) throws DAOException;
}
