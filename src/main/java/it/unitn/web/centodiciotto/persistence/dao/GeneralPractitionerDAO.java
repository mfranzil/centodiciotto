package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;

import java.util.List;

/**
 * DAO interface for a {@link GeneralPractitioner} entity.
 */
public interface GeneralPractitionerDAO extends DAO<GeneralPractitioner, String> {

    /**
     * Returns a {@link List} of {@link GeneralPractitioner}s from a given {@code provinceID}.
     *
     * @param provinceID the {@code provinceID}
     * @return a {@link List} of {@link GeneralPractitioner}s from a given {@code provinceID}
     * @throws DAOException in case of a malformed input or query
     */
    List<GeneralPractitioner> getByProvince(String provinceID) throws DAOException;
}
