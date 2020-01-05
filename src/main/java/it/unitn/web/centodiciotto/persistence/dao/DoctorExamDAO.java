package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.DoctorExam;
import it.unitn.web.centodiciotto.persistence.entities.ExamType;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import java.util.List;

/**
 * DAO interface for a {@link DoctorExam} entity.
 */
public interface DoctorExamDAO extends DAO<DoctorExam, Pair<String, Integer>> {

    /**
     * Returns a {@link List} of {@link DoctorExam}s from a given {@link ExamType}
     *
     * @param examType the {@link ExamType}
     * @return {@link List} of {@link DoctorExam}s from a given {@link ExamType}
     * @throws DAOException in case of a malformed input or query
     */
    List<DoctorExam> getByExamType(ExamType examType) throws DAOException;
}
