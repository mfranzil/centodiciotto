package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface ChemistDAO extends DAO<Chemist, String> {

    void insert(Chemist chemist) throws DAOException;

    void update(Chemist chemist) throws DAOException;

    void delete(Chemist chemist) throws DAOException;

    List<Chemist> getByProvince(String province_abbreviation) throws DAOException;
}
