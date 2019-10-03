package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
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
    final private String PATIENTSBYEMAIL = "select * FROM patient JOIN general_practitioner ON patient.general_practitioner_email=general_practitioner.email WHERE general_practitioner.email=?;";
    final private String FINDBYPROVINCE = "SELECT * FROM general_practitioner WHERE working_province = ?;";
    final private String SELECTALL = "SELECT * FROM general_practitioner;";
    final private String DELETE = "DELETE FROM general_practitioner WHERE email = ?;";
    final private String UPDATE = "UPDATE general_practitioner SET (first_name, last_name, working_province) = (?, ?, ?) WHERE email = ?;";
    public JDBCGeneralPractitionerDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(GeneralPractitioner generalPractitioner) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, generalPractitioner.getEmail());
            preparedStatement.setString(2, generalPractitioner.getFirstName());
            preparedStatement.setString(3, generalPractitioner.getLastName());
            preparedStatement.setString(4, generalPractitioner.getWorkingProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting User: ", e);
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(GeneralPractitioner generalPractitioner) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, generalPractitioner.getFirstName());
            preparedStatement.setString(2, generalPractitioner.getLastName());
            preparedStatement.setString(3, generalPractitioner.getWorkingProvince());
            preparedStatement.setString(4, generalPractitioner.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating GeneralPractitioner: ", e);
        }
    }

    @Override
    public void delete(GeneralPractitioner generalPractitioner) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, generalPractitioner.getEmail());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting GeneralPractitioner by email: ", e);
        }
    }

    @Override
    public GeneralPractitioner getByPrimaryKey(String email) throws DAOException {
        GeneralPractitioner res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new GeneralPractitioner(
                            rs.getString("email"),
                            "",
                            "",
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getString("working_province"));
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting GeneralPractitioner by email: ", e);
        }
        return null;
    }

    @Override
    public List<GeneralPractitioner> getByProvince(String province_abbreviation) throws DAOException {
        List<GeneralPractitioner> res = new ArrayList<>();
        GeneralPractitioner tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPROVINCE)) {
            stm.setString(1, province_abbreviation);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new GeneralPractitioner(rs.getString("email"), "", "", rs.getString("first_name"), rs.getString("last_name"), rs.getString("working_province"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting GeneralPractitioners by Province: ", e);
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
            throw new DAOException("Error counting GeneralPractitioners: ", e);
        }
        return res;
    }

    @Override
    public List<GeneralPractitioner> getAll() throws DAOException {
        List<GeneralPractitioner> res = new ArrayList<>();
        GeneralPractitioner tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new GeneralPractitioner(rs.getString("email"), "", "", rs.getString("first_name"), rs.getString("last_name"), rs.getString("working_province"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all GeneralPractitioners: ", e);
        }
    }

    public List<Patient> getPatientsByPractitionerId(String email) throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(PATIENTSBYEMAIL)) {
            //1 corrisponde al primo punto di domanda nella query (il primo punto sara la mail)
            stm.setString(1, email);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Patient(rs.getString(1), "", "", rs.getString(2), rs.getString(3), rs.getDate(4), rs.getString(5), rs.getString(6), rs.getString(7).charAt(0), rs.getString(8), rs.getString(9));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Patients by email: ", e);
        }
    }
}

