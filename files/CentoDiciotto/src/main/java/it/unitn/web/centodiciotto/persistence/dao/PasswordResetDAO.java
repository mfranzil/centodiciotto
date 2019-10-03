package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface PasswordResetDAO extends DAO<PasswordReset, String> {

    void insert(PasswordReset passwordReset) throws DAOException;

    void update(PasswordReset passwordReset) throws DAOException;

    void delete(PasswordReset passwordReset) throws DAOException;

    PasswordReset getByToken(String token) throws DAOException;
}
