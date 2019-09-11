package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface UserDAO extends DAO<User, String> {
    /*
        void delete(User user);
        User getByEmail(String email);
    */
    void insert(User user);

    void update(User user);

    User getByEmailAndPassword(String email, String password, String role) throws DAOException;
}
