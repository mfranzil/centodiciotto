package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.disi.wp.commons.persistence.dao.DAO;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.User;

public interface UserDAO extends DAO<User, String> {

    void insert(User user);

    void update(User user);

    void delete(User user);

    User getByEmail(String email);

    User getByEmailAndPassword(String email, String password, String role) throws DAOException;
}
