package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface HealthServiceDAO extends DAO<HealthService, String> {

    public void insert(HealthService healthService);

    public void update(HealthService healthService);

    public void delete(HealthService healthService);

    public HealthService getByEmail(String email);
}
