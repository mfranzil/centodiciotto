package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCVisitDAO extends JDBCDAO<Visit, Integer> implements VisitDAO {

    final private String INSERT = "INSERT INTO visit (practitioner_id, patient_id, visit_date, report_available, report) values (?, ?, ?, ?, ?);";
    final private String FINDBYPATIENT = "SELECT * FROM visit WHERE patient_id = ?;";
    final private String FINDBYID = "SELECT * FROM visit WHERE visit_id = ?;";
    final private String SELECTALL = "SELECT * FROM visit;";
    final private String DELETE = "DELETE FROM visit WHERE visit_id = ?;";
    final private String UPDATE = "UPDATE visit SET (practitioner_id, patient_id, visit_date, report_available, report)  =  (?, ?, ?, ?, ?) WHERE visit_id = ?;";
    public JDBCVisitDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Visit visit) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, visit.getPractitionerEmail());
            preparedStatement.setString(2, visit.getPatientEmail());
            preparedStatement.setDate(3, visit.getVisitDate());
            preparedStatement.setBoolean(4, visit.getReportAvailable());
            preparedStatement.setString(5, visit.getReport());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Visit: ", e);
        }
    }

    @Override
    public void update(Visit visit) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, visit.getPractitionerEmail());
            preparedStatement.setString(2, visit.getPatientEmail());
            preparedStatement.setDate(3, visit.getVisitDate());
            preparedStatement.setBoolean(4, visit.getReportAvailable());
            preparedStatement.setString(5, visit.getReport());
            preparedStatement.setInt(6, visit.getVisitID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Visit: ", e);
        }
    }

    @Override
    public void delete(Visit visit) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, visit.getVisitID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting Visit by ID: ", e);
        }
    }

    @Override
    public Visit getByPrimaryKey(Integer VisitID) throws DAOException {
        Visit res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, VisitID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToExam(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Err or getting Visit by ID: ", e);
        }
        return null;
    }

    @Override
    public List<Visit> getByPatient(String PatientEmail) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
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
            throw new DAOException("Error getting Visit by PatientID: ", e);
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
    public List<Visit> getAll() throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
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

    public Visit mapRowToExam(ResultSet rs) throws SQLException {
        Visit visit = new Visit(
                rs.getInt("visit_id"),
                rs.getString("practitioner_id"),
                rs.getString("patient_id"),
                rs.getDate("visit_date"),
                rs.getBoolean("report_available"),
                rs.getString("report"));
        return visit;
    }
}

