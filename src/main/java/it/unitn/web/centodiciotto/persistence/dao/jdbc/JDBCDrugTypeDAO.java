package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.DrugType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCDrugTypeDAO extends JDBCDAO<DrugType, Integer> implements DrugTypeDAO {

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM drug_type WHERE drug_id = ?;";
    final private String GET_ALL = "SELECT * FROM drug_type;";
    final private String COUNT = "SELECT COUNT(*) FROM drug_type;";

    public JDBCDrugTypeDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(DrugType drugType) throws DAOException {
        throw new DAOException("The DrugType table is read-only.");
    }

    @Override
    public void update(DrugType drugType) throws DAOException {
        throw new DAOException("The DrugType table is read-only.");
    }

    @Override
    public void delete(DrugType drugType) throws DAOException {
        throw new DAOException("The DrugType table is read-only.");
    }

    @Override
    public DrugType getByPrimaryKey(Integer primaryKey) throws DAOException {
        DrugType drugType = null;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setInt(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    drugType = mapRowToEntity(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DrugType:", e);
        }
        return drugType;
    }

    @Override
    public List<DrugType> getAll() throws DAOException {
        List<DrugType> drugTypes = new ArrayList<>();
        DrugType tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    drugTypes.add(tmp);
                }
                return drugTypes;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all DrugLists: ", e);
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
            throw new DAOException("Error counting DrugLists: ", e);
        }
        return -1L;
    }

    @Override
    protected DrugType mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            DrugType drugType = new DrugType();

            drugType.setID(rs.getInt("drug_id"));
            drugType.setDescription(rs.getString("drug_description"));

            return drugType;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to DrugType: ", e);
        }
    }
}
