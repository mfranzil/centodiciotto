package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.ExamType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCExamTypeDAO extends JDBCDAO<ExamType, Integer> implements ExamTypeDAO {

    final private String FINDBYPRIMARYKEY = "SELECT * FROM exam_type WHERE exam_id = ?;";
    final private String FINDNAMEBYPRIMARYKEY = "SELECT description FROM exam_type WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam_type order by exam_description asc;";
    final private String COUNT = "SELECT COUNT(*) FROM exam_type;";

    public JDBCExamTypeDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(ExamType examType) throws DAOException {
        throw new DAOException("The ExamType table is read-only.");
    }

    @Override
    public void update(ExamType examType) throws DAOException {
        throw new DAOException("The ExamType table is read-only.");
    }

    @Override
    public void delete(ExamType examType) throws DAOException {
        throw new DAOException("The ExamType table is read-only.");
    }

    @Override
    public ExamType getByPrimaryKey(Integer ExamID) throws DAOException {
        ExamType res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, ExamID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamType by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<ExamType> getAll() throws DAOException {
        List<ExamType> res = new ArrayList<>();
        ExamType tmp;
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
    protected ExamType mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            ExamType examType = new ExamType();

            examType.setDescription(rs.getString("exam_description"));
            examType.setID(rs.getInt("exam_id"));

            return examType;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to ExamType: ", e);
        }
    }
}
