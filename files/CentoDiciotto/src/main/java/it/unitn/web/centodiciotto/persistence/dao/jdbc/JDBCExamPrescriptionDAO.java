package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCExamPrescriptionDAO extends JDBCDAO<ExamPrescription, Integer> implements ExamPrescriptionDAO {

    final private String INSERT = "INSERT INTO exam_prescription (practitioner_id, patient_id, exam_type, booked) values (?, ?, ?, ?);";
    final private String FINDBYPATIENT = "SELECT * FROM exam_prescription WHERE patient_id = ?;";
    final private String FINDBYID = "SELECT * FROM exam_prescription WHERE exam_prescription_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam_prescription;";
    final private String DELETE = "DELETE FROM exam_prescription WHERE exam_prescription_id = ?;";
    final private String UPDATE = "UPDATE exam_prescription SET (practitioner_id, patient_id, exam_type, booked) =  (?, ?, ?, ?) WHERE exam_prescription_id = ?;";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCExamPrescriptionDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(ExamPrescription examPrescription) {
        try {
            //(patient_id, doctor_id, exam_type, done, date, result )
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, examPrescription.getPractitionerEmail());
            preparedStatement.setString(2, examPrescription.getPatientEmail());
            preparedStatement.setInt(3, examPrescription.getExamType());
            preparedStatement.setBoolean(4, examPrescription.getExamBooked());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting ExamPrescription: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(ExamPrescription examPrescription) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, examPrescription.getPractitionerEmail());
            preparedStatement.setString(2, examPrescription.getPatientEmail());
            preparedStatement.setInt(3, examPrescription.getExamType());
            preparedStatement.setBoolean(4, examPrescription.getExamBooked());
            preparedStatement.setInt(5, examPrescription.getPrescriptionID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating ExamPrescription: " + e.getMessage());
        }
    }

    @Override
    public void delete(ExamPrescription examPrescription) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, examPrescription.getPrescriptionID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting ExamPrescription by ID: " + e.getMessage());
        };
    }

    @Override
    public ExamPrescription getByPrimaryKey(Integer ExamPrescriptionID) {
        ExamPrescription res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, ExamPrescriptionID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new ExamPrescription(rs.getInt("exam_prescription_id"), rs.getString("practitioner_id"), rs.getString("patient_id"), rs.getInt("exam_type"), rs.getBoolean("booked"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting ExamPrescription by ID: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<ExamPrescription> getByPatient(String PatientEmail){
        List<ExamPrescription> res = new ArrayList<ExamPrescription>();
        ExamPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, PatientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new ExamPrescription(rs.getInt("exam_prescription_id"), rs.getString("practitioner_id"), rs.getString("patient_id"), rs.getInt("exam_type"), rs.getBoolean("booked"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting ExamPrescriptions by PatientID: " + e.getMessage());
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
            System.err.println("Error counting ExamsPrescriptions: " + e.getMessage());
        }
        return res;
    }

    @Override
    public List<ExamPrescription> getAll() throws DAOException {
        List<ExamPrescription> res = new ArrayList<ExamPrescription>();
        ExamPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new ExamPrescription(rs.getInt("exam_prescription_id"), rs.getString("practitioner_id"), rs.getString("patient_id"), rs.getInt("exam_type"), rs.getBoolean("booked"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all ExamPrescriptions: " + e.getMessage());
        }
        return null;
    }
}

