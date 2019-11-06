package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Province;

public interface ProvinceDAO extends DAO<Province, Integer> {

    Province getByAbbreviation(String provinceAbbreviation) throws DAOException;
}
