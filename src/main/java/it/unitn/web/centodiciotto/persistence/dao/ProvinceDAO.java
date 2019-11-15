package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Province;

/**
 * The interface Province dao.
 */
public interface ProvinceDAO extends DAO<Province, Integer> {

    /**
     * Gets by abbreviation.
     *
     * @param provinceAbbreviation the province abbreviation
     * @return the by abbreviation
     * @throws DAOException the dao exception
     */
    Province getByAbbreviation(String provinceAbbreviation) throws DAOException;
}
