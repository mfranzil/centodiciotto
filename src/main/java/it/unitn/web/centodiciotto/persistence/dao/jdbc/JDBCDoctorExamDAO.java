package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.DoctorExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.DoctorExam;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCDoctorExamDAO extends JDBCDAO<DoctorExam, Pair<String, Integer>> implements DoctorExamDAO {

    final private String FINDBYPRIMARYKEY = "SELECT * FROM doctor_exams WHERE doctor_id = ? AND exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM doctor_exams;";
    final private String COUNT = "SELECT COUNT(*) FROM doctor_exams;";

    final private String FINDBYEXAMLIST = "SELECT * FROM doctor_exams WHERE exam_id = ?;";


    public JDBCDoctorExamDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(DoctorExam doctorExam) throws DAOException {
        throw new DAOException("The DoctorExam table is read-only.");
    }

    @Override
    public void update(DoctorExam doctorExam) throws DAOException {
        throw new DAOException("The DoctorExam table is read-only.");
    }

    @Override
    public void delete(DoctorExam doctorExam) throws DAOException {
        throw new DAOException("The DoctorExam table is read-only.");
    }

    @Override
    public DoctorExam getByPrimaryKey(Pair<String, Integer> DoctorExamID) throws DAOException {
        DoctorExam res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setString(1, DoctorExamID.getFirst());
            stm.setInt(1, DoctorExamID.getSecond());

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DoctorExam by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<DoctorExam> getAll() throws DAOException {
        List<DoctorExam> res = new ArrayList<>();
        DoctorExam tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all DoctorExams: ", e);
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
            throw new DAOException("Error counting DoctorExams: ", e);
        }
        return -1L;
    }

    @Override
    protected DoctorExam mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            DoctorExam doctorExam = new DoctorExam();

            doctorExam.setDoctorID(rs.getString("doctor_id"));
            doctorExam.setExamListID(rs.getInt("exam_id"));

            return doctorExam;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to DoctorExam: ", e);
        }
    }

    @Override
    public List<DoctorExam> getByExamList(ExamList examList) throws DAOException {
        List<DoctorExam> res = new ArrayList<>();
        DoctorExam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYEXAMLIST)) {
            stm.setInt(1, examList.getID());

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DoctorExam by examList: ", e);
        }
    }
}

