package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.util.List;

/**
 * DAO interface for a {@link Patient} entity.
 */
public interface PatientDAO extends DAO<Patient, String> {

    /**
     * Returns a {@link List} of {@link Patient}s from a given {@code practitionerID}.
     *
     * @param practitionerID the {@code practitionerID}
     * @return a {@link List} of {@link Patient}s from a given {@code practitionerID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByPractitioner(String practitionerID) throws DAOException;

    /**
     * Returns a {@link List} of {@link Patient}s from a given {@code provinceID}.
     *
     * @param provinceID the {@code provinceID}
     * @return a {@link List} of {@link Patient}s from a given {@code provinceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByProvince(String provinceID) throws DAOException;

    /**
     * Returns all the {@link Patient}s in the DB with pagination.
     *
     * @param limit       the LIMIT SQL parameter (how many {@link Patient}s should be retrieved)
     * @param offset      the OFFSET SQL parameter (from where to start retrieving {@link Patient}s)
     * @param isAscending true if {@link Patient}s shall be retrieved in ascending order (ORDER BY last_name ASC)
     * @return a {@link List} of {@link Patient}s
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getAll(Integer limit, Integer offset, Boolean isAscending) throws DAOException;

    /**
     * Returns a {@link List} of {@link Patient}s from a given {@code practitionerID} with pagination.
     *
     * @param practitionerID the {@code practitionerID}
     * @param limit          the LIMIT SQL parameter (how many {@link Patient}s should be retrieved)
     * @param offset         the OFFSET SQL parameter (from where to start retrieving {@link Patient}s)
     * @param isAscending    true if {@link Patient}s shall be retrieved in ascending order (ORDER BY last_name ASC)
     * @return a {@link List} of {@link Patient}s from a given {@code practitionerID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByPractitioner(String practitionerID, Integer limit, Integer offset, Boolean isAscending) throws DAOException;

    /**
     * Returns a {@link List} of {@link Patient}s from a given {@code provinceID} with pagination.
     *
     * @param provinceID  the {@code provinceID}
     * @param limit       the LIMIT SQL parameter (how many {@link Patient}s should be retrieved)
     * @param offset      the OFFSET SQL parameter (from where to start retrieving {@link Patient}s)
     * @param isAscending true if {@link Patient}s shall be retrieved in ascending order (ORDER BY last_name ASC)
     * @return a {@link List} of {@link Patient}s from a given {@code provinceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByProvince(String provinceID, Integer limit, Integer offset, Boolean isAscending) throws DAOException;

    /**
     * Returns the number of {@link Patient}s stored on the DB
     * picking from ones linked to a {@link GeneralPractitioner}.
     *
     * @param practitionerID the {@code practitionerID}
     * @return the number of records present into the storage system.
     * @throws DAOException in case of a malformed input or query
     */
    Long getCountByPractitioner(String practitionerID) throws DAOException;

    /**
     * Returns the number of {@link Patient}s stored on the DB
     * picking from ones linked to a {@link Province}.
     *
     * @param provinceID the {@code provinceID}
     * @return the number of records present into the storage system.
     * @throws DAOException in case of a malformed input or query
     */
    Long getCountByProvince(String provinceID) throws DAOException;


}

