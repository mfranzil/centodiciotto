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
            preparedStatement.setString(1, user.getID());
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
            preparedStatement.setString(3, user.getID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating user: ", e);
        }
    }

    @Override
    public void delete(User user) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, user.getID());

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
                    res = mapRowToEntity(rs);
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
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Users: ", e);
        }
    }

    @Override
    protected User mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            User user = new User();

            user.setID(resultSet.getString("email"));
            user.setHash(resultSet.getString("hash"));
            user.setSalt(resultSet.getString("salt"));

            return user;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }

}
