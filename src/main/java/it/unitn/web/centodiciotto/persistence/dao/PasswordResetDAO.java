package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;

public interface PasswordResetDAO extends DAO<PasswordReset, String> {

    PasswordReset getByToken(String token) throws DAOException;
}
