package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCUserDAO extends JDBCDAO<User, String> implements UserDAO {

    final private String INSERT = "INSERT INTO user_ (email, hash, salt) values (?, ?, ?);";
    final private String UPDATE = "UPDATE user_ SET hash = ? AND salt = ? WHERE email = ?;";
    final private String FINDBYPRIMARYKEY = "SELECT * FROM user_ WHERE email = ?;";
    final private String SELECTALL = "SELECT * FROM user_;";
    final private String DELETE = "DELETE FROM user_ WHERE email = ?;";

    public JDBCUserDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(User user) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getHash());
            preparedStatement.setString(3, user.getSalt());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting user: ", e);
        }
    }

    @Override
    public void update(User user) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, user.getHash());
            preparedStatement.setString(2, user.getSalt());
            preparedStatement.setString(3, user.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating user: ", e);
        }
    }

    @Override
    public void delete(User user) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, user.getEmail());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting User by email: ", e);
        }
    }

    @Override
    public User getByPrimaryKey(String primaryKey) throws DAOException {
        User res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new User(
                            rs.getString("email"),
                            rs.getString("hash"),
                            rs.getString("salt"));
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting User by email: ", e);
        }
        return null;
    }

    @Override
    public Long getCount() throws DAOException {
        Long res = 0L;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    res++;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting Users: ", e);
        }
        return res;
    }

    @Override
    public List<User> getAll() throws DAOException {
        List<User> res = new ArrayList<>();
        User tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new User(rs.getString("email"), rs.getString("hash"), rs.getString("salt"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Users: ", e);
        }
    }
}
