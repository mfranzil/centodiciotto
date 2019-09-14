package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class JDBCPasswordResetDAO extends JDBCDAO<PasswordReset, String> implements PasswordResetDAO {

    final private String INSERT = "INSERT INTO password_reset (email, token, expiring_date) values (?, ?, ?);";
    final private String UPDATE = "UPDATE password_reset SET token = ?, expiring_date = ? WHERE email = ?;";
    final private String FINDBYPRIMARYKEY = "SELECT * FROM password_reset WHERE email = ?;";
    final private String FINDBYTOKEN = "SELECT * FROM password_reset WHERE token = ?;";

    public JDBCPasswordResetDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(PasswordReset passwordReset) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, passwordReset.getEmail());
            preparedStatement.setString(2, passwordReset.getToken());
            preparedStatement.setDate(3, passwordReset.getExpiringDate());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting PasswordReset: " + e.getMessage());
        }
    }

    @Override
    public void update(PasswordReset passwordReset) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, passwordReset.getToken());
            preparedStatement.setDate(2, passwordReset.getExpiringDate());
            preparedStatement.setString(3, passwordReset.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating PasswordReset: " + e.getMessage());
        }
    }

    @Override
    public void delete(PasswordReset passwordReset) {
    }

    @Override
    public PasswordReset getByToken(String token) {
        PasswordReset res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYTOKEN)) {
            stm.setString(1, token);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new PasswordReset(
                            rs.getString("email"),
                            rs.getString("token"),
                            rs.getDate("expiring_date"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting PasswordReset by token: " + e.getMessage());
        }
        return null;
    }

    @Override
    public Long getCount() throws DAOException {
        return null;
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
                            rs.getDate("expiring_date"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting PasswordReset by email: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<PasswordReset> getAll() throws DAOException {
        return null;
    }
}
