package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface ChemistDAO extends DAO<Chemist, String> {

    void insert(Chemist chemist);

    void update(Chemist chemist);

    void delete(Chemist chemist);

    List<Chemist> getByProvince(String province_abbreviation);
}
