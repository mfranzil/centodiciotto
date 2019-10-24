package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Province;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface ProvinceDAO extends DAO<Province, Integer> {

    Province getByAbbreviation(String provinceAbbreviation) throws DAOException;
}
