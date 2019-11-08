package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Recall;

public interface RecallDAO extends DAO<Recall, Integer> {

    Recall getLastByHealthServiceAndExam(String healthServiceID, Integer examID) throws DAOException;
}
