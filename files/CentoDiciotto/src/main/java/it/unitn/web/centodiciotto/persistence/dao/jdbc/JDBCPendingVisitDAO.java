package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PendingVisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.PendingVisit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCPendingVisitDAO extends JDBCDAO<PendingVisit, Integer> implements PendingVisitDAO {

    final private String INSERT = "INSERT INTO pending_visit (practitioner_id, patient_id) values (?, ?);";
    final private String FINDBYPRACTITIONER = "SELECT * FROM pending_visit WHERE practitioner_id = ?;";
    final private String FINDBYID = "SELECT * FROM pending_visit WHERE pending_visit_id = ?;";
    final private String SELECTALL = "SELECT * FROM pending_visit;";
    final private String DELETE = "DELETE FROM pending_visit WHERE pending_visit_id = ?;";
    final private String UPDATE = "UPDATE pending_visit SET (practitioner_id, patient_id)  =  (?, ?) WHERE pending_visit_id = ?;";
    public JDBCPendingVisitDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(PendingVisit pendingVisit) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, pendingVisit.getPractitionerEmail());
            preparedStatement.setString(2, pendingVisit.getPatientEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting pendingVisit: ", e);
        }
    }

    @Override
    public void update(PendingVisit pendingVisit) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, pendingVisit.getPractitionerEmail());
            preparedStatement.setString(2, pendingVisit.getPatientEmail());
            preparedStatement.setInt(3, pendingVisit.getPendingVisitID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating pendingVisit: ", e);
        }
    }

    @Override
    public void delete(PendingVisit pendingVisit) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, pendingVisit.getPendingVisitID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting pendingVisit by ID: ", e);
        }
    }

    @Override
    public PendingVisit getByPrimaryKey(Integer VisitID) throws DAOException {
        PendingVisit res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, VisitID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToExam(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Err or getting pendingVisit by ID: ", e);
        }
        return null;
    }

    @Override
    public List<PendingVisit> getByPractitioner(String PractitionerEmail) throws DAOException {
        List<PendingVisit> res = new ArrayList<>();
        PendingVisit tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRACTITIONER)) {
            stm.setString(1, PractitionerEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToExam(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pendingVisit by PatientID: ", e);
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
            throw new DAOException("Error counting pendingVisit: ", e);
        }
        return res;
    }

    @Override
    public List<PendingVisit> getAll() throws DAOException {
        List<PendingVisit> res = new ArrayList<>();
        PendingVisit tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToExam(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all pendingVisit: ", e);
        }
    }

    public PendingVisit mapRowToExam(ResultSet rs) throws SQLException {
        PendingVisit pendingVisit = new PendingVisit(
                rs.getInt("pending_visit_id"),
                rs.getString("patient_id"),
                rs.getString("practitioner_id"));
        return pendingVisit;
    }
}

