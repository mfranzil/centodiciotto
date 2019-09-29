package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface ExamDAO extends DAO<Exam, Integer> {

    void insert(Exam exam);

    void update(Exam exam);

    void delete(Exam exam);

    List<Exam> getByPatient(String PatientEmail);

}
