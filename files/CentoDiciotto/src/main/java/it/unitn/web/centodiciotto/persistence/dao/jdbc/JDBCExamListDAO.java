package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCExamListDAO extends JDBCDAO<ExamList, Integer> implements ExamListDAO {

    final private String INSERT = "INSERT INTO exams_list (exam_description) values (?;";
    final private String FINDBYID = "SELECT * FROM exams_list WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exams_list;";
    final private String DELETE = "DELETE FROM exams_list WHERE exam_id = ?;";
    final private String UPDATE = "UPDATE exams_list SET (exam_description) =  (?) WHERE exam_id = ?;";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCExamListDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(ExamList exam_list) {
        try {
            //(patient_id, doctor_id, exam_type, done, date, result )
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setInt(1, exam_list.getExamID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting exam_list: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(ExamList exam_list) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, exam_list.getExamDescription());
            preparedStatement.setInt(2, exam_list.getExamID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating Exam_list: " + e.getMessage());
        }
    }

    @Override
    public void delete(ExamList exam_list) {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam_list.getExamID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting Exam_list by ID: " + e.getMessage());
        };
    }

    @Override
    public ExamList getByPrimaryKey(Integer ExamID) {
        ExamList res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, ExamID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new ExamList(rs.getInt("exam_id"), rs.getString("exam_description"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting ExamList by ID: " + e.getMessage());
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
    public List<ExamList> getAll() throws DAOException {
        List<ExamList> res = new ArrayList<ExamList>();
        ExamList tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new ExamList(rs.getInt("exam_id"), rs.getString("exam_description"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            System.err.println("Error getting all ExamsList: " + e.getMessage());
        }
        return null;
    }
}

