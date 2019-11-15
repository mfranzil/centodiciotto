package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;

/**
 * The interface Password reset dao.
 */
public interface PasswordResetDAO extends DAO<PasswordReset, String> {

    /**
     * Gets by token.
     *
     * @param token the token
     * @return the by token
     * @throws DAOException in case of a malformed input or query
     */
    PasswordReset getByToken(String token) throws DAOException;
}
