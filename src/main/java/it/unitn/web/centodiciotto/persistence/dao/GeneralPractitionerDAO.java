package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface GeneralPractitionerDAO extends DAO<GeneralPractitioner, String> {

    List<GeneralPractitioner> getByProvince(String province_abbreviation) throws DAOException;
}
