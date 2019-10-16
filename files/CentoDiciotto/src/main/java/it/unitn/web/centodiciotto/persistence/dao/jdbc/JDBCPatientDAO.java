package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCPatientDAO extends JDBCDAO<Patient, String> implements PatientDAO {

    final private String GETBYEMAIL = "SELECT * FROM patient WHERE email = ? LIMIT 1;";
    final private String INSERT = "INSERT INTO patient (email, first_name, last_name, birth_date, birth_place, ssn, " +
            "gender, general_practitioner_email, living_province) values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String UPDATEPRACTITIONER = "UPDATE patient SET general_practitioner_email = ? WHERE email = ?;";
    final private String SELECTALL = "SELECT * FROM patient;";
    final private String COUNT = "SELECT COUNT(*) FROM patient;";
    final private String DELETE = "DELETE FROM patient WHERE email = ?;";
    final private String UPDATE = "UPDATE patient SET (first_name, last_name, birth_date, birth_place, ssn, gender, general_practitioner_email, living_province) = (?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE email = ?;";
    final private String PATIENTSBYEMAIL = "select general_practitioner.email, general_practitioner.first_name, " +
            "general_practitioner.last_name, general_practitioner.working_province FROM patient JOIN general_practitioner ON " +
            "patient.general_practitioner_email = general_practitioner.email WHERE general_practitioner.email = ?;";

    public JDBCPatientDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Patient patient) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, patient.getID());
            preparedStatement.setString(2, patient.getFirstName());
            preparedStatement.setString(3, patient.getLastName());
            preparedStatement.setDate(4, patient.getBirthDate());
            preparedStatement.setString(5, patient.getBirthPlace());
            preparedStatement.setString(6, patient.getSsn());
            preparedStatement.setString(7, String.valueOf(patient.getGender()));
            preparedStatement.setString(8, patient.getGeneralPractitionerEmail());
            preparedStatement.setString(9, patient.getLivingProvince());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting User: ", e);
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(Patient patient) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, patient.getFirstName());
            preparedStatement.setString(2, patient.getLastName());
            preparedStatement.setDate(3, patient.getBirthDate());
            preparedStatement.setString(4, patient.getBirthPlace());
            preparedStatement.setString(5, patient.getSsn());
            preparedStatement.setString(6, String.valueOf(patient.getGender()));
            preparedStatement.setString(7, patient.getGeneralPractitionerEmail());
            preparedStatement.setString(8, patient.getLivingProvince());
            preparedStatement.setString(10, patient.getID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Patient: ", e);
        }
    }

    @Override
    public void delete(Patient patient) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, patient.getID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Patient by email: ", e);
        }
    }

    @Override
    public void updatePractitioner(Patient patient) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATEPRACTITIONER);
            preparedStatement.setString(1, patient.getGeneralPractitionerEmail());
            preparedStatement.setString(2, patient.getID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating user: ", e);
        }
    }

    @Override
    public Patient getByPrimaryKey(String email) throws DAOException {
        Patient patient = null;
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(GETBYEMAIL);
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                patient = mapRowToEntity(resultSet);
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving Patient: ", e);
        }
        return patient;
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
            throw new DAOException("Error counting Patients: ", e);
        }
        return -1L;
    }

    @Override
    public List<Patient> getAll() throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Patients: ", e);
        }
    }

    public List<Patient> getPatientsByPractitionerId(String email) throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(PATIENTSBYEMAIL)) {
            stm.setString(1, email);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Patients by email: ", e);
        }
    }

    @Override
    protected Patient mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            Patient patient = new Patient();

            patient.setID(resultSet.getString("email"));
            patient.setFirstName(resultSet.getString("first_name"));
            patient.setLastName(resultSet.getString("last_name"));
            patient.setBirthDate(resultSet.getDate("birth_date"));
            patient.setBirthPlace(resultSet.getString("birth_place"));
            patient.setSsn(resultSet.getString("ssn"));
            patient.setGender(resultSet.getString("gender").charAt(0));
            patient.setGeneralPractitionerEmail(resultSet.getString("general_practitioner_email"));
            patient.setLivingProvince(resultSet.getString("living_province"));

            return patient;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }
}
