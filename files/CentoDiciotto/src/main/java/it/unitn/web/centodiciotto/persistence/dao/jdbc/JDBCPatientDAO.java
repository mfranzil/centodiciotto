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

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCPatientDAO extends JDBCDAO<Patient, String> implements PatientDAO {

    final private String GETBYEMAIL = "SELECT * FROM patient WHERE patient_id = ? LIMIT 1;";
    final private String INSERT = "INSERT INTO patient (patient_id, first_name, last_name, birth_date, birth_place, ssn, " +
            "gender, practitioner_id, living_province) values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String UPDATEPRACTITIONER = "UPDATE patient SET practitioner_id = ? WHERE patient_id = ?;";
    final private String SELECTALL = "SELECT * FROM patient;";
    final private String COUNT = "SELECT COUNT(*) FROM patient;";
    final private String DELETE = "DELETE FROM patient WHERE patient_id = ?;";
    final private String UPDATE = "UPDATE patient SET (first_name, last_name, birth_date, birth_place, ssn, gender, practitioner_id, living_province) = (?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE patient_id = ?;";

    final private String PATIENTSBYEMAIL = "select P.patient_id, P.first_name, P.last_name," +
            " P.birth_date, P.birth_place, P.ssn, P.gender," +
            " P.practitioner_id, P.living_province FROM patient P" +
            " INNER JOIN general_practitioner GP ON P.practitioner_id = GP.practitioner_id" +
            " WHERE GP.practitioner_id = ?;";

    public JDBCPatientDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Patient patient) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, patient.getID());
            stm.setString(2, patient.getFirstName());
            stm.setString(3, patient.getLastName());
            stm.setDate(4, patient.getBirthDate());
            stm.setString(5, patient.getBirthPlace());
            stm.setString(6, patient.getSsn());
            stm.setString(7, String.valueOf(patient.getGender()));
            stm.setString(8, patient.getPractitionerID());
            stm.setString(9, patient.getLivingProvince());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting User: ", e);
        }
    }

    @Override
    public void update(Patient patient) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, patient.getFirstName());
            stm.setString(2, patient.getLastName());
            stm.setDate(3, patient.getBirthDate());
            stm.setString(4, patient.getBirthPlace());
            stm.setString(5, patient.getSsn());
            stm.setString(6, String.valueOf(patient.getGender()));
            stm.setString(7, patient.getPractitionerID());
            stm.setString(8, patient.getLivingProvince());
            stm.setString(10, patient.getID());

            int row = stm.executeUpdate();
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
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting Patient: ", e);
        }
    }

    @Override
    public Patient getByPrimaryKey(String email) throws DAOException {
        Patient patient = null;
        try {
            PreparedStatement stm = CON.prepareStatement(GETBYEMAIL);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                patient = mapRowToEntity(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Patient by primary key: ", e);
        }
        return patient;
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
    public void updatePractitioner(Patient patient) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATEPRACTITIONER);
            stm.setString(1, patient.getPractitionerID());
            stm.setString(2, patient.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Patient: ", e);
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
            throw new DAOException("Error getting Patients by primary key: ", e);
        }
    }

    @Override
    protected Patient mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            Patient patient = new Patient();

            patient.setID(resultSet.getString("patient_id"));
            patient.setFirstName(resultSet.getString("first_name"));
            patient.setLastName(resultSet.getString("last_name"));
            patient.setBirthDate(resultSet.getDate("birth_date"));
            patient.setBirthPlace(resultSet.getString("birth_place"));
            patient.setSsn(resultSet.getString("ssn"));
            patient.setGender(resultSet.getString("gender").charAt(0));
            patient.setPractitionerID(resultSet.getString("practitioner_id"));
            patient.setLivingProvince(resultSet.getString("living_province"));

            return patient;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }
}
