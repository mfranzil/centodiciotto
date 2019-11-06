package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugListDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.DrugList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCDrugListDAO extends JDBCDAO<DrugList, Integer> implements DrugListDAO {

    final private String FINDBYPRIMARYKEY = "SELECT * FROM drug_list WHERE drug_id = ?;";
    final private String SELECTALL = "SELECT * FROM drug_list;";
    final private String COUNT = "SELECT COUNT(*) FROM drug_list;";

    public JDBCDrugListDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(DrugList drugList) throws DAOException {
        throw new DAOException("The DrugList table is read-only.");
    }

    @Override
    public void update(DrugList drugList) throws DAOException {
        throw new DAOException("The DrugList table is read-only.");
    }

    @Override
    public void delete(DrugList drugList) throws DAOException {
        throw new DAOException("The DrugList table is read-only.");
    }

    @Override
    public DrugList getByPrimaryKey(Integer primaryKey) throws DAOException {
        DrugList drugList = null;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    drugList = mapRowToEntity(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DrugList:", e);
        }
        return drugList;
    }

    @Override
    public List<DrugList> getAll() throws DAOException {
        List<DrugList> drugLists = new ArrayList<>();
        DrugList tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    drugLists.add(tmp);
                }
                return drugLists;
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
    protected DrugList mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            DrugList drugList = new DrugList();

            drugList.setID(rs.getInt("drug_id"));
            drugList.setDescription(rs.getString("drug_description"));

            return drugList;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to DrugList: ", e);
        }
    }
}
