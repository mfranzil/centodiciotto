package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Patient;

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
     * Returns a {@link List} of {@link Patient}s from a given {@code provinceAbbreviation}.
     *
     * @param provinceAbbreviation the {@code provinceAbbreviation}
     * @return a {@link List} of {@link Patient}s from a given {@code provinceAbbreviation}
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByProvince(String provinceAbbreviation) throws DAOException;
}

