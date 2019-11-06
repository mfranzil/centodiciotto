package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;

import java.util.List;

public interface GeneralPractitionerDAO extends DAO<GeneralPractitioner, String> {

    List<GeneralPractitioner> getByProvince(String province_abbreviation) throws DAOException;
}
