package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface UserDAO extends DAO<User, String> {

    void insert(User user) throws DAOException;

    void update(User user) throws DAOException;

    void delete(User user) throws DAOException;
}
