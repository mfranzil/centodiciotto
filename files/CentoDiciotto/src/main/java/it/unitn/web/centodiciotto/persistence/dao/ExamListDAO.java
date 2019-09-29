package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface ExamListDAO extends DAO<ExamList, Integer> {

    void insert(ExamList exam_list);

    void update(ExamList exam_list);

    void delete(ExamList exam_list);
}
