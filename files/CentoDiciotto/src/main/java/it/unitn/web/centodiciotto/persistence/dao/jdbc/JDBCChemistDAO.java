package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ChemistDAO;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCChemistDAO extends JDBCDAO<Chemist, String> implements ChemistDAO {

    final private String INSERT = "INSERT INTO chemist (chemist_id, name, chemist_province) values (?, ?, ?);";
    final private String FINDBYID = "SELECT * FROM chemist WHERE chemist_id = ?;";
    final private String FINDBYPROVINCE = "SELECT * FROM chemist WHERE chemist_province = ?;";
    final private String SELECTALL = "SELECT * FROM chemist;";
    final private String DELETE = "DELETE FROM chemist WHERE chemist_id = ?;";
    final private String UPDATE = "UPDATE chemist SET (name, chemist_province) = (?, ?) WHERE chemist_id = ?;";

    public JDBCChemistDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Chemist chemist) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, chemist.getID());
            preparedStatement.setString(2, chemist.getName());
            preparedStatement.setString(3, chemist.getChemistProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Chemist: ", e);
        }
    }

    @Override
    public void update(Chemist chemist) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, chemist.getName());
            preparedStatement.setString(2, chemist.getChemistProvince());
            preparedStatement.setString(3, chemist.getID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Chemist: ", e);
        }
    }

    @Override
    public void delete(Chemist chemist) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, chemist.getID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Chemist by chemist_id: ", e);
        }
    }

    @Override
    public Chemist getByPrimaryKey(String chemist_id) throws DAOException {
        Chemist res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setString(1, chemist_id);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Chemist by chemist_id: ", e);
        }
        return null;
    }

    @Override
    public List<Chemist> getByProvince(String province_abbreviation) throws DAOException {
        List<Chemist> res = new ArrayList<>();
        Chemist tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPROVINCE)) {
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
    public Long getCount() throws DAOException {
        Long res = 0L;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    res++;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting Chemists: ", e);
        }
        return res;
    }

    @Override
    public List<Chemist> getAll() throws DAOException {
        List<Chemist> res;
        res = new ArrayList<>();
        Chemist tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
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
    protected Chemist mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            Chemist chemist = new Chemist();

            chemist.setID(resultSet.getString("chemist_id"));
            chemist.setName(resultSet.getString("name"));
            chemist.setChemistProvince(resultSet.getString("chemist_province"));

            return chemist;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }
}

