package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * {@link ProvinceDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCProvinceDAO extends JDBCDAO<Province, Integer> implements ProvinceDAO {

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM province WHERE province_id = ?;";
    final private String GET_ALL = "SELECT * FROM province;";
    final private String COUNT = "SELECT COUNT(*) FROM province;";

    private final String GET_BY_ABBREVIATION = "SELECT * FROM province WHERE province_abbreviation = ?;";

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCProvinceDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Province province) throws DAOException {
        throw new DAOException("The Province table is read-only.");
    }

    @Override
    public void update(Province province) throws DAOException {
        throw new DAOException("The Province table is read-only.");
    }

    @Override
    public void delete(Province province) throws DAOException {
        throw new DAOException("The Province table is read-only.");
    }

    @Override
    public Province getByPrimaryKey(Integer primaryKey) throws DAOException {
        Province province = null;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setInt(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    province = mapRowToEntity(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Province:", e);
        }
        return province;
    }

    @Override
    public List<Province> getAll() throws DAOException {
        List<Province> provinces = new ArrayList<>();
        Province tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    provinces.add(tmp);
                }
                return provinces;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Provinces: ", e);
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
            throw new DAOException("Error counting Provinces: ", e);
        }
        return -1L;
    }

    @Override
    public Province getByAbbreviation(String provinceAbbreviation) throws DAOException {
        Province res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_ABBREVIATION)) {
            stm.setString(1, provinceAbbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }

        } catch (SQLException e) {
            throw new DAOException("Error getting Province by primary key: ", e);
        }
        return null;
    }

    @Override
    protected Province mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Province province = new Province();

            province.setID(rs.getInt("province_id"));
            province.setName(rs.getString("province_name"));
            province.setAbbreviation(rs.getString("province_abbreviation"));
            province.setRegion(rs.getString("province_region"));

            return province;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Province: ", e);
        }
    }
}
