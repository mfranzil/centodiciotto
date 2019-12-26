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
import java.util.HashMap;
import java.util.List;

/**
 * {@link ProvinceDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCProvinceDAO extends JDBCDAO<Province, String> implements ProvinceDAO {

    final private HashMap<String, Province> cache = new HashMap<>();

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM province WHERE province_id = ?;";
    final private String GET_ALL = "SELECT * FROM province;";
    final private String COUNT = "SELECT COUNT(*) FROM province;";

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
    public Province getByPrimaryKey(String primaryKey) throws DAOException {
        if (cache.containsKey(primaryKey)) {
            return cache.get(primaryKey);
        }

        Province province;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    province = mapRowToEntity(rs);

                    // Caching for later use (since it's read only no edits will happen)
                    if (!cache.containsKey(primaryKey)) {
                        cache.put(primaryKey, province);
                    }

                    return province;
                }
            }

        } catch (SQLException e) {
            throw new DAOException("Error getting Province by primary key: ", e);
        }
        return null;
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
    protected Province mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Province province = new Province();

            province.setID(rs.getString("province_id"));
            province.setName(rs.getString("province_name"));
            province.setRegion(rs.getString("province_region"));

            return province;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Province: ", e);
        }
    }
}
