package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCPasswordResetDAO extends JDBCDAO<PasswordReset, String> implements PasswordResetDAO {

    final private String INSERT = "INSERT INTO password_reset (user_id, token, expiring_date) " +
            "values (?, ?, ?);";
    final private String UPDATE = "UPDATE password_reset SET token = ?, expiring_date = ? WHERE user_id = ?;";
    final private String DELETE = "DELETE from password_reset WHERE user_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM password_reset WHERE user_id = ?;";
    final private String SELECTALL = "SELECT * FROM password_reset;";
    final private String COUNT = "SELECT COUNT(*) FROM password_reset;";

    final private String FINDBYTOKEN = "SELECT * FROM password_reset WHERE token = ?;";

    public JDBCPasswordResetDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(PasswordReset passwordReset) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, passwordReset.getUserID());
            stm.setString(2, passwordReset.getToken());
            stm.setTimestamp(3, passwordReset.getExpiringDate());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting PasswordReset: ", e);
        }
    }

    @Override
    public void update(PasswordReset passwordReset) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, passwordReset.getToken());
            stm.setTimestamp(2, passwordReset.getExpiringDate());
            stm.setString(3, passwordReset.getUserID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating PasswordReset: ", e);
        }
    }

    @Override
    public void delete(PasswordReset passwordReset) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(DELETE);
            stm.setString(1, passwordReset.getUserID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting PasswordReset: ", e);
        }
    }

    @Override
    public PasswordReset getByPrimaryKey(String primaryKey) throws DAOException {
        PasswordReset res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting PasswordReset by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<PasswordReset> getAll() throws DAOException {
        List<PasswordReset> res = new ArrayList<>();
        PasswordReset tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all PasswordResets: ", e);
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
            throw new DAOException("Error counting PasswordResets: ", e);
        }
        return -1L;
    }

    @Override
    public PasswordReset getByToken(String token) throws DAOException {
        PasswordReset res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYTOKEN)) {
            stm.setString(1, token);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting PasswordReset by token: ", e);
        }
        return null;
    }

    @Override
    protected PasswordReset mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            PasswordReset passwordReset = new PasswordReset();

            passwordReset.setUserID(resultSet.getString("user_id"));
            passwordReset.setToken(resultSet.getString("token"));
            passwordReset.setExpiringDate(resultSet.getTimestamp("expiring_date"));

            return passwordReset;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to PasswordReset: ", e);
        }
    }
}
