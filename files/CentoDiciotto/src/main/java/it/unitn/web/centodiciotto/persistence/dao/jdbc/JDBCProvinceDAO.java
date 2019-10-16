package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.entities.Province;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCProvinceDAO extends JDBCDAO<Province, Integer> implements ProvinceDAO {
    final private String FINDBYPRIMARYKEY = "SELECT * FROM province WHERE id_province = ?;";
    final private String SELECTALL = "SELECT * FROM province;";
    private final String GETBYABBREVIATION = "SELECT * FROM province WHERE province_abbreviation = ?;";

    public JDBCProvinceDAO(Connection con) {
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
    public Province getByAbbreviation(String provinceAbbreviation) throws DAOException {
        Province res;
        try (PreparedStatement stm = CON.prepareStatement(GETBYABBREVIATION)) {
            stm.setString(1, provinceAbbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }

        } catch (SQLException e) {
            throw new DAOException("Error getting Province by ID: ", e);
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
            throw new DAOException("Error counting Provinces: ", e);
        }
        return res;
    }

    @Override
    public List<Province> getAll() throws DAOException {
        List<Province> provinces = new ArrayList<>();
        Province tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
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
    public Province getByPrimaryKey(Integer primaryKey) throws DAOException {
        Province province = null;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
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
    protected Province mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Province province = new Province();

            province.setProvinceID(rs.getInt("id_province"));
            province.setProvinceName(rs.getString("province_name"));
            province.setProvinceAbbreviation(rs.getString("province_abbreviation"));
            province.setProvinceRegion(rs.getString("province_region"));

            return province;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Province: ", e);
        }
    }
}
