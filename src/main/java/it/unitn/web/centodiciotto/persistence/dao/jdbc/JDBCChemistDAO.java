package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.ChemistDAO;
import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * The type Jdbc chemist dao.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCChemistDAO extends JDBCDAO<Chemist, String> implements ChemistDAO {

    final private String INSERT = "INSERT INTO chemist (chemist_id, name, chemist_province, working_place) " +
            "values (?, ?, ?, ?);";
    final private String UPDATE = "UPDATE chemist SET (name, chemist_province, working_place) = (?, ?, ?) " +
            "WHERE chemist_id = ?;";
    final private String DELETE = "DELETE FROM chemist WHERE chemist_id = ?;";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM chemist WHERE chemist_id = ?;";
    final private String GET_ALL = "SELECT * FROM chemist;";
    final private String COUNT = "SELECT COUNT(*) FROM chemist;";

    final private String GET_BY_PROVINCE = "SELECT * FROM chemist WHERE chemist_province = ?;";

    /**
     * Instantiates a new Jdbc chemist dao.
     *
     * @param con the con
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCChemistDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Chemist chemist) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, chemist.getID());
            stm.setString(2, chemist.getName());
            stm.setString(3, chemist.getProvince().getAbbreviation());
            stm.setString(4, chemist.getWorkingPlace());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"ChemistDAO::insert affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error inserting Chemist: ", e);
        }
    }

    @Override
    public void update(Chemist chemist) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, chemist.getName());
            stm.setString(2, chemist.getProvince().getAbbreviation());
            stm.setString(3, chemist.getWorkingPlace());
            stm.setString(4, chemist.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"ChemistDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating Chemist: ", e);
        }
    }

    @Override
    public void delete(Chemist chemist) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, chemist.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"ChemistDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting Chemist: ", e);
        }
    }

    @Override
    public Chemist getByPrimaryKey(String chemist_id) throws DAOException {
        Chemist res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setString(1, chemist_id);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Chemist by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<Chemist> getAll() throws DAOException {
        List<Chemist> res = new ArrayList<>();
        Chemist tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Chemists: ", e);
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
            throw new DAOException("Error counting Chemists: ", e);
        }
        return -1L;
    }

    @Override
    public List<Chemist> getByProvince(String province_abbreviation) throws DAOException {
        List<Chemist> res = new ArrayList<>();
        Chemist tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PROVINCE)) {
            stm.setString(1, province_abbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Chemist by Province: ", e);
        }
    }

    @Override
    protected Chemist mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Chemist chemist = new Chemist();

            ProvinceDAO provinceDAO = DAOFACTORY.getDAO(ProvinceDAO.class);
            Province province = provinceDAO.getByAbbreviation(rs.getString("chemist_province"));

            chemist.setID(rs.getString("chemist_id"));
            chemist.setName(rs.getString("name"));
            chemist.setProvince(province);
            chemist.setWorkingPlace(rs.getString("working_place"));

            return chemist;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to Chemist: ", e);
        }
    }
}

