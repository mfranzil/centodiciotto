package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;

import java.util.List;

/**
 * The interface Chemist dao.
 */
public interface ChemistDAO extends DAO<Chemist, String> {

    /**
     * Gets by province.
     *
     * @param provinceAbbreviation the province abbreviation
     * @return the by province
     * @throws DAOException the dao exception
     */
    List<Chemist> getByProvince(String provinceAbbreviation) throws DAOException;
}
