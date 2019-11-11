package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.ProvinceDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Province;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCPatientDAO extends JDBCDAO<Patient, String> implements PatientDAO {

    final private String INSERT = "INSERT INTO patient" +
            "(patient_id, first_name, last_name, birth_date, birth_place, " +
            "ssn, gender, practitioner_id, living_province, living_place)" +
            " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE patient SET" +
            " (first_name, last_name, birth_date, birth_place," +
            " ssn, gender, practitioner_id, living_province, living_place)" +
            " = (?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE patient_id = ?;";
    final private String DELETE = "DELETE FROM patient WHERE patient_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM patient WHERE patient_id = ? LIMIT 1;";
    final private String SELECTALL = "SELECT * FROM patient;";
    final private String COUNT = "SELECT COUNT(*) FROM patient;";

    final private String PATIENTSBYPRACTITIONER = "SELECT * FROM patient WHERE practitioner_id = ?;";
    final private String PATIENTSLIKESSNORIDANDPROVINCE = "select * from patient where (LOWER(ssn) like " +
            "LOWER(?) or LOWER(patient_id) like LOWER(?)) AND living_province = ?;";
    final private String PATIENTSBYPROVINCE = "SELECT * FROM patient WHERE living_province = ?;";

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
            stm.setString(6, patient.getSSN());
            stm.setString(7, String.valueOf(patient.getGender()));
            stm.setString(8, patient.getPractitionerID());
            stm.setString(9, patient.getLivingProvince().getAbbreviation());
            stm.setString(10, patient.getLivingPlace());

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
            stm.setString(5, patient.getSSN());
            stm.setString(6, String.valueOf(patient.getGender()));
            stm.setString(7, patient.getPractitionerID());
            stm.setString(8, patient.getLivingProvince().getAbbreviation());
            stm.setString(9, patient.getLivingPlace());
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
    public Patient getByPrimaryKey(String primaryKey) throws DAOException {
        Patient patient = null;
        try {
            PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY);
            stm.setString(1, primaryKey);
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

    public List<Patient> getPatientsByPractitioner(String practitionerID) throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(PATIENTSBYPRACTITIONER)) {
            stm.setString(1, practitionerID);
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

    public List<Patient> getPatientsBySSNOrPartialNameandProvince(String query, String provinceAbbreviation) throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(PATIENTSLIKESSNORIDANDPROVINCE)) {
            stm.setString(1, "%" + query + "%");
            stm.setString(2, "%" + query + "%");
            stm.setString(3, provinceAbbreviation);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Patients by LIKE SSN or ID: ", e);
        }
    }

    public List<Patient> getPatientsByProvince(String provinceAbbreviation) throws DAOException {
        List<Patient> res = new ArrayList<>();
        Patient tmp;
        try (PreparedStatement stm = CON.prepareStatement(PATIENTSBYPROVINCE)) {
            stm.setString(1, provinceAbbreviation);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Patients by Province: ", e);
        }
    }

    @Override
    protected Patient mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Patient patient = new Patient();

            ProvinceDAO provinceDAO = DAOFACTORY.getDAO(ProvinceDAO.class);
            Province province = provinceDAO.getByAbbreviation(
                    rs.getString("living_province"));

            patient.setID(rs.getString("patient_id"));
            patient.setFirstName(rs.getString("first_name"));
            patient.setLastName(rs.getString("last_name"));
            patient.setBirthDate(rs.getDate("birth_date"));
            patient.setBirthPlace(rs.getString("birth_place"));
            patient.setSSN(rs.getString("ssn"));
            patient.setGender(rs.getString("gender").charAt(0));
            patient.setPractitionerID(rs.getString("practitioner_id"));
            patient.setLivingProvince(province);
            patient.setLivingPlace(rs.getString("living_place"));

            return patient;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }
}
