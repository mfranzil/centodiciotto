package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Recall;

import java.util.List;

/**
 * DAO interface for a {@link Recall} entity.
 */
public interface RecallDAO extends DAO<Recall, Integer> {

    /**
     * Returns the last done {@link Recall} by {@code healthServiceID} and {@code examType}.
     *
     * @param healthServiceID the {@code healthServiceID}
     * @param examType        the {@code examID}
     * @return the last done {@link Recall} by {@code healthServiceID} and {@code examType}
     * @throws DAOException in case of a malformed input or query
     */
    Recall getLastByHSAndExamType(String healthServiceID, Integer examType) throws DAOException;

    /**
     * Returns a {@link List} of {@link Recall}s from a given {@code healthServiceID}.
     *
     * @param healthServiceID the {@code healthServiceID}
     * @return a {@link List} of {@link Recall}s from a given {@code healthServiceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Recall> getByHealthService(String healthServiceID) throws DAOException;
}
