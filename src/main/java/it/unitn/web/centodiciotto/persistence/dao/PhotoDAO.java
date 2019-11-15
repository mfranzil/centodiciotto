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
     * Gets current by patient.
     *
     * @param patientID the patient id
     * @return the current by patient
     * @throws DAOException in case of a malformed input or query
     */
    Photo getCurrentByPatient(String patientID) throws DAOException;

    /**
     * Gets all by patient.
     *
     * @param patientID the patient id
     * @return the all by patient
     * @throws DAOException in case of a malformed input or query
     */
    List<Photo> getAllByPatient(String patientID) throws DAOException;
}
