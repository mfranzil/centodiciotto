package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Photo;

import java.util.List;

/**
 * The interface Photo dao.
 */
public interface PhotoDAO extends DAO<Photo, Integer> {

    /**
     * Gets current by patient.
     *
     * @param patientID the patient id
     * @return the current by patient
     * @throws DAOException the dao exception
     */
    Photo getCurrentByPatient(String patientID) throws DAOException;

    /**
     * Gets all by patient.
     *
     * @param patientID the patient id
     * @return the all by patient
     * @throws DAOException the dao exception
     */
    List<Photo> getAllByPatient(String patientID) throws DAOException;
}
