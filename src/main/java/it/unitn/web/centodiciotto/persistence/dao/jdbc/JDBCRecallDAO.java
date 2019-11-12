package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.RecallDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.ExamType;
import it.unitn.web.centodiciotto.persistence.entities.Recall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCRecallDAO extends JDBCDAO<Recall, Integer> implements RecallDAO {

    final private String INSERT = "INSERT INTO recall " +
            "(exam_type, min_age, max_age, start_date, health_service_id)" +
            " values (?, ?, ?, ?, ?) RETURNING recall_id;";
    final private String UPDATE = "UPDATE recall SET " +
            "(exam_type, min_age, max_age, start_date, health_service_id) = " +
            " (?, ?, ?, ?, ?) WHERE recall_id = ?;";
    final private String DELETE = "DELETE FROM recall WHERE recall_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM recall WHERE recall_id = ?;";
    final private String SELECTALL = "SELECT * FROM recall;";
    final private String COUNT = "SELECT COUNT(*) FROM recall;";

    final private String FINDBYHSANDEXAM = "SELECT * from recall WHERE health_service_id = ?" +
            " AND exam_type = ? ORDER BY start_date desc LIMIT 1;";
    final private String FINDBYHEALTHSERVICE = "SELECT * from recall WHERE health_service_id = ? " +
            "ORDER BY start_date desc;";

    public JDBCRecallDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Recall recall) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setInt(1, recall.getExamType().getID());
            stm.setInt(2, recall.getMinAge());
            stm.setInt(3, recall.getMaxAge());
            stm.setTimestamp(4, recall.getStartDate());
            stm.setString(5, recall.getHealthServiceID());

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                recall.setID(rs.getInt("recall_id"));
                System.out.println("Row affected returned: " + rs.getInt("recall_id"));
            }
        } catch (SQLException e) {
            throw new DAOException("Error inserting Recall: ", e);
        }
    }

    @Override
    public void update(Recall recall) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setInt(1, recall.getExamType().getID());
            stm.setInt(2, recall.getMinAge());
            stm.setInt(3, recall.getMaxAge());
            stm.setTimestamp(4, recall.getStartDate());
            stm.setString(5, recall.getHealthServiceID());
            stm.setInt(6, recall.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Recall: ", e);
        }
    }

    @Override
    public void delete(Recall recall) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, recall.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting Recall: ", e);
        }
    }

    @Override
    public Recall getByPrimaryKey(Integer primaryKey) throws DAOException {
        Recall res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Recall by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<Recall> getAll() throws DAOException {
        List<Recall> res = new ArrayList<>();
        Recall tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Recalls: ", e);
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
            throw new DAOException("Error counting Recalls: ", e);
        }
        return -1L;
    }

    public Recall getLastByHealthServiceAndExam(String healthServiceID, Integer examID) throws DAOException {
        Recall res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYHSANDEXAM)) {
            stm.setString(1, healthServiceID);
            stm.setInt(2, examID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Recall by HS and exam: ", e);
        }
        return null;
    }

    public List<Recall> getByHealthService(String healthServiceID) throws DAOException {
        List<Recall> recalls = new ArrayList<>();
        try {
            PreparedStatement stm = CON.prepareStatement(FINDBYHEALTHSERVICE);
            stm.setString(1, healthServiceID);

            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Recall recall = mapRowToEntity(rs);
                recalls.add(recall);
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Recalls: ", e);
        }
        return recalls;
    }

    @Override
    protected Recall mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Recall recall = new Recall();

            ExamTypeDAO examTypeDAO = DAOFACTORY.getDAO(ExamTypeDAO.class);
            ExamType examType = examTypeDAO.getByPrimaryKey(rs.getInt("exam_type"));

            recall.setID(rs.getInt("recall_id"));
            recall.setExamType(examType);
            recall.setMinAge(rs.getInt("min_age"));
            recall.setMaxAge(rs.getInt("max_age"));
            recall.setStartDate(rs.getTimestamp("start_date"));
            recall.setHealthServiceID(rs.getString("health_service_id"));

            return recall;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to Recall: ", e);
        }
    }

}
