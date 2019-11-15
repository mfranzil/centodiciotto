package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Recall;

import java.util.List;

/**
 * The interface Recall dao.
 */
public interface RecallDAO extends DAO<Recall, Integer> {

    /**
     * Gets last by health service and exam type.
     *
     * @param healthServiceID the health service id
     * @param examID          the exam id
     * @return the last by health service and exam type
     * @throws DAOException in case of a malformed input or query
     */
    Recall getLastByHealthServiceAndExamType(String healthServiceID, Integer examID) throws DAOException;

    /**
     * Gets by health service.
     *
     * @param healthServiceID the health service id
     * @return the by health service
     * @throws DAOException in case of a malformed input or query
     */
    List<Recall> getByHealthService(String healthServiceID) throws DAOException;
}
