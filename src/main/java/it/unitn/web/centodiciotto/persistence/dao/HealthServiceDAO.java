package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;

/**
 * The interface Health service dao.
 */
public interface HealthServiceDAO extends DAO<HealthService, String> {

    /**
     * Gets by province.
     *
     * @param provinceAbbreviation the province abbreviation
     * @return the by province
     * @throws DAOException the dao exception
     */
    HealthService getByProvince(String provinceAbbreviation) throws DAOException;
}
