package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.HealthServiceDAO;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCHealthServiceDAO extends JDBCDAO<HealthService, String> implements HealthServiceDAO {

    final private String INSERT = "INSERT INTO health_service (health_service_id, operating_province) values (?, ?);";
    final private String FINDBYID = "SELECT * FROM health_service WHERE health_service_id = ?;";
    final private String SELECTALL = "SELECT * FROM health_service;";
    final private String DELETE = "DELETE FROM health_service WHERE health_service_id = ?;";
    final private String UPDATE = "UPDATE health_service SET (operating_province) = (?) WHERE health_service_id = ?;";

    public JDBCHealthServiceDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(HealthService healthService) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, healthService.getID());
            preparedStatement.setString(2, healthService.getOperatingProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Health Service: ", e);
        }
    }

    @Override
    public void update(HealthService healthService) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, healthService.getOperatingProvince());
            preparedStatement.setString(2, healthService.getID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating HealthService: ", e);
        }
    }

    @Override
    public void delete(HealthService healthService) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, healthService.getID());

            ResultSet rs = stm.executeQuery();
            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting HealthService by email: ", e);
        }
    }

    @Override
    public HealthService getByPrimaryKey(String email) throws DAOException {
        HealthService res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Health Service by email: ", e);
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
            throw new DAOException("Error counting HealthServices: ", e);
        }
        return res;
    }

    @Override
    public List<HealthService> getAll() throws DAOException {
        List<HealthService> res = new ArrayList<>();
        HealthService tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all HealthServices: ", e);
        }
    }

    @Override
    protected HealthService mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            HealthService healthService = new HealthService();

            healthService.setID(resultSet.getString("health_service_id"));
            healthService.setOperatingProvince(resultSet.getString("operating_province"));

            return healthService;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }
}

