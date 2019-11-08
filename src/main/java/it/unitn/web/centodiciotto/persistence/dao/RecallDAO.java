package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Recall;

import java.util.List;

public interface RecallDAO extends DAO<Recall, Integer> {

    Recall getLastByHealthServiceAndExam(String healthServiceID, Integer examID) throws DAOException;

    List<Recall> getByHealthService(String healthServiceID) throws DAOException;
}
