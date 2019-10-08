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
    final private String FINDBYPATIENT = "SELECT * FROM  prescription JOIN general_practitioner ON practitionerid = email  WHERE patientid = ?;";
    final private String FINDBYPRACTITIONER = "SELECT * FROM  prescription WHERE practitionerid = ?;";
    final private String FINDEXPIRED = "SELECT * FROM  prescription WHERE emission_date + interval '1 month' < now();";
    final private String FINDVALID = "SELECT * FROM  prescription WHERE emission_date + interval '1 month' >= now();";
    public JDBCPrescriptionDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Prescription prescription) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, prescription.getPrescriptionPractitioner());
            preparedStatement.setString(2, prescription.getPrescriptionPatient());
            preparedStatement.setDate(3, prescription.getPrescriptionDate());
            preparedStatement.setString(4, prescription.getDrugDescription());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Prescription: ", e);
        }

    }

    @Override
    public void update(Prescription prescription) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, prescription.getPrescriptionPractitioner());
            preparedStatement.setString(2, prescription.getPrescriptionPatient());
            preparedStatement.setDate(3, prescription.getPrescriptionDate());
            preparedStatement.setString(4, prescription.getDrugDescription());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating prescription: ", e);
        }
    }

    @Override
    public void delete(Prescription prescription) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, prescription.getPrescriptionID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Prescription by ID: ", e);
        }
    }

    @Override
    public Prescription getByPrimaryKey(Integer prescriptionID) throws DAOException {
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
            throw new DAOException("Error getting prescription by id: ", e);
        }
        return null;
    }

    @Override
    public List<Prescription> getByPatient(String patientEmail) throws DAOException {
        List<Prescription> res = new ArrayList<>();
        Prescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, patientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"), rs.getString("first_name"), rs.getString("last_name"));
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
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
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
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
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
                    tmp = new Prescription(rs.getInt("prescriptionid"), rs.getString("practitionerid"), rs.getString("patientid"), rs.getDate("emission_date"), rs.getString("description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting valid Prescriptions: ", e);
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
            throw new DAOException("Error counting Prescriptions: ", e);
        }
        return res;
    }

    @Override
    public List<Prescription> getAll() throws DAOException {
        List<Prescription> res = new ArrayList<>();
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
            throw new DAOException("Error getting all Prescriptions: ", e);
        }
    }
}

