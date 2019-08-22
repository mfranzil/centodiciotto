package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.disi.wp.commons.persistence.dao.DAO;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface UserDAO extends DAO<User, String> {

    public void insert(User user);

    User update(User user) throws DAOException;

    public void delete(User user);

    public User getByEmail(String email);

    public User mapRowToUser(ResultSet rs) throws SQLException;

    public Long getCount() throws DAOException;
    public User getByPrimaryKey(String primaryKey) throws DAOException;
    public List<User> getAll() throws DAOException;

    User getByEmailAndPassword(String email, String password) throws DAOException;

    List<User> findBySearchValue(String searchValue) throws DAOException;

    List<User> pageBySearchValue(String searchValue, Long start, Long length) throws DAOException;

}
