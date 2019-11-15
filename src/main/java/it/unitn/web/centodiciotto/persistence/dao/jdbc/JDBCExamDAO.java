package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.ExamType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * {@link ExamDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCExamDAO extends JDBCDAO<Exam, Integer> implements ExamDAO {

    final private String INSERT = "INSERT INTO exam (patient_id, doctor_id, exam_type, done, date," +
            " result, health_service_id, ticket, ticket_paid, practitioner_id, booked, recall) " +
            "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE exam SET (patient_id, doctor_id, exam_type, done, date," +
            " result, health_service_id, ticket, ticket_paid, practitioner_id, booked, recall) " +
            "= (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE exam_id = ?;";
    final private String DELETE = "DELETE FROM exam WHERE exam_id = ?;";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM exam WHERE exam_id = ?;";
    final private String GET_ALL = "SELECT * FROM exam;";
    final private String COUNT = "SELECT COUNT(*) FROM exam;";

    final private String GET_BY_PATIENT = "SELECT * FROM exam WHERE patient_id = ?";
    final private String GET_BY_PATIENT_LAST_YEAR = "SELECT * FROM exam WHERE date <= localtimestamp AND " +
            "date > localtimestamp - interval '1 year' AND patient_id = ?;";
    final private String GET_UNPAID_BY_PATIENT = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND ticket_paid = false AND done = true";
    final private String GET_PENDING_BY_PATIENT = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND booked IS FALSE";
    final private String GET_NOT_PENDING_BY_PATIENT = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND date IS NOT NULL";
    final private String GET_PENDING_BY_DOCTOR = "SELECT * FROM exam WHERE doctor_id = ? " +
            "AND booked IS false";
    final private String GET_BOOKED_BY_DOCTOR = "SELECT * FROM exam WHERE doctor_id = ? " +
            "AND date IS NOT NULL AND done = false AND booked = true";
    final private String GET_DONE_BY_DOCTOR = "SELECT * FROM exam WHERE doctor_id = ? " +
            "AND done = true";
    final private String GET_PENDING_BY_HS = "SELECT * FROM exam WHERE health_service_id = ? " +
            "AND booked IS false";
    final private String GET_BOOKED_BY_HS = "SELECT * FROM exam WHERE health_service_id = ? " +
            "AND date IS NOT NULL AND done = false AND booked = true";
    final private String GET_DONE_BY_HS = "SELECT * FROM exam WHERE health_service_id = ? " +
            "AND done = true";
    final private String GET_PENDING_BY_PATIENT_AND_TYPE = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND exam_type = ? AND booked IS FALSE";
    final private String GET_BY_PATIENT_NOT_DOCTOR_NOT_HS = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND doctor_id IS NULL AND health_service_id IS NULL";
    final private String GET_PENDING_BY_PATIENT_AND_TYPE_AND_DOCTOR = "SELECT * FROM exam WHERE doctor_id = ? " +
            "AND patient_id = ? AND exam_type = ? AND booked IS false";
    final private String GET_PENDING_BY_HS_AND_TYPE_AND_DOCTOR = "SELECT * FROM exam WHERE health_service_id = ? " +
            "AND patient_id = ? AND exam_type = ? AND booked IS false";
    final private String GET_BY_DATE = "SELECT * FROM exam WHERE date::date = ?::date";
    final private String GET_PENDING_RECALL_BY_IDS = "SELECT * FROM exam WHERE done = false AND exam_type = ? " +
            "AND health_service_id = ? AND patient_id = ? AND recall IS NOT null;";

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCExamDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(Exam exam) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, exam.getPatientID());
            stm.setString(2, exam.getDoctorID());
            stm.setInt(3, exam.getType().getID());
            stm.setBoolean(4, exam.getDone());
            stm.setTimestamp(5, exam.getDate());
            stm.setString(6, exam.getResult());
            stm.setString(7, exam.getHealthServiceID());
            stm.setInt(8, exam.getTicket());
            stm.setBoolean(9, exam.isTicketPaid());
            stm.setString(10, exam.getPractitionerID());
            stm.setBoolean(11, exam.isBooked());

            if (exam.getRecall() == null) {
                stm.setNull(12, Types.INTEGER);
            } else {
                stm.setInt(12, exam.getRecall());
            }

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"ExamDAO::insert affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error inserting Exam: ", e);
        }
    }

    @Override
    public void update(Exam exam) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, exam.getPatientID());
            stm.setString(2, exam.getDoctorID());
            stm.setInt(3, exam.getType().getID());
            stm.setBoolean(4, exam.getDone());
            stm.setTimestamp(5, exam.getDate());
            stm.setString(6, exam.getResult());
            stm.setString(7, exam.getHealthServiceID());
            stm.setInt(8, exam.getTicket());
            stm.setBoolean(9, exam.isTicketPaid());
            stm.setString(10, exam.getPractitionerID());
            stm.setBoolean(11, exam.isBooked());
            if (exam.getRecall() == null || exam.getRecall() == 0) {
                stm.setNull(12, Types.INTEGER);
            } else {
                stm.setInt(12, exam.getRecall());
            }


            stm.setInt(13, exam.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"ExamDAO::update affected " + row + " rows");

        } catch (SQLException e) {
            throw new DAOException("Error updating Exam: ", e);
        }
    }

    @Override
    public void delete(Exam exam) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO,"ExamDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting Exam: ", e);
        }
    }

    @Override
    public Exam getByPrimaryKey(Integer examID) throws DAOException {
        Exam res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setInt(1, examID);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Exam by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<Exam> getAll() throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
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
    public Long getCount() throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(COUNT)) {
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return Integer.toUnsignedLong(rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error counting Exams: ", e);
        }
        return -1L;
    }

    @Override
    public List<Exam> getByPatient(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PATIENT)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Exams by PatientID: ", e);
        }
    }

    @Override
    public List<Exam> getByPatientLastYear(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PATIENT_LAST_YEAR)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting last year Exams by PatientID: ", e);
        }
    }

    @Override
    public List<Exam> getUnpaidByPatient(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_UNPAID_BY_PATIENT)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting not paid Exams by PatientID: ", e);
        }
    }

    public List<Exam> getNotPendingByPatient(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_NOT_PENDING_BY_PATIENT)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting not paid Exams by PatientID: ", e);
        }
    }

    @Override
    public List<Exam> getPendingByPatient(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_PATIENT)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending and not booked Exams by PatientID: ", e);
        }
    }

    public Exam getPendingByPatientAndExamType(String patientID, Integer examID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_PATIENT_AND_TYPE)) {
            stm.setString(1, patientID);
            stm.setInt(2, examID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                if (res.size() > 1) {
                    throw new DAOException("Error getting pending and not booked Exams by PatientID: more than one pending");
                }
                return res.get(0);
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending and not booked Exams by PatientID: ", e);
        }
    }

    @Override
    public List<Exam> getPendingByPatientDoctorHealthServiceNotSelected(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PATIENT_NOT_DOCTOR_NOT_HS)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending Exams with no doctor selected by PatientID: ", e);
        }
    }

    public List<Exam> getPendingByDoctor(String doctorID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_DOCTOR)) {
            stm.setString(1, doctorID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending Exams for Doctor: ", e);
        }
    }

    public List<Exam> getBookedByDoctor(String doctorID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BOOKED_BY_DOCTOR)) {
            stm.setString(1, doctorID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting booked Exams by Doctor: ", e);
        }
    }

    public List<Exam> getDoneByDoctor(String doctorID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_DONE_BY_DOCTOR)) {
            stm.setString(1, doctorID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting done Exams by Doctor: ", e);
        }
    }


    public List<Exam> getPendingByHS(String healthServiceID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_HS)) {
            stm.setString(1, healthServiceID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending Exams for HS: ", e);
        }
    }

    public List<Exam> getBookedByHS(String healthServiceID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BOOKED_BY_HS)) {
            stm.setString(1, healthServiceID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting booked Exams by HS: ", e);
        }
    }

    public List<Exam> getDoneByHS(String healthServiceID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_DONE_BY_HS)) {
            stm.setString(1, healthServiceID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting done Exams by HS: ", e);
        }
    }

    public Exam getPendingByDoctorAndPatient(String doctorID, String patientID, Integer examID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_PATIENT_AND_TYPE_AND_DOCTOR)) {
            stm.setString(1, doctorID);
            stm.setString(2, patientID);
            stm.setInt(3, examID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                if (res.size() > 1) {
                    throw new DAOException("Error getting pending Exams for Doctor for given patient: multiple pending exam per patient");
                } else {
                    return res.get(0);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending Exams for Doctor for given patient: ", e);
        }
    }

    public Exam getPendingByHSAndPatient(String healthServiceID, String patientID, Integer examID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_BY_HS_AND_TYPE_AND_DOCTOR)) {
            stm.setString(1, healthServiceID);
            stm.setString(2, patientID);
            stm.setInt(3, examID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                if (res.size() > 1) {
                    throw new DAOException("Error getting pending Exams for HS for given patient: " +
                            "multiple pending exam per patient");
                } else {
                    return res.get(0);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending Exams for Doctor for given patient: ", e);
        }
    }

    @Override
    public List<Exam> getByDate(Timestamp ts) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
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
            throw new DAOException("Error getting Exams by date: ", e);
        }
    }

    public Exam getPendingRecall(Integer examType, String healthServiceID, String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_PENDING_RECALL_BY_IDS)) {
            stm.setInt(1, examType);
            stm.setString(2, healthServiceID);
            stm.setString(3, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }

                if (res.size() == 1) {
                    return res.get(0);
                } else if (res.size() == 0) {
                    return null;
                } else {
                    throw new DAOException("More than one pending Recall found" +
                            " (e=" + examType + ",hs=" + healthServiceID + ",p=" + patientID);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting pending Recalls: ", e);
        }
    }


    @Override
    protected Exam mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            Exam exam = new Exam();

            ExamTypeDAO examTypeDAO = DAOFACTORY.getDAO(ExamTypeDAO.class);
            ExamType examType = examTypeDAO.getByPrimaryKey(rs.getInt("exam_type"));

            exam.setID(rs.getInt("exam_id"));
            exam.setPatientID(rs.getString("patient_id"));
            exam.setDoctorID(rs.getString("doctor_id"));
            exam.setType(examType);
            exam.setDone(rs.getBoolean("done"));
            exam.setDate(rs.getTimestamp("date"));
            exam.setResult(rs.getString("result"));
            exam.setHealthServiceID(rs.getString("health_service_id"));
            exam.setTicket(rs.getInt("ticket"));
            exam.setTicketPaid(rs.getBoolean("ticket_paid"));
            exam.setPractitionerID(rs.getString("practitioner_id"));
            exam.setBooked(rs.getBoolean("booked"));
            exam.setRecall(rs.getInt("recall"));

            return exam;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to Exam: ", e);
        }
    }
}

