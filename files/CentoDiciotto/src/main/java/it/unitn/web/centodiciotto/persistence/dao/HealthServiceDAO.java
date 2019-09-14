package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.persistence.dao.DAO;

public interface HealthServiceDAO extends DAO<HealthService, String> {

    void insert(HealthService healthService);

    void update(HealthService healthService);

    void delete(HealthService healthService);
}
