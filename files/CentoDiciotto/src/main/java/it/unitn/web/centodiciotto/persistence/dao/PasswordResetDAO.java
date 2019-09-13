package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.DAO;

public interface PasswordResetDAO extends DAO<PasswordReset, String> {
    /*
        void delete(User user);
    */
    void insert(PasswordReset passwordReset);

    void update(PasswordReset passwordReset);

    PasswordReset getByToken(String token);

}