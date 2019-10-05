package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.servlets.patient.ExamPrescriptionCreatorServlet;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCExamDAO extends JDBCDAO<Exam, Integer> implements ExamDAO {

    final private String INSERT = "INSERT INTO exam (patient_id, doctor_id, exam_type, done, date, result, health_service_id, ticket) values (?, ?, ?, ?, ?, ?, ?, ?);";
    final private String FINDBYPATIENT = "SELECT * FROM exam WHERE patient_id = ?;";
    final private String FINDBYID = "SELECT * FROM exam WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam;";
    final private String DELETE = "DELETE FROM exam WHERE exam_id = ?;";
    final private String UPDATE = "UPDATE exam SET (patient_id, doctor_id, exam_type, done, date, result, health_service_id, ticket) =  (?, ?, ?, ?, ?, ?, ?, ?) WHERE exam_id = ?;";
    public JDBCExamDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Exam exam) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, exam.getPatientEmail());
            preparedStatement.setString(2, exam.getDoctorEmail());
            preparedStatement.setInt(3, exam.getExamType());
            preparedStatement.setBoolean(4, exam.getExamDone());
            preparedStatement.setTimestamp(5, exam.getExamDate());
            preparedStatement.setString(6, exam.getExamResult());
            preparedStatement.setInt(7, exam.getHealthServiceId());
            preparedStatement.setInt(8, exam.getTicket());

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
            preparedStatement.setString(1, exam.getPatientEmail());
            preparedStatement.setString(2, exam.getDoctorEmail());
            preparedStatement.setInt(3, exam.getExamType());
            preparedStatement.setBoolean(4, exam.getExamDone());
            preparedStatement.setTimestamp(5, exam.getExamDate());
            preparedStatement.setString(6, exam.getExamResult());
            preparedStatement.setInt(7, exam.getExamID());
            preparedStatement.setInt(7, exam.getHealthServiceId());
            preparedStatement.setInt(8, exam.getTicket());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Exam: ", e);
        }
    }

    @Override
    public void delete(Exam exam) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam.getExamID());

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
                    res = mapRowToExam(rs);
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
                    tmp = mapRowToExam(rs);
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
                    tmp = mapRowToExam(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Exams: ", e);
        }
    }

    public Exam mapRowToExam(ResultSet rs) throws SQLException {
        Exam exam = new Exam(
                rs.getInt("exam_id"),
                rs.getString("patient_id"),
                rs.getString("doctor_id"),
                rs.getInt("exam_type"),
                rs.getBoolean("done"),
                rs.getTimestamp("date"),
                rs.getString("result"),
                rs.getInt("health_service_id"),
                rs.getInt("ticket"));
        return exam;
    }
}

