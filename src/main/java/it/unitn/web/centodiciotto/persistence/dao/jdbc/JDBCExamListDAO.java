package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCExamListDAO extends JDBCDAO<ExamList, Integer> implements ExamListDAO {

    final private String FINDBYPRIMARYKEY = "SELECT * FROM exam_list WHERE exam_id = ?;";
    final private String FINDNAMEBYPRIMARYKEY = "SELECT description FROM exam_list WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam_list;";
    final private String COUNT = "SELECT COUNT(*) FROM exam_list;";

    public JDBCExamListDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(ExamList examList) throws DAOException {
        throw new DAOException("The ExamList table is read-only.");
    }

    @Override
    public void update(ExamList examList) throws DAOException {
        throw new DAOException("The ExamList table is read-only.");
    }

    @Override
    public void delete(ExamList examList) throws DAOException {
        throw new DAOException("The ExamList table is read-only.");
    }

    @Override
    public ExamList getByPrimaryKey(Integer ExamID) throws DAOException {
        ExamList res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, ExamID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamList by primary key: ", e);
        }
        return null;
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
            throw new DAOException("Error getting all ExamsLists: ", e);
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
            throw new DAOException("Error counting ExamLists: ", e);
        }
        return -1L;
    }

    @Override
    protected ExamList mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            ExamList examList = new ExamList();

            examList.setDescription(rs.getString("exam_description"));
            examList.setID(rs.getInt("exam_id"));

            return examList;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to ExamList: ", e);
        }
    }
}

