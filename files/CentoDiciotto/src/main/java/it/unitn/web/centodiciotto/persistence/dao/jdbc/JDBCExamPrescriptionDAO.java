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
    public JDBCExamPrescriptionDAO(Connection con) {
        super(con);
    }

    @Override
    protected ExamPrescription mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            ExamPrescription examPrescription = new ExamPrescription();

            examPrescription.setPrescriptionID(resultSet.getInt("exam_prescription_id"));
            examPrescription.setPractitionerEmail(resultSet.getString("practitioner_id"));
            examPrescription.setPatientEmail(resultSet.getString("patient_id"));
            examPrescription.setExamType(resultSet.getInt("exam_type"));
            examPrescription.setExamBooked(resultSet.getBoolean("booked"));

            return examPrescription;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }

    @Override
    public void insert(ExamPrescription examPrescription) throws DAOException {
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
            throw new DAOException("Error inserting ExamPrescription: ", e);
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(ExamPrescription examPrescription) throws DAOException {
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
            throw new DAOException("Error updating ExamPrescription: ", e);
        }
    }

    @Override
    public void delete(ExamPrescription examPrescription) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, examPrescription.getPrescriptionID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting ExamPrescription by ID: ", e);
        }
    }

    @Override
    public ExamPrescription getByPrimaryKey(Integer ExamPrescriptionID) throws DAOException {
        ExamPrescription res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, ExamPrescriptionID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamPrescription by ID: ", e);
        }
        return null;
    }

    @Override
    public List<ExamPrescription> getByPatient(String PatientEmail) throws DAOException {
        List<ExamPrescription> res = new ArrayList<>();
        ExamPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, PatientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamPrescriptions by PatientID: ", e);
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
            throw new DAOException("Error counting ExamsPrescriptions: ", e);
        }
        return res;
    }

    @Override
    public List<ExamPrescription> getAll() throws DAOException {
        List<ExamPrescription> res = new ArrayList<>();
        ExamPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all ExamPrescriptions: ", e);
        }
    }
}

