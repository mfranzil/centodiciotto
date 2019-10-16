package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
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

    final private String INSERT = "INSERT INTO exams_list (exam_description) values (?);";
    final private String FINDBYID = "SELECT * FROM exams_list WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exams_list;";
    final private String DELETE = "DELETE FROM exams_list WHERE exam_id = ?;";
    final private String UPDATE = "UPDATE exams_list SET (exam_description) =  (?) WHERE exam_id = ?;";

    public JDBCExamListDAO(Connection con) {
        super(con);
    }

    @Override
    protected ExamList mapRowToEntity(ResultSet resultSet) throws DAOException {
        try {
            ExamList examList = new ExamList();

            examList.setExamDescription(resultSet.getString("exam_description"));
            examList.setExamID(resultSet.getInt("exam_id"));

            return examList;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Patient: ", e);
        }
    }

    @Override
    public void insert(ExamList exam_list) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setInt(1, exam_list.getExamID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting exam_list: ", e);
        }
    }

    @Override
    public void update(ExamList exam_list) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, exam_list.getExamDescription());
            preparedStatement.setInt(2, exam_list.getExamID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Exam_list: ", e);
        }
    }

    @Override
    public void delete(ExamList exam_list) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam_list.getExamID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Exam_list by ID: ", e);
        }
    }

    @Override
    public ExamList getByPrimaryKey(Integer ExamID) throws DAOException {
        ExamList res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, ExamID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamList by ID: ", e);
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
            throw new DAOException("Error counting Exams: ", e);
        }
        return res;
    }

    @Override
    public List<ExamList> getAll() throws DAOException {
        List<ExamList> res = new ArrayList<>();
        ExamList tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all ExamsList: ", e);
        }
    }
}

