package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCVisitDAO extends JDBCDAO<Visit, Integer> implements VisitDAO {

    final private String INSERT = "INSERT INTO visit " +
            "(practitioner_id, patient_id, visit_date, report_available, report) values (?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE visit SET " +
            "(practitioner_id, patient_id, visit_date, report_available, report) =" +
            " (?, ?, ?, ?, ?) WHERE visit_id = ?;";
    final private String DELETE = "DELETE FROM visit WHERE visit_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM visit WHERE visit_id = ?;";
    final private String SELECTALL = "SELECT * FROM visit;";
    final private String COUNT = "SELECT COUNT(*) FROM visit;";

    final private String FINDBYPATIENT = "SELECT * FROM visit WHERE patient_id = ?;";
    final private String FINDBYPRACTITIONER = "SELECT * FROM visit WHERE practitioner_id = ?;";
    final private String GETLASTPATIENTVISIT = "SELECT * from visit where patient_id = " +
            "? and visit_date <= localtimestamp order by visit_date desc limit 1";

    public JDBCVisitDAO(Connection con) {
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

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

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
            stm.setInt(6, visit.getVisitID());

            int row = stm.executeUpdate();
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
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting Visit: ", e);
        }
    }

    @Override
    public Visit getByPrimaryKey(Integer visitID) throws DAOException {
        Visit res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
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
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
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
    public List<Visit> getByPatient(String PatientEmail) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, PatientEmail);

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
    public List<Visit> getByPractitioner(String practitionerEmail) throws DAOException {
        List<Visit> res = new ArrayList<>();
        Visit tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRACTITIONER)) {
            stm.setString(1, practitionerEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Visit by PractitionerID: ", e);
        }
    }

    @Override
    public Visit getLastVisitByPatient(Patient patient) throws DAOException {
        Visit visit = null;
        try {
            String email = patient.getID();
            PreparedStatement stm = CON.prepareStatement(GETLASTPATIENTVISIT);
            stm.setString(1, email);

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
    protected Visit mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Visit visit = new Visit();

            visit.setVisitID(rs.getInt("visit_id"));
            visit.setPractitionerID(rs.getString("practitioner_id"));
            visit.setPatientID(rs.getString("patient_id"));
            visit.setDate(rs.getTimestamp("visit_date"));
            visit.setReportAvailable(rs.getBoolean("report_available"));
            visit.setReport(rs.getString("report"));

            return visit;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Visit: ", e);
        }
    }

}

