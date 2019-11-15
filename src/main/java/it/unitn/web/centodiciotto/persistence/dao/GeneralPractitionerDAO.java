package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;

import java.util.List;

/**
 * DAO interface for a {@link General practitioner} entity.
 */
public interface GeneralPractitionerDAO extends DAO<GeneralPractitioner, String> {

    /**
     * Gets by province.
     *
     * @param province_abbreviation the province abbreviation
     * @return the by province
     * @throws DAOException in case of a malformed input or query
     */
    List<GeneralPractitioner> getByProvince(String province_abbreviation) throws DAOException;
}
