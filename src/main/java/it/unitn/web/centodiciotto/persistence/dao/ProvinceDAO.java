package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Province;

/**
 * DAO interface for a {@link Province} entity.
 */
public interface ProvinceDAO extends DAO<Province, Integer> {

    /**
     * Returns the {@link Province} indexed by this {@code provinceAbbreviation}.
     *
     * @param provinceAbbreviation the {@code provinceAbbreviation}
     * @return the {@link Province} indexed by this {@code provinceAbbreviation}
     * @throws DAOException in case of a malformed input or query
     */
    Province getByAbbreviation(String provinceAbbreviation) throws DAOException;
}
