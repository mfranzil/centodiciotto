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

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCPendingVisitDAO extends JDBCDAO<PendingVisit, Pair<String, String>> implements PendingVisitDAO {

    final private String INSERT = "INSERT INTO pending_visit (practitioner_id, patient_id) values (?, ?);";
    final private String UPDATE = "UPDATE pending_visit SET (practitioner_id)  =  (?) WHERE patient_id = ?;";
    final private String DELETE = "DELETE FROM pending_visit WHERE patient_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM pending_visit WHERE patient_id = ? AND practitioner_id = ?;";
    final private String SELECTALL = "SELECT * FROM pending_visit;";
    final private String COUNT = "SELECT COUNT(*) FROM pending_visit;";

    final private String FINDBYPRACTITIONER = "SELECT * FROM pending_visit WHERE practitioner_id = ?;";

    public JDBCPendingVisitDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(PendingVisit pendingVisit) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, pendingVisit.getPractitionerID());
            stm.setString(2, pendingVisit.getPatientID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting PendingVisit: ", e);
        }
    }

    @Override
    public void update(PendingVisit pendingVisit) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, pendingVisit.getPractitionerID());
            stm.setString(2, pendingVisit.getPatientID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating PendingVisit: ", e);
        }
    }

    @Override
    public void delete(PendingVisit pendingVisit) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, pendingVisit.getPatientID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting PendingVisit: ", e);
        }
    }

    @Override
    public PendingVisit getByPrimaryKey(Pair<String, String> key) throws DAOException {
        PendingVisit res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setString(1, key.getFirst());
            stm.setString(2, key.getSecond());

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pendingVisit: ", e);
        }
        return null;
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
            throw new DAOException("Error getting all PendingVisits: ", e);
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
            throw new DAOException("Error counting PendingVisits: ", e);
        }
        return -1L;
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
            throw new DAOException("Error getting PendingVisit by primary key: ", e);
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
            throw new DAOException("Error mapping row to PendingVisit: ", e);
        }
    }
}

