package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface ChemistDAO extends DAO<Chemist, String> {

    public void insert(Chemist chemist);

    public void update(Chemist chemist);

    public void delete(Chemist chemist);

    public Chemist getByEmail(String email);

    public List<Chemist> getByProvince(String province_abbreviation);
}
