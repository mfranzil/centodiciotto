package it.unitn.web.centodiciotto.persistence.dao.jdbc;
import it.unitn.web.centodiciotto.persistence.dao.PrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.Prescription;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCPrescriptionDAO extends JDBCDAO<Prescription, Integer> implements PrescriptionDAO {

    final private String INSERT = "INSERT INTO prescription (practitionerid, patientid, emission_date, description) values (?, ?, ?, ?);";
    final private String FINDBYID = "SELECT * FROM prescription WHERE prescriptionid = ?;";
    final private String SELECTALL = "SELECT * FROM prescription;";
    final private String DELETE = "DELETE FROM prescription WHERE prescriptionid = ?;";
    final private String UPDATE = "UPDATE prescription SET (practitionerid, patientid, emission_date, description) = (?, ?, ?, ?) WHERE prescriptionid = ?;";
    final private String FINDBYPATIENT = "SELECT * FROM  prescription WHERE patientid = ?;";
    final private String FINDBYPRACTITIONER = "SELECT * FROM  prescription WHERE practitionerid = ?;";
    final private String FINDEXPIRED = "SELECT * FROM  prescription WHERE emission_date + interval '1 month' < now();";
    final private String FINDVALID = "SELECT * FROM  prescription WHERE emission_date + interval '1 month' >= now();";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCPrescriptionDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Prescription prescription) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, prescription.getPrescriptionPractitioner());
            preparedStatement.setString(2, prescription.getPrescriptionPatient());
            preparedStatement.setDate(3, prescription.getPrescriptionDate());
            preparedStatement.setString(4, prescription.getDrugDescription());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting Prescription: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(Prescription prescription) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, prescription.getPrescriptionPractitioner());
            preparedStatement.setString(2, prescription.getPrescriptionPatient());
            preparedStatement.setDate(3, prescription.getPrescriptionDate());
            preparedStatement.setString(4, prescription.getDrugDescription());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating prescription: " + e.getMessage());
        }
    }

    @Override
    public void delete(Prescription prescription) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, prescription.getPrescriptionID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting Prescription by ID: " + e.getMessage());
        };
    }

    @Override
    public Prescription getByPrimaryKey(Integer prescriptionID) {
        Prescription res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, prescriptionID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting prescription by id: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Prescription> getByPatient(String patientEmail) {
        List<Prescription> res = new ArrayList<Prescription>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, patientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting Prescription by Patient: " + e.getMessage());
        }
        return null;
    }

    public List<Prescription> getByPractitioner(String practitionerEmail){
        List<Prescription> res = new ArrayList<Prescription>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRACTITIONER)) {
            stm.setString(1, practitionerEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting Prescription by Practitioner: " + e.getMessage());
        }
        return null;
    }

    public List<Prescription> getExpired(){
        List<Prescription> res = new ArrayList<Prescription>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDEXPIRED)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting expired Prescriptions: " + e.getMessage());
        }
        return null;
    }

    public List<Prescription> getValid(){
        List<Prescription> res = new ArrayList<Prescription>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDVALID)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting valid Prescriptions: " + e.getMessage());
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
            System.err.println("Error counting Prescriptions: " + e.getMessage());
        }
        return res;
    }

    @Override
    public List<Prescription> getAll() throws DAOException {
        List<Prescription> res = new ArrayList<Prescription>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all Prescriptions: " + e.getMessage());
        }
        return null;
    }
}

