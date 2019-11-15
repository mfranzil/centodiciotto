package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * The type Jdbc visit dao.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCVisitDAO extends JDBCDAO<Visit, Integer> implements VisitDAO {

    final private String INSERT = "INSERT INTO visit " +
            "(practitioner_id, patient_id, visit_date, report_available, report, booked) values (?, ?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE visit SET " +
            "(practitioner_id, patient_id, visit_date, report_available, report, booked) =" +
            " (?, ?, ?, ?, ?, ?) WHERE visit_id = ?;";
    final private String DELETE = "DELETE FROM visit WHERE visit_id = ?;";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM visit WHERE visit_id = ?;";
    final private String GET_ALL = "SELECT * FROM visit;";
    final private String COUNT = "SELECT COUNT(*) FROM visit;";

    final private String GET_PENDING_BY_PRACTITIONER = "SELECT * FROM visit WHERE " +
            "practitioner_id = ? AND booked = FALSE;";
    final private String GET_BOOKED_BY_PRACTITIONER = "SELECT * FROM visit WHERE " +
            "practitioner_id = ? AND booked = TRUE AND visit_date IS NOT null " +
            "AND report_available = FALSE ORDER BY visit_date DESC;";
    final private String GET_DONE_BY_PRACTITIONER = "SELECT * FROM visit WHERE " +
            "practitioner_id = ? AND report_available = true ORDER BY visit_date DESC;";
    final private String GET_DONE_BY_PATIENT = "SELECT * FROM visit WHERE patient_id = ?" +
            " AND report_available = true ORDER BY visit_date DESC;";
    final private String GET_LAST_BY_PATIENT = "SELECT * FROM visit WHERE patient_id = " +
            "? AND visit_date <= localtimestamp ORDER BY visit_date DESC limit 1;";
    final private String GET_PENDING_BY_PRACTITIONER_AND_PATIENT = "SELECT * FROM visit " +
            "WHERE practitioner_id = ? AND patient_id = ? AND booked = FALSE;";
    final private String GET_BY_DATE = "SELECT * FROM visit WHERE visit_date::date = ?::date;";

    /**
     * Instantiates a new Jdbc visit dao.
     *
     * @param con the con
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCVisitDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Visit visit) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, visit.getPractitionerID());
            stm.setString(2, visit.getPatientID());
            stm.setTimestamp(3, visit.getDate());
            stm.setBoolean(4, visit.getReportAvailable());
            stm.setString(5, visit.getReport());
            stm.setBoolean(6, visit.isBooked());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"VisitDAO::insert affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error inserting Visit: ", e);
        }
    }

    @Override
    public void update(Visit visit) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, visit.getPractitionerID());
            stm.setString(2, visit.getPatientID());
            stm.setTimestamp(3, visit.getDate());
            stm.setBoolean(4, visit.getReportAvailable());
            stm.setString(5, visit.getReport());
            stm.setBoolean(6, visit.isBooked());
            stm.setInt(7, visit.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"VisitDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating Visit: ", e);
        }
    }

    @Override
    public void delete(Visit visit) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, visit.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"VisitDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting Visit: ", e);
        }
    }

    @Override
    public Visit getByPrimaryKey(Integer visitID) throws DAOException {
        Visit res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setInt(1, visitID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Visit: ", e);
        }
        return null;
    }

    @Override
    public List<Visit> getAll() throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Visits: ", e);
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
            throw new DAOException("Error counting Visits: ", e);
        }
        return -1L;
    }

    @Override
    public List<Visit> getPendingByPractitioner(String practitionerID) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_PRACTITIONER)) {
            stm.setString(1, practitionerID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Pending Visits by practitionerID: ", e);
        }
    }

    @Override
    public List<Visit> getBookedByPractitioner(String practitionerID) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BOOKED_BY_PRACTITIONER)) {
            stm.setString(1, practitionerID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Booked Visits by practitionerID: ", e);
        }
    }

    @Override
    public List<Visit> getDoneByPractitioner(String practitionerID) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_DONE_BY_PRACTITIONER)) {
            stm.setString(1, practitionerID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting done Visits by practitionerID: ", e);
        }
    }

    @Override
    public List<Visit> getDoneByPatient(String patientID) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_DONE_BY_PATIENT)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Visit by PatientID: ", e);
        }
    }

    @Override
    public Visit getLastByPatient(String patientID) throws DAOException {
        Visit visit = null;
        try {
            PreparedStatement stm = CON.prepareStatement(GET_LAST_BY_PATIENT);
            stm.setString(1, patientID);

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                visit = mapRowToEntity(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting last Visit: ", e);
        }
        return visit;
    }

    @Override
    public Visit getPendingByPractitionerAndPatient(String practitionerID, String patientID) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_PRACTITIONER_AND_PATIENT)) {
            stm.setString(1, practitionerID);
            stm.setString(2, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return mapRowToEntity(rs);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting PendingVisits by practitioner and patient: ", e);
        }
        return null;
    }

    @Override
    public List<Visit> getByDate(Timestamp ts) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_DATE)) {
            stm.setTimestamp(1, ts);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Visits by date: ", e);
        }
    }

    @Override
    protected Visit mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Visit visit = new Visit();

            visit.setID(rs.getInt("visit_id"));
            visit.setPractitionerID(rs.getString("practitioner_id"));
            visit.setPatientID(rs.getString("patient_id"));
            visit.setDate(rs.getTimestamp("visit_date"));
            visit.setReportAvailable(rs.getBoolean("report_available"));
            visit.setReport(rs.getString("report"));
            visit.setBooked(rs.getBoolean("booked"));

            return visit;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Visit: ", e);
        }
    }

}

