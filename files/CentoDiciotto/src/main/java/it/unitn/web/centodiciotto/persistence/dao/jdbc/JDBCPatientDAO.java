package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class JDBCPatientDAO extends JDBCDAO<Patient, String> implements PatientDAO {

    final private String INSERT = "INSERT INTO patient (email, first_name, last_name, birth_date, birth_place, ssn, " +
            "gender, general_practitioner_email, living_province, photo_id) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCPatientDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Patient patient) {
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
            preparedStatement.setInt(10, patient.getPhotoId());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting User: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(Patient patient) {

    }

    @Override
    public void delete(Patient patient) {

    }

    @Override
    public Patient getByPrimaryKey(String email) {
        return null;
    }

    @Override
    public Long getCount() throws DAOException {
        return null;
    }

    @Override
    public List<Patient> getAll() throws DAOException {
        return null;
    }
}
