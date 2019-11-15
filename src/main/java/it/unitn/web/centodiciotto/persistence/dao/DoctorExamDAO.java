package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.DoctorExam;
import it.unitn.web.centodiciotto.persistence.entities.ExamType;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import java.util.List;

/**
 * The interface Doctor exam dao.
 */
public interface DoctorExamDAO extends DAO<DoctorExam, Pair<String, Integer>> {
    /**
     * Gets by exam type.
     *
     * @param examType the exam type
     * @return the by exam type
     * @throws DAOException in case of a malformed input or query
     */
    List<DoctorExam> getByExamType(ExamType examType) throws DAOException;
}
