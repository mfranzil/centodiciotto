package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOException;
import it.unitn.disi.wp.commons.persistence.dao.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class JDBCUserDAO extends JDBCDAO<User, String> implements UserDAO {

    final private String INSERT = "INSERT INTO user_ (email, password) values (?, ?);";

    public JDBCUserDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(User user) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());

            //PreparedStatement preparedStatement = conn.prepareStatement(INSERT_TEST);
            System.out.println("ok statement");

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting User: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed
    }

    @Override
    public void update(User user) {
    }

    @Override
    public void delete(User user) {
    }

    @Override
    public User getByEmail(String email) {
        return null;
    }

    public User getByEmailAndPassword(String email, String password) throws DAOException {
        if (email == null || password == null) {
            throw new DAOException("Email and password are mandatory fields",
                    new NullPointerException("email or password are null"));
        }

        try (PreparedStatement stm = CON.prepareStatement("SELECT * FROM user_ WHERE email = ? AND password = ?")) {
            stm.setString(1, email);
            stm.setString(2, password);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    User user = new User(rs.getString("email"), rs.getString("password"));
                    return user;
                }
                return null;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossible to get the list of users", ex);
        }
    }

    @Override
    public Long getCount() throws DAOException {
        return null;
    }

    @Override
    public User getByPrimaryKey(String primaryKey) throws DAOException {
        return null;
    }

    @Override
    public List<User> getAll() throws DAOException {
        return null;
    }
}
