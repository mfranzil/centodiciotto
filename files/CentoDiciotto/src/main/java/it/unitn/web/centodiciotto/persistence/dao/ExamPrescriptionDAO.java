package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface ExamPrescriptionDAO extends DAO<ExamPrescription, Integer> {

    void insert(ExamPrescription examPrescription);

    void update(ExamPrescription examPrescription);

    void delete(ExamPrescription examPrescription);

    List<ExamPrescription> getByPatient(String PatientEmail);

}
