package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCGeneralPractitionerDAO extends JDBCDAO<GeneralPractitioner, String> implements GeneralPractitionerDAO {

    final private String INSERT = "INSERT INTO general_practitioner (email, first_name, last_name, working_province) values (?, ?, ?, ?);";
    final private String FINDBYEMAIL = "SELECT * FROM general_practitioner WHERE email = ?;";
    final private String FINDBYPROVINCE = "SELECT * FROM general_practitioner WHERE working_province = ?;";
    final private String SELECTALL = "SELECT * FROM general_practitioner;";
    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCGeneralPractitionerDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(GeneralPractitioner generalPractitioner) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, generalPractitioner.getEmail());
            preparedStatement.setString(2, generalPractitioner.getFirstName());
            preparedStatement.setString(3, generalPractitioner.getLastName());
            preparedStatement.setString(4, generalPractitioner.getWorkingProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting User: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(GeneralPractitioner generalPractitioner) {

    }

    @Override
    public void delete(GeneralPractitioner generalPractitioner) {

    }

    @Override
    public GeneralPractitioner getByPrimaryKey(String email) {
        GeneralPractitioner res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new GeneralPractitioner(rs.getString("email"), "", rs.getString("first_name"), rs.getString("last_name"), rs.getString("working_province"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting GeneralPractitioner by email: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<GeneralPractitioner> getByProvince(String province_abbreviation) {
        List<GeneralPractitioner> res = new ArrayList<GeneralPractitioner>();
        GeneralPractitioner tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPROVINCE)) {
            stm.setString(1, province_abbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new GeneralPractitioner(rs.getString("email"), "", rs.getString("first_name"), rs.getString("last_name"), rs.getString("working_province"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting GeneralPractitioners by Province: " + e.getMessage());
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
            System.err.println("Error counting GeneralPractitioners: " + e.getMessage());
        }
        return res;
    }

    @Override
    public List<GeneralPractitioner> getAll() throws DAOException {
        List<GeneralPractitioner> res = new ArrayList<GeneralPractitioner>();
        GeneralPractitioner tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new GeneralPractitioner(rs.getString("email"), "", rs.getString("first_name"), rs.getString("last_name"), rs.getString("working_province"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all GeneralPractitioners: " + e.getMessage());
        }
        return null;
    }
}

