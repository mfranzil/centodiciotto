package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCUserDAO extends JDBCDAO<User, String> implements UserDAO {

    final private String INSERT = "INSERT INTO user_ (user_id, hash, salt) values (?, ?, ?);";
    final private String UPDATE = "UPDATE user_ SET hash = ? AND salt = ? WHERE user_id = ?;";
    final private String DELETE = "DELETE FROM user_ WHERE user_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM user_ WHERE user_id = ?;";
    final private String SELECTALL = "SELECT * FROM user_;";
    final private String COUNT = "SELECT COUNT(*) FROM user_;";

    public JDBCUserDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(User user) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, user.getID());
            stm.setString(2, user.getHash());
            stm.setString(3, user.getSalt());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting User: ", e);
        }
    }

    @Override
    public void update(User user) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, user.getHash());
            stm.setString(2, user.getSalt());
            stm.setString(3, user.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating User: ", e);
        }
    }

    @Override
    public void delete(User user) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, user.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting User: ", e);
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
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting User by primary key: ", e);
        }
        return null;
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
    public Long getCount() throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(COUNT)) {
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return Integer.toUnsignedLong(rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting Users: ", e);
        }
        return -1L;
    }

    @Override
    protected User mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            User user = new User();

            user.setID(rs.getString("user_id"));
            user.setHash(rs.getString("hash"));
            user.setSalt(rs.getString("salt"));

            return user;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to User: ", e);
        }
    }

}