package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
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
public class JDBCExamPrescriptionDAO extends JDBCDAO<ExamPrescription, Integer> implements ExamPrescriptionDAO {

    final private String INSERT = "INSERT INTO exam_prescription (practitioner_id, patient_id, exam_type, booked) " +
            "values (?, ?, ?, ?);";
    final private String DELETE = "DELETE FROM exam_prescription WHERE exam_prescription_id = ?;";
    final private String UPDATE = "UPDATE exam_prescription SET (practitioner_id, patient_id, exam_type, booked) =" +
            " (?, ?, ?, ?) WHERE exam_prescription_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM exam_prescription WHERE exam_prescription_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam_prescription;";
    final private String COUNT = "SELECT COUNT(*) FROM exam_prescription;";

    final private String FINDBYPATIENT = "SELECT * FROM exam_prescription WHERE patient_id = ?;";


    public JDBCExamPrescriptionDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(ExamPrescription examPrescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, examPrescription.getPractitionerID());
            stm.setString(2, examPrescription.getPatientID());
            stm.setInt(3, examPrescription.getExamType().getID());
            stm.setBoolean(4, examPrescription.getBooked());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting ExamPrescription: ", e);
        }
    }

    @Override
    public void update(ExamPrescription examPrescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, examPrescription.getPractitionerID());
            stm.setString(2, examPrescription.getPatientID());
            stm.setInt(3, examPrescription.getExamType().getID());
            stm.setBoolean(4, examPrescription.getBooked());
            stm.setInt(5, examPrescription.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating ExamPrescription: ", e);
        }
    }

    @Override
    public void delete(ExamPrescription examPrescription) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, examPrescription.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting ExamPrescription: ", e);
        }
    }

    @Override
    public ExamPrescription getByPrimaryKey(Integer primaryKey) throws DAOException {
        ExamPrescription res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamPrescription by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<ExamPrescription> getAll() throws DAOException {
        List<ExamPrescription> res = new ArrayList<>();
        ExamPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all ExamPrescriptions: ", e);
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
            throw new DAOException("Error counting ExamPrescriptions: ", e);
        }
        return -1L;
    }

    @Override
    public List<ExamPrescription> getByPatient(String patientEmail) throws DAOException {
        List<ExamPrescription> res = new ArrayList<>();
        ExamPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
            stm.setString(1, patientEmail);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting ExamPrescriptions by PatientID: ", e);
        }
    }

    @Override
    protected ExamPrescription mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            ExamPrescription examPrescription = new ExamPrescription();

            ExamListDAO examListDAO = DAOFACTORY.getDAO(ExamListDAO.class);
            ExamList examList = examListDAO.getByPrimaryKey(rs.getInt("exam_type"));

            examPrescription.setID(rs.getInt("exam_prescription_id"));
            examPrescription.setPractitionerID(rs.getString("practitioner_id"));
            examPrescription.setPatientID(rs.getString("patient_id"));
            examPrescription.setExamType(examList);
            examPrescription.setBooked(rs.getBoolean("booked"));

            return examPrescription;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to ExamPrescription: ", e);
        }
    }

}

