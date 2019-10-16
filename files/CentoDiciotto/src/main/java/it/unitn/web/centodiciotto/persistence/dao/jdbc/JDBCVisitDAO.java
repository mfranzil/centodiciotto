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

public class JDBCVisitDAO extends JDBCDAO<Visit, Integer> implements VisitDAO {

    final private String INSERT = "INSERT INTO visit (practitioner_id, patient_id, visit_date, report_available, report) values (?, ?, ?, ?, ?);";
    final private String FINDBYPATIENT = "SELECT * FROM visit WHERE patient_id = ?;";
    final private String FINDBYPRACTITIONER = "SELECT * FROM visit WHERE practitioner_id = ?;";
    final private String FINDBYID = "SELECT * FROM visit WHERE visit_id = ?;";
    final private String SELECTALL = "SELECT * FROM visit;";
    final private String DELETE = "DELETE FROM visit WHERE visit_id = ?;";
    final private String UPDATE = "UPDATE visit SET (practitioner_id, patient_id, visit_date, report_available, report)  =  (?, ?, ?, ?, ?) WHERE visit_id = ?;";
    final private String GETLASTPATIENTVISIT = "SELECT * from visit where patient_id = " +
            "? and visit_date <= localtimestamp order by visit_date desc limit 1";

    public JDBCVisitDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(Visit visit) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, visit.getPractitionerEmail());
            preparedStatement.setString(2, visit.getPatientEmail());
            preparedStatement.setTimestamp(3, visit.getVisitDate());
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
            preparedStatement.setTimestamp(3, visit.getVisitDate());
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
    public Visit getByPrimaryKey(Integer visitID) throws DAOException {
        Visit res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYID)) {
            stm.setInt(1, visitID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
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
            PreparedStatement preparedStatement = CON.prepareStatement(GETLASTPATIENTVISIT);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) { // only one
                visit = mapRowToEntity(rs);
            }
        } catch (SQLException e) {
            throw new DAOException("Error retrieving current visit: ", e);
        }
        return visit;
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
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all Exams: ", e);
        }
    }

    @Override
    protected Visit mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Visit visit = new Visit();

            visit.setVisitID(rs.getInt("visit_id"));
            visit.setPractitionerEmail(rs.getString("practitioner_id"));
            visit.setPatientEmail(rs.getString("patient_id"));
            visit.setVisitDate(rs.getTimestamp("visit_date"));
            visit.setReportAvailable(rs.getBoolean("report_available"));
            visit.setReport(rs.getString("report"));

            return visit;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to Visit: ", e);
        }
    }

}

