package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.HealthServiceDAO;
import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * {@link HealthServiceDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCHealthServiceDAO extends JDBCDAO<HealthService, String> implements HealthServiceDAO {

    final private String INSERT = "INSERT INTO health_service (health_service_id, operating_province) " +
            "values (?, ?);";
    final private String UPDATE = "UPDATE health_service SET (operating_province) = (?) " +
            "WHERE health_service_id = ?;";
    final private String DELETE = "DELETE FROM health_service WHERE health_service_id = ?;";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM health_service WHERE health_service_id = ?;";
    final private String GET_ALL = "SELECT * FROM health_service;";
    final private String COUNT = "SELECT COUNT(*) FROM health_service;";

    final private String GET_BY_PROVINCE = "SELECT *  FROM health_service WHERE operating_province = ?;";

    /**
     * Friend DAO saved for optimization purposes (since invoking DAOFactory is slow)
     */
    private ProvinceDAO provinceDAO;

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCHealthServiceDAO(Connection con) throws DAOFactoryException {

        super(con);
        provinceDAO = DAOFACTORY.getDAO(ProvinceDAO.class);
    }

    @Override
    public void insert(HealthService healthService) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, healthService.getID());
            stm.setString(2, healthService.getOperatingProvince().getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("HealthServiceDAO::insert affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error inserting Health Service: ", e);
        }
    }

    @Override
    public void update(HealthService healthService) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, healthService.getOperatingProvince().getID());
            stm.setString(2, healthService.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("HealthServiceDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating HealthService: ", e);
        }
    }

    @Override
    public void delete(HealthService healthService) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, healthService.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("HealthServiceDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting HealthService: ", e);
        }
    }

    @Override
    public HealthService getByPrimaryKey(String primaryKey) throws DAOException {
        HealthService res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Health Service by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<HealthService> getAll() throws DAOException {
        List<HealthService> res = new ArrayList<>();
        HealthService tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
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
    public Long getCount() throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(COUNT)) {
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return Integer.toUnsignedLong(rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting HealthServices: ", e);
        }
        return -1L;
    }

    public HealthService getByProvince(String provinceAbbreviation) throws DAOException {
        HealthService res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PROVINCE)) {
            stm.setString(1, provinceAbbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Health Service by province: ", e);
        }
        return null;
    }

    @Override
    protected HealthService mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            HealthService healthService = new HealthService();

            Province province = provinceDAO.getByPrimaryKey(rs.getString("operating_province"));

            healthService.setID(rs.getString("health_service_id"));
            healthService.setOperatingProvince(province);

            return healthService;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to HealthService: ", e);
        }
    }
}

