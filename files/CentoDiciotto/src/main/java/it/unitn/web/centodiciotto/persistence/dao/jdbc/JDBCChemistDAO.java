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

    final private String INSERT = "INSERT INTO chemist (email, name, chemist_province) values (?, ?, ?);";
    final private String FINDBYEMAIL = "SELECT * FROM chemist WHERE email = ?;";
    final private String FINDBYPROVINCE = "SELECT * FROM chemist WHERE chemist_province = ?;";
    final private String SELECTALL = "SELECT * FROM chemist;";
    final private String DELETE = "DELETE FROM chemist WHERE email = ?;";
    final private String UPDATE = "UPDATE chemist SET (name, chemist_province) = (?, ?) WHERE email = ?;";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCChemistDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Chemist chemist) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, chemist.getEmail());
            preparedStatement.setString(2, chemist.getName());
            preparedStatement.setString(3, chemist.getChemistProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting Chemist: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(Chemist chemist) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, chemist.getName());
            preparedStatement.setString(2, chemist.getChemistProvince());
            preparedStatement.setString(3, chemist.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating Chemist: " + e.getMessage());
        }
    }

    @Override
    public void delete(Chemist chemist) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, chemist.getEmail());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting Chemist by email: " + e.getMessage());
        };
    }

    @Override
    public Chemist getByPrimaryKey(String email) {
        Chemist res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new Chemist(rs.getString("email"), "", rs.getString("name"), rs.getString("chemist_province"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Chemist by email: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Chemist> getByProvince(String province_abbreviation) {
        List<Chemist> res = new ArrayList<Chemist>();
        Chemist tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPROVINCE)) {
            stm.setString(1, province_abbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Chemist(rs.getString("email"), "", rs.getString("name"), rs.getString("chemist_province"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting Chemist by Province: " + e.getMessage());
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
            System.err.println("Error counting Chemists: " + e.getMessage());
        }
        return res;
    }

    @Override
    public List<Chemist> getAll() throws DAOException {
        List<Chemist> res = new ArrayList<Chemist>();
        Chemist tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Chemist(rs.getString("email"), "", rs.getString("name"), rs.getString("chemist_province"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all Chemists: " + e.getMessage());
        }
        return null;
    }
}

