package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface HealthServiceDAO extends DAO<HealthService, String> {

    void insert(HealthService healthService) throws DAOException;

    void update(HealthService healthService) throws DAOException;

    void delete(HealthService healthService) throws DAOException;
}
