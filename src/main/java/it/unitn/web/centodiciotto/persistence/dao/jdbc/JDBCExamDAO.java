package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCExamDAO extends JDBCDAO<Exam, Integer> implements ExamDAO {

    final private String INSERT = "INSERT INTO exam (patient_id, doctor_id, exam_type, done, date," +
            " result, health_service_id, ticket, ticket_paid, recall, practitioner_id, booked) " +
            "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE exam SET (patient_id, doctor_id, exam_type, done, date," +
            " result, health_service_id, ticket, ticket_paid, recall, practitioner_id, booked) " +
            "= (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE exam_id = ?;";
    final private String DELETE = "DELETE FROM exam WHERE exam_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM exam WHERE exam_id = ?;";
    final private String SELECTALL = "SELECT * FROM exam;";
    final private String COUNT = "SELECT COUNT(*) FROM exam;";

    final private String FINDBYPATIENT = "SELECT * FROM exam WHERE patient_id = ?";
    final private String FINDBYPATIENTLASTYEAR = "select * from exam where date <= localtimestamp and " +
            "date > localtimestamp - interval '1 year' and patient_id = ?;";
    final private String FINDNAMEBYID = "SELECT exam_description FROM exam_list WHERE exam_id = ?";
    final private String FINDBYPATIENTNOTPAID = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND ticket_paid = false AND done = true";
    final private String FINDBYPATIENTNOTBOOKED = "SELECT * FROM exam WHERE patient_id = ? " +
            "AND booked IS FALSE";
    final private String FINDBYDATE = "SELECT * from exam where date::date = ?::date";
    final private String FINDRECALLSBYHS = "SELECT * from exam where recall = true and health_service_id = ?";
    final private String FINDPENDINGBYIDS = "select * from exam where done = false and exam_type = ? " +
            "and health_service_id = ? and patient_id = ?;";

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
            stm.setInt(10, exam.getRecall());
            stm.setString(11, exam.getPractitionerID());
            stm.setBoolean(12, exam.isBooked());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

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
            stm.setBoolean(10, exam.isTicketPaid());
            stm.setInt(11, exam.getRecall());
            stm.setString(11, exam.getPractitionerID());
            stm.setBoolean(12, exam.isBooked());

            stm.setInt(11, exam.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating Exam: ", e);
        }
    }

    @Override
    public void delete(Exam exam) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, exam.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting Exam: ", e);
        }
    }

    @Override
    public Exam getByPrimaryKey(Integer examID) throws DAOException {
        Exam res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
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
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENT)) {
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
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENTLASTYEAR)) {
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
    public List<Exam> getByPatientNotPaid(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENTNOTPAID)) {
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
    public List<Exam> getByPatientNotBooked(String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPATIENTNOTBOOKED)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting not booked Exams by PatientID: ", e);
        }
    }

    @Override
    public List<Exam> getByDate(Timestamp ts) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYDATE)) {
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

    public List<Exam> getRecallsByHealthService(String healthServiceID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDRECALLSBYHS)) {
            stm.setString(1, healthServiceID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting Exams/Recalls by Province: ", e);
        }
    }

    public Exam getPendingRecall(Integer examType, String healthServiceID, String patientID) throws DAOException {
        List<Exam> res = new ArrayList<>();
        Exam tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDPENDINGBYIDS)) {
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

            ExamListDAO examListDAO = DAOFACTORY.getDAO(ExamListDAO.class);
            ExamList examList = examListDAO.getByPrimaryKey(rs.getInt("exam_type"));

            exam.setID(rs.getInt("exam_id"));
            exam.setPatientID(rs.getString("patient_id"));
            exam.setDoctorID(rs.getString("doctor_id"));
            exam.setType(examList);
            exam.setDone(rs.getBoolean("done"));
            exam.setDate(rs.getTimestamp("date"));
            exam.setResult(rs.getString("result"));
            exam.setHealthServiceID(rs.getString("health_service_id"));
            exam.setTicket(rs.getInt("ticket"));
            exam.setTicketPaid(rs.getBoolean("ticket_paid"));
            exam.setRecall(rs.getInt("recall"));
            exam.setPractitionerID(rs.getString("practitioner_id"));
            exam.setBooked(rs.getBoolean("booked"));

            return exam;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to Exam: ", e);
        }
    }
}

