package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface ExamListDAO extends DAO<ExamList, Integer> {

    void insert(ExamList exam_list) throws DAOException;

    void update(ExamList exam_list) throws DAOException;

    void delete(ExamList exam_list) throws DAOException;
}
