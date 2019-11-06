package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.DrugListDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.DrugList;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCDrugPrescriptionDAO extends JDBCDAO<DrugPrescription, Integer> implements DrugPrescriptionDAO {

    final private String INSERT = "INSERT INTO drug_prescription" +
            " (practitioner_id, patient_id, drug_type, date_prescribed," +
            " date_sold, chemist_id, ticket, ticket_paid, description)" +
            " values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
    final private String UPDATE = "UPDATE drug_prescription SET" +
            " (practitioner_id, patient_id, drug_type, date_prescribed," +
            " date_sold, chemist_id, ticket, ticket_paid, description)" +
            " = (?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE drug_prescription_id = ?;";
    final private String DELETE = "DELETE FROM drug_prescription WHERE drug_prescription_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM drug_prescription WHERE drug_prescription_id = ?;";
    final private String SELECTALL = "SELECT * FROM drug_prescription;";
    final private String COUNT = "SELECT COUNT(*) FROM drug_prescription;";

    final private String FINDBYPATIENT = "SELECT * FROM drug_prescription " +
            "WHERE patient_id = ? order by date_prescribed asc;";
    final private String FINDBYPRACTITIONER = "SELECT * FROM drug_prescription WHERE practitioner_id = ?;";
    final private String FINDEXPIRED = "SELECT * FROM drug_prescription " +
            "WHERE date_prescribed + interval '1 month' >= now() " +
            "AND NOT(chemist_id IS NULL AND date_sold IS NULL AND ticket_paid = false);";
    final private String FINDVALID = "SELECT * FROM drug_prescription " +
            "WHERE date_prescribed + interval '1 month' < now() " +
            "AND chemist_id IS NULL AND date_sold IS NULL AND ticket_paid = false " +
            "order by date_prescribed asc;";
    final private String FINDVALIDBYPATIENT = "SELECT * FROM drug_prescription " +
            "WHERE date_prescribed + interval '1 month' < now() AND patient_id = ? " +
            "AND chemist_id IS NULL AND date_sold IS NULL AND ticket_paid = false " +
            "order by date_prescribed asc;";
    final private String FINDUNPAIDBYPATIENT = "SELECT * FROM drug_prescription " +
            "WHERE patient_id = ? AND chemist_id IS NOT NULL AND date_sold IS NOT NULL AND ticket_paid = false " +
            "order by date_prescribed asc;";
    final private String FINDBYDATESOLD = "SELECT * from drug_prescription " +
            "where date_sold::date = ?::date";

    public JDBCDrugPrescriptionDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(DrugPrescription drugPrescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, drugPrescription.getPractitionerID());
            stm.setString(2, drugPrescription.getPatientID());
            stm.setInt(3, drugPrescription.getDrugType().getID());
            stm.setTimestamp(4, drugPrescription.getDatePrescribed());
            stm.setTimestamp(5, drugPrescription.getDateSold());
            stm.setString(6, drugPrescription.getChemistID());
            stm.setInt(7, drugPrescription.getTicket());
            stm.setBoolean(8, drugPrescription.getTicketPaid());
            stm.setString(9, drugPrescription.getDescription());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting DrugPrescription: ", e);
        }
    }

    @Override
    public void update(DrugPrescription drugPrescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, drugPrescription.getPractitionerID());
            stm.setString(2, drugPrescription.getPatientID());
            stm.setInt(3, drugPrescription.getDrugType().getID());
            stm.setTimestamp(4, drugPrescription.getDatePrescribed());
            stm.setTimestamp(5, drugPrescription.getDateSold());
            stm.setString(6, drugPrescription.getChemistID());
            stm.setInt(7, drugPrescription.getTicket());
            stm.setBoolean(8, drugPrescription.getTicketPaid());
            stm.setString(9, drugPrescription.getDescription());
            stm.setInt(10, drugPrescription.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating DrugPrescription: ", e);
        }
    }

    @Override
    public void delete(DrugPrescription drugPrescription) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, drugPrescription.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting DrugPrescription: ", e);
        }
    }

    @Override
    public DrugPrescription getByPrimaryKey(Integer primaryKey) throws DAOException {
        DrugPrescription res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setInt(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DrugPrescription by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<DrugPrescription> getAll() throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all DrugPrescriptions: ", e);
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
            throw new DAOException("Error counting DrugPrescriptions: ", e);
        }
        return -1L;
    }

    @Override
    public List<DrugPrescription> getByPatient(String patientID) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;
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
            throw new DAOException("Error getting DrugPrescription by Patient: ", e);
        }
    }

    public List<DrugPrescription> getByPractitioner(String practitionerID) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRACTITIONER)) {
            stm.setString(1, practitionerID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DrugPrescription by Practitioner: ", e);
        }
    }

    public List<DrugPrescription> getExpired() throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDEXPIRED)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting expired DrugPrescriptions: ", e);
        }
    }

    public List<DrugPrescription> getValid() throws DAOException {
        List<DrugPrescription> res;
        res = new ArrayList<>();
        DrugPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDVALID)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting valid DrugPrescriptions: ", e);
        }
    }

    public List<DrugPrescription> getValidByPatient(String patientID) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;

        try (PreparedStatement stm = CON.prepareStatement(FINDVALIDBYPATIENT)) {
            stm.setString(1, patientID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting valid DrugPrescriptions by patient: : ", e);
        }
    }

    public List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYDATESOLD)) {
            stm.setTimestamp(1, ts);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting DrugPrescriptions by date: ", e);
        }
    }

    @Override
    protected DrugPrescription mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            DrugPrescription drugPrescription = new DrugPrescription();


            DrugListDAO drugListDAO = DAOFACTORY.getDAO(DrugListDAO.class);
            DrugList drugList = drugListDAO.getByPrimaryKey(rs.getInt("drug_type"));

            drugPrescription.setID(rs.getInt("drug_prescription_id"));
            drugPrescription.setPractitionerID(rs.getString("practitioner_id"));
            drugPrescription.setPatientID(rs.getString("patient_id"));
            drugPrescription.setDrugType(drugList);
            drugPrescription.setDatePrescribed(rs.getTimestamp("date_prescribed"));
            drugPrescription.setDateSold(rs.getTimestamp("date_sold"));
            drugPrescription.setChemistID(rs.getString("chemist_id"));
            drugPrescription.setTicket(rs.getInt("ticket"));
            drugPrescription.setTicketPaid(rs.getBoolean("ticket_paid"));
            drugPrescription.setDescription(rs.getString("description"));

            return drugPrescription;
        } catch (SQLException | DAOFactoryException e) {
            throw new DAOException("Error mapping row to DrugPrescription: ", e);
        }
    }
}

