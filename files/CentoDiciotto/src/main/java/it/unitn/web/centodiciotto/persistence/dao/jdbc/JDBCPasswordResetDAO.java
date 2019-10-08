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

public class JDBCPasswordResetDAO extends JDBCDAO<PasswordReset, String> implements PasswordResetDAO {

    final private String INSERT = "INSERT INTO password_reset (email, token, expiring_date) values (?, ?, ?);";
    final private String UPDATE = "UPDATE password_reset SET token = ?, expiring_date = ? WHERE email = ?;";
    final private String DELETE = "DELETE from password_reset WHERE email = ?;";
    final private String FINDBYPRIMARYKEY = "SELECT * FROM password_reset WHERE email = ?;";
    final private String FINDBYTOKEN = "SELECT * FROM password_reset WHERE token = ?;";
    final private String SELECTALL = "SELECT * FROM password_reset;";

    public JDBCPasswordResetDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(PasswordReset passwordReset) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, passwordReset.getEmail());
            preparedStatement.setString(2, passwordReset.getToken());
            preparedStatement.setTimestamp(3, passwordReset.getExpiringDate());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting PasswordReset: ", e);
        }
    }

    @Override
    public void update(PasswordReset passwordReset) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, passwordReset.getToken());
            preparedStatement.setTimestamp(2, passwordReset.getExpiringDate());
            preparedStatement.setString(3, passwordReset.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating PasswordReset: ", e);
        }
    }

    @Override
    public void delete(PasswordReset passwordReset) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(DELETE);
            preparedStatement.setString(1, passwordReset.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error deleting PasswordReset: ", e);
        }
    }

    @Override
    public PasswordReset getByToken(String token) throws DAOException {
        PasswordReset res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYTOKEN)) {
            stm.setString(1, token);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new PasswordReset(
                            rs.getString("email"),
                            rs.getString("token"),
                            rs.getTimestamp("expiring_date"));
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting PasswordReset by token: ", e);
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
            throw new DAOException("Error counting PasswordResets: ", e);
        }
        return res;
    }

    @Override
    public PasswordReset getByPrimaryKey(String primaryKey) throws DAOException {
        PasswordReset res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new PasswordReset(
                            rs.getString("email"),
                            rs.getString("token"),
                            rs.getTimestamp("expiring_date"));
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting PasswordReset by email: ", e);
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
                    tmp = new PasswordReset(rs.getString("email"),
                            rs.getString("token"),
                            rs.getTimestamp("expiring_date"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all PasswordResets: ", e);
        }
    }
}
