package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.PendingVisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.PendingVisit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;
import it.unitn.web.utils.Pair;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCPendingVisitDAO extends JDBCDAO<PendingVisit, Pair<String, String>> implements PendingVisitDAO {

    final private String INSERT = "INSERT INTO pending_visit (practitioner_id, patient_id) values (?, ?);";
    final private String FINDBYPRACTITIONER = "SELECT * FROM pending_visit WHERE practitioner_id = ?;";
    final private String FINDBYID = "SELECT * FROM pending_visit WHERE patient_id = ? AND practitioner_id = ?;";
    final private String SELECTALL = "SELECT * FROM pending_visit;";
    final private String DELETE = "DELETE FROM pending_visit WHERE patient_id = ?;";
    final private String UPDATE = "UPDATE pending_visit SET (practitioner_id)  =  (?) WHERE patient_id = ?;";

    public JDBCPendingVisitDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(PendingVisit pendingVisit) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, pendingVisit.getPractitionerID());
            preparedStatement.setString(2, pendingVisit.getPatientID());

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
            preparedStatement.setString(1, pendingVisit.getPractitionerID());
            preparedStatement.setString(2, pendingVisit.getPatientID());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating pendingVisit: ", e);
        }
    }

    @Override
    public void delete(PendingVisit pendingVisit) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, pendingVisit.getPatientID());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting pendingVisit by ID: ", e);
        }
    }

    @Override
    public PendingVisit getByPrimaryKey(Pair<String, String> key) throws DAOException {
        PendingVisit res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setString(1, key.getFirst());
            stm.setString(2, key.getSecond());

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
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
                    tmp = mapRowToEntity(rs);
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
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all pendingVisit: ", e);
        }
    }

    @Override
    protected PendingVisit mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            PendingVisit pendingVisit = new PendingVisit();

            pendingVisit.setPatientID(rs.getString("patient_id"));
            pendingVisit.setPractitionerID(rs.getString("practitioner_id"));

            return pendingVisit;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Pending Visit: ", e);
        }
    }
}

