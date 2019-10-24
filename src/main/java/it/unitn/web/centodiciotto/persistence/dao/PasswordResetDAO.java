package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface PasswordResetDAO extends DAO<PasswordReset, String> {

    PasswordReset getByToken(String token) throws DAOException;
}
