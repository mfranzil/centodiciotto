package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.util.List;

/**
 * DAO interface for a {@link Chemist} entity.
 */
public interface ChemistDAO extends DAO<Chemist, String> {

    /**
     * Returns a {@link List} of {@link Chemist}s from a given {@link Province}
     *
     * @param provinceID the {@link Province} abbreviation
     * @return {@link List} of {@link Chemist}s from a given {@link Province}
     * @throws DAOException in case of a malformed input or query
     */
    List<Chemist> getByProvince(String provinceID) throws DAOException;
}
