package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface UserDAO extends DAO<User, String> {

    void insert(User user);

    void update(User user);

    void delete(User user);

    User getByEmailAndPassword(String email, String password, String role) throws DAOException;
}
