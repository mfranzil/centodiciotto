package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * {@link UserDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCUserDAO extends JDBCDAO<User, String> implements UserDAO {

    final private String INSERT = "INSERT INTO user_ (user_id, hash, salt) values (?, ?, ?);";
    final private String UPDATE = "UPDATE user_ SET hash = ? AND salt = ? WHERE user_id = ?;";
    final private String DELETE = "DELETE FROM user_ WHERE user_id = ?;";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM user_ WHERE user_id = ?;";
    final private String GET_ALL = "SELECT * FROM user_ ;";
    final private String COUNT = "SELECT COUNT(*) FROM user_;";

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
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
            Logger.getLogger("C18").info("UserDAO::insert affected " + row + " rows");
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
            Logger.getLogger("C18").info("UserDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating User: ", e);
        }
    }

    @Override
    public void delete(User user) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, user.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("UserDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting User: ", e);
        }
    }

    @Override
    public User getByPrimaryKey(String primaryKey) throws DAOException {
        User res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
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
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
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
