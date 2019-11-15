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
     * Gets by practitioner.
     *
     * @param practitionerID the practitioner id
     * @return the by practitioner
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByPractitioner(String practitionerID) throws DAOException;

    /**
     * Gets by province.
     *
     * @param provinceAbbreviation the province abbreviation
     * @return the by province
     * @throws DAOException in case of a malformed input or query
     */
    List<Patient> getByProvince(String provinceAbbreviation) throws DAOException;
}

