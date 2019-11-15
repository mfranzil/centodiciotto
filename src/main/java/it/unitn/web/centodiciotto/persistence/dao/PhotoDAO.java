package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Photo;

import java.util.List;

/**
 * DAO interface for a {@link Photo} entity.
 */
public interface PhotoDAO extends DAO<Photo, Integer> {

    /**
     * Returns the current {@link Photo} associated to this {@code patientID}
     *
     * @param patientID the {@code patientID}
     * @return the current {@link Photo} associated to this {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    Photo getCurrentByPatient(String patientID) throws DAOException;

    /**
     * Returns a {@link List} of {@link Photo}s from a given {@code patientID}.
     *
     * @param patientID the {@code patientID}
     * @return a {@link List} of {@link Photo}s from a given {@code patientID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Photo> getAllByPatient(String patientID) throws DAOException;
}
