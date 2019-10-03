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
    final private String DELETE = "DELETE FROM patient WHERE email = ?;";
    final private String UPDATE = "UPDATE patient SET (first_name, last_name, birth_date, birth_place, ssn, gender, general_practitioner_email, living_province) = (?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE email = ?;";

    public JDBCPatientDAO(Connection con) throws DAOFactoryException {
        super(con);
        //UserDAO userDAO = JDBCDAOFactory.getInstance().getDAO(UserDAO.class);
        //FRIEND_DAOS.put(UserDAO.class, userDAO);
    }

    @Override
    public void insert(Patient patient) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, patient.getEmail());
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
            preparedStatement.setString(10, patient.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Patient: ", e);
        }
    }

    @Override
    public void delete(Patient patient) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, patient.getEmail());

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
            preparedStatement.setString(2, patient.getEmail());

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
                patient = mapRowToPatient(resultSet);
                //User user = getDAO(UserDAO.class).getByPrimaryKey(email);
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving Patient: ", e);
        }
        return patient;
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
            throw new DAOException("Error counting Patients: ", e);
        }
        return res;
    }

    @Override
    public List<Patient> getAll() throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToPatient(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Patients: ", e);
        }
    }

    @Override
    public Patient mapRowToPatient(ResultSet resultSet) throws SQLException {
        return new Patient(
                resultSet.getString("email"),
                resultSet.getString("first_name"),
                resultSet.getString("last_name"),
                resultSet.getDate("birth_date"),
                resultSet.getString("birth_place"),
                resultSet.getString("ssn"),
                resultSet.getString("gender").charAt(0),
                resultSet.getString("living_province"),
                resultSet.getString("general_practitioner_email"));
    }
}
