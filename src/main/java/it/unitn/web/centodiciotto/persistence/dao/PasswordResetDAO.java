package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;

/**
 * DAO interface for a {@link PasswordReset} entity.
 */
public interface PasswordResetDAO extends DAO<PasswordReset, String> {

    /**
     * Returns the {@link PasswordReset} associated to this {@code token}.
     *
     * @param token the {@code token}
     * @return the {@link PasswordReset} associated to this {@code token}
     * @throws DAOException in case of a malformed input or query
     */
    PasswordReset getByToken(String token) throws DAOException;
}
