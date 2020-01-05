package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.centodiciotto.persistence.entities.Province;

/**
 * DAO interface for a {@link HealthService} entity.
 */
public interface HealthServiceDAO extends DAO<HealthService, String> {

    /**
     * Returns the {@link HealthService} associated to a {@link Province}, indexed by this {@code provinceID}.
     *
     * @param provinceID the {@code provinceID}
     * @return the {@link HealthService} associated to a {@link Province}, indexed by this {@code provinceID}.
     * @throws DAOException in case of a malformed input or query
     */
    HealthService getByProvince(String provinceID) throws DAOException;
}
