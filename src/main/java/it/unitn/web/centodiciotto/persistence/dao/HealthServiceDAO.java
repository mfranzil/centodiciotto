package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;

public interface HealthServiceDAO extends DAO<HealthService, String> {

    HealthService getByProvince(String provinceAbbreviation) throws DAOException;
}
