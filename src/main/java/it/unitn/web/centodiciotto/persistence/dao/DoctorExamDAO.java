package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.DoctorExam;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import java.util.List;

public interface DoctorExamDAO extends DAO<DoctorExam, Pair<String, Integer>> {
    List<DoctorExam> getByExamList(ExamList examList) throws DAOException;
}
