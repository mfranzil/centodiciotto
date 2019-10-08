package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface ExamPrescriptionDAO extends DAO<ExamPrescription, Integer> {

    void insert(ExamPrescription examPrescription) throws DAOException;

    void update(ExamPrescription examPrescription) throws DAOException;

    void delete(ExamPrescription examPrescription) throws DAOException;

    List<ExamPrescription> getByPatient(String PatientEmail) throws DAOException;

}
