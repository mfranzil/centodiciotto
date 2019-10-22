package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.Prescription;
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
public class JDBCPrescriptionDAO extends JDBCDAO<Prescription, Integer> implements PrescriptionDAO {

    final private String INSERT = "INSERT INTO prescription " +
            "(practitioner_id, patient_id, emission_date, description) values (?, ?, ?, ?);";
    final private String UPDATE = "UPDATE prescription SET " +
            "(practitioner_id, patient_id, emission_date,a description) = (?, ?, ?, ?) " +
            "WHERE prescription_id = ?;";
    final private String DELETE = "DELETE FROM prescription WHERE prescription_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM prescription WHERE prescription_id = ?;";
    final private String SELECTALL = "SELECT * FROM prescription;";
    final private String COUNT = "SELECT COUNT(*) FROM prescription;";

    final private String FINDBYPATIENT = "SELECT * FROM prescription WHERE patient_id = ?;";
    final private String FINDBYPRACTITIONER = "SELECT * FROM prescription WHERE practitioner_id = ?;";
    final private String FINDEXPIRED = "SELECT * FROM  prescription " +
            "WHERE emission_date + interval '1 month' < now();";
    final private String FINDVALID = "SELECT * FROM  prescription " +
            "WHERE emission_date + interval '1 month' >= now();";

    public JDBCPrescriptionDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Prescription prescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, prescription.getPractitionerID());
            stm.setString(2, prescription.getPatientID());
            stm.setDate(3, prescription.getDate());
            stm.setString(4, prescription.getDescription());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Prescription: ", e);
        }

    }

    @Override
    public void update(Prescription prescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, prescription.getPractitionerID());
            stm.setString(2, prescription.getPatientID());
            stm.setDate(3, prescription.getDate());
            stm.setString(4, prescription.getDescription());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating prescription: ", e);
        }
    }

    @Override
    public void delete(Prescription prescription) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, prescription.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting Prescription: ", e);
        }
    }

    @Override
    public Prescription getByPrimaryKey(Integer prescriptionID) throws DAOException {
        Prescription res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, prescriptionID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting prescription by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<Prescription> getAll() throws DAOException {
        List<Prescription> res = new ArrayList<>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Prescriptions: ", e);
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
            throw new DAOException("Error counting Prescriptions: ", e);
        }
        return -1L;
    }

    @Override
    public List<Prescription> getByPatient(String patientEmail) throws DAOException {
        List<Prescription> res = new ArrayList<>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, patientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Prescription by Patient: ", e);
        }
    }

    public List<Prescription> getByPractitioner(String practitionerEmail) throws DAOException {
        List<Prescription> res = new ArrayList<>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRACTITIONER)) {
            stm.setString(1, practitionerEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Prescription by Practitioner: ", e);
        }
    }

    public List<Prescription> getExpired() throws DAOException {
        List<Prescription> res = new ArrayList<>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDEXPIRED)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting expired Prescriptions: ", e);
        }
    }

    public List<Prescription> getValid() throws DAOException {
        List<Prescription> res;
        res = new ArrayList<>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDVALID)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting valid Prescriptions: ", e);
        }
    }

    @Override
    protected Prescription mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Prescription prescription = new Prescription();

            prescription.setDescription(rs.getString("description"));
            prescription.setDate(rs.getDate("emission_date"));
            prescription.setID(rs.getInt("prescription_id"));
            prescription.setPatientID(rs.getString("patient_id"));
            prescription.setPractitionerID(rs.getString("practitioner_id"));

            return prescription;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Prescription: ", e);
        }
    }
}

