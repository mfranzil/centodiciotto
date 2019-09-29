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

    final private String INSERT = "INSERT INTO exams (patient_id, doctor_id, exam_type, done, date, result ) values (?, ?, ?, ?, ?, ?);";
    final private String FINDBYPATIENT = "SELECT * FROM exams WHERE patient_id = ?;";
    final private String FINDBYID = "SELECT * FROM exams WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exams;";
    final private String DELETE = "DELETE FROM exams WHERE exam_id = ?;";
    final private String UPDATE = "UPDATE exams SET (patient_id, doctor_id, exam_type, done, date, result ) =  (?, ?, ?, ?, ?, ?) WHERE exam_id = ?;";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCExamDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Exam exam) {
        try {
            //(patient_id, doctor_id, exam_type, done, date, result )
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, exam.getPatientEmail());
            preparedStatement.setString(2, exam.getDoctorEmail());
            preparedStatement.setInt(3, exam.getExamType());
            preparedStatement.setBoolean(4, exam.getExamDone());
            preparedStatement.setDate(5, exam.getExamDate());
            preparedStatement.setString(6, exam.getExamResult());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting Exam: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(Exam exam) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, exam.getPatientEmail());
            preparedStatement.setString(2, exam.getDoctorEmail());
            preparedStatement.setInt(3, exam.getExamType());
            preparedStatement.setBoolean(4, exam.getExamDone());
            preparedStatement.setDate(5, exam.getExamDate());
            preparedStatement.setString(6, exam.getExamResult());
            preparedStatement.setInt(7, exam.getExamID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating Exam: " + e.getMessage());
        }
    }

    @Override
    public void delete(Exam exam) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam.getExamID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting Exam by ID: " + e.getMessage());
        };
    }

    @Override
    public Exam getByPrimaryKey(Integer ExamID) {
        Exam res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, ExamID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new Exam(rs.getInt("exam_id"), rs.getString("patient_id"), rs.getString("doctor_id"), rs.getInt("exam_type"), rs.getBoolean("done"), rs.getDate("date"), rs.getString("result"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting Exam by ID: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Exam> getByPatient(String PatientEmail){
        List<Exam> res = new ArrayList<Exam>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, PatientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Exam(rs.getInt("exam_id"), rs.getString("patient_id"), rs.getString("doctor_id"), rs.getInt("exam_type"), rs.getBoolean("done"), rs.getDate("date"), rs.getString("result"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting Exams by PatientID: " + e.getMessage());
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
            System.err.println("Error counting Exams: " + e.getMessage());
        }
        return res;
    }

    @Override
    public List<Exam> getAll() throws DAOException {
        List<Exam> res = new ArrayList<Exam>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new Exam(rs.getInt("exam_id"), rs.getString("patient_id"), rs.getString("doctor_id"), rs.getInt("exam_type"), rs.getBoolean("done"), rs.getDate("date"), rs.getString("result"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all Exams: " + e.getMessage());
        }
        return null;
    }
}

