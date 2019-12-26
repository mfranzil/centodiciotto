package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * {@link GeneralPractitionerDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCGeneralPractitionerDAO extends JDBCDAO<GeneralPractitioner, String> implements GeneralPractitionerDAO {

    final private String INSERT = "INSERT INTO general_practitioner " +
            "(practitioner_id, first_name, last_name, working_province, working_place) " +
            "values (?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE general_practitioner SET " +
            "(first_name, last_name, working_province, working_place) =" +
            " (?, ?, ?, ?) WHERE practitioner_id = ?;";
    final private String DELETE = "DELETE FROM general_practitioner WHERE practitioner_id = ?;";
    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM general_practitioner WHERE practitioner_id = ?;";
    final private String GET_ALL = "SELECT * FROM general_practitioner ORDER BY last_name ASC;";
    final private String COUNT = "SELECT COUNT(*) FROM general_practitioner;";
    final private String GET_BY_PROVINCE = "SELECT * FROM general_practitioner " +
            "WHERE working_province = ? ORDER BY last_name ASC;";

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
    public JDBCGeneralPractitionerDAO(Connection con) throws DAOFactoryException {
        super(con);
        provinceDAO = DAOFACTORY.getDAO(ProvinceDAO.class);
    }

    @Override
    public void insert(GeneralPractitioner generalPractitioner) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, generalPractitioner.getID());
            stm.setString(2, generalPractitioner.getFirstName());
            stm.setString(3, generalPractitioner.getLastName());
            stm.setString(4, generalPractitioner.getWorkingProvince().getID());
            stm.setString(5, generalPractitioner.getWorkingPlace());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("GeneralPractitionerDAO::insert affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error inserting GeneralPractitioner: ", e);
        }
    }

    @Override
    public void update(GeneralPractitioner generalPractitioner) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, generalPractitioner.getFirstName());
            stm.setString(2, generalPractitioner.getLastName());
            stm.setString(3, generalPractitioner.getWorkingProvince().getID());
            stm.setString(4, generalPractitioner.getWorkingPlace());
            stm.setString(5, generalPractitioner.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("GeneralPractitionerDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating GeneralPractitioner: ", e);
        }
    }

    @Override
    public void delete(GeneralPractitioner generalPractitioner) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, generalPractitioner.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("GeneralPractitionerDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting GeneralPractitioner: ", e);
        }
    }

    @Override
    public GeneralPractitioner getByPrimaryKey(String primaryKey) throws DAOException {
        GeneralPractitioner res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting GeneralPractitioner by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<GeneralPractitioner> getAll() throws DAOException {
        List<GeneralPractitioner> res = new ArrayList<>();
        GeneralPractitioner tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all GeneralPractitioners: ", e);
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
            throw new DAOException("Error counting GeneralPractitioners: ", e);
        }
        return -1L;
    }

    @Override
    public List<GeneralPractitioner> getByProvince(String provinceAbbreviation) throws DAOException {
        List<GeneralPractitioner> res = new ArrayList<>();
        GeneralPractitioner tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PROVINCE)) {
            stm.setString(1, provinceAbbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting GeneralPractitioners by Province: ", e);
        }
    }

    @Override
    protected GeneralPractitioner mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            GeneralPractitioner generalPractitioner = new GeneralPractitioner();

            Province province = provinceDAO.getByPrimaryKey(rs.getString("working_province"));

            generalPractitioner.setID(rs.getString("practitioner_id"));
            generalPractitioner.setFirstName(rs.getString("first_name"));
            generalPractitioner.setLastName(rs.getString("last_name"));
            generalPractitioner.setWorkingProvince(province);
            generalPractitioner.setWorkingPlace(rs.getString("working_place"));

            return generalPractitioner;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to GeneralPractitioner: ", e);
        }
    }
}

