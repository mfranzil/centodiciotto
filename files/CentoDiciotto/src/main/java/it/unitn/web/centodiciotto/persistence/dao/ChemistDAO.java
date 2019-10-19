package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface ChemistDAO extends DAO<Chemist, String> {

    List<Chemist> getByProvince(String provinceAbbreviation) throws DAOException;
}
