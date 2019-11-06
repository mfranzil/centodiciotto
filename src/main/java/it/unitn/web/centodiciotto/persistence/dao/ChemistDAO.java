package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;

import java.util.List;

public interface ChemistDAO extends DAO<Chemist, String> {

    List<Chemist> getByProvince(String provinceAbbreviation) throws DAOException;
}
