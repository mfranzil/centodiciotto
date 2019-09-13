package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.HealthServiceDAO;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class JDBCHealthServiceDAO extends JDBCDAO<HealthService, String> implements HealthServiceDAO {

    final private String INSERT = "INSERT INTO health_service (email, operating_province) values (?, ?);";
    final private String FINDBYEMAIL = "SELECT * FROM health_service WHERE email = ?;";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCHealthServiceDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(HealthService healthService) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, healthService.getEmail());
            preparedStatement.setString(2, healthService.getOperatingProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting Health Service: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(HealthService healthService) {

    }

    @Override
    public void delete(HealthService healthService) {

    }

    @Override
    public HealthService getByEmail(String email) {
        HealthService res;
        try(PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                     res = new HealthService(rs.getString("email"), "", rs.getString("operating_province"));
                     return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Health Service by email: " + e.getMessage());
        }
        return null;
    }

    @Override
    public Long getCount() throws DAOException {
        return null;
    }

    @Override
    public HealthService getByPrimaryKey(String primaryKey) throws DAOException {
        return null;
    }

    @Override
    public List<HealthService> getAll() throws DAOException {
        return null;
    }
}
