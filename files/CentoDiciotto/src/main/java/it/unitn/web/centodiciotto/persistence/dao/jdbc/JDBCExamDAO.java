package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCExamDAO extends JDBCDAO<Exam, Integer> implements ExamDAO {

    final private String INSERT = "INSERT INTO exam (patient_id, doctor_id, exam_type, done, date, result, health_service_id, ticket, exam_prescription_id) values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String FINDBYPATIENT = "SELECT * FROM exam WHERE patient_id = ?";
    final private String FINDBYPATIENTLASTYEAR = "SELECT * FROM exam WHERE patient_id = ?";
    final private String FINDBYID = "SELECT * FROM exam WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam;";
    final private String DELETE = "DELETE FROM exam WHERE exam_id = ?;";
    final private String UPDATE = "UPDATE exam SET (patient_id, doctor_id, exam_type, done, date, result, health_service_id, ticket, exam_prescription_id) =  (?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE exam_id = ?;";
    public JDBCExamDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Exam exam) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, exam.getPatientID());
            preparedStatement.setString(2, exam.getDoctorID());
            preparedStatement.setInt(3, exam.getType());
            preparedStatement.setBoolean(4, exam.getDone());
            preparedStatement.setTimestamp(5, exam.getDate());
            preparedStatement.setString(6, exam.getResult());
            preparedStatement.setInt(7, exam.getHealthServiceID());
            preparedStatement.setInt(8, exam.getTicket());
            preparedStatement.setInt(9, exam.getExamPrescriptionID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Exam: ", e);
        }
    }

    @Override
    public void update(Exam exam) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, exam.getPatientID());
            preparedStatement.setString(2, exam.getDoctorID());
            preparedStatement.setInt(3, exam.getType());
            preparedStatement.setBoolean(4, exam.getDone());
            preparedStatement.setTimestamp(5, exam.getDate());
            preparedStatement.setString(6, exam.getResult());
            preparedStatement.setInt(7, exam.getID());
            preparedStatement.setInt(7, exam.getHealthServiceID());
            preparedStatement.setInt(8, exam.getTicket());
            preparedStatement.setInt(9, exam.getExamPrescriptionID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Exam: ", e);
        }
    }

    @Override
    public void delete(Exam exam) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam.getID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Exam by ID: ", e);
        }
    }

    @Override
    public Exam getByPrimaryKey(Integer ExamID) throws DAOException {
        Exam res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, ExamID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Err or getting Exam by ID: ", e);
        }
        return null;
    }

    @Override
    public List<Exam> getByPatient(String PatientEmail) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
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
            throw new DAOException("Error getting Exams by PatientID: ", e);
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
            throw new DAOException("Error counting Exams: ", e);
        }
        return res;
    }

    @Override
    public List<Exam> getAll() throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Exams: ", e);
        }
    }

    @Override
    protected Exam mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Exam exam = new Exam();

            exam.setID(rs.getInt("exam_id"));
            exam.setPatientID(rs.getString("patient_id"));
            exam.setDoctorID(rs.getString("doctor_id"));
            exam.setType(rs.getInt("exam_type"));
            exam.setDone(rs.getBoolean("done"));
            exam.setDate(rs.getTimestamp("date"));
            exam.setResult(rs.getString("result"));
            exam.setHealthServiceID(rs.getInt("health_service_id"));
            exam.setTicket(rs.getInt("ticket"));
            exam.setExamPrescriptionID(rs.getInt("exam_prescription_id"));

            return exam;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }
}

