package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.DrugType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * {@link DrugPrescriptionDAO} JDBC concrete implementation.
 */
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

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM drug_prescription WHERE drug_prescription_id = ?;";
    final private String GET_ALL = "SELECT * FROM drug_prescription;";
    final private String COUNT = "SELECT COUNT(*) FROM drug_prescription;";

    final private String GET_VALID_BY_PATIENT = "SELECT * FROM drug_prescription " +
            "WHERE date_prescribed + interval '1 month' >= now() AND patient_id = ? " +
            "AND chemist_id IS NULL AND date_sold IS NULL AND ticket_paid = FALSE " +
            "ORDER BY date_prescribed DESC;";
    final private String GET_BY_PATIENT = "SELECT * FROM drug_prescription " +
            "WHERE patient_id = ? ORDER BY date_prescribed DESC;";

    final private String GET_BY_DATE_SOLD = "SELECT * FROM drug_prescription " +
            "WHERE date_sold::date = ?::date";

    /**
     * Friend DAO saved for optimization purposes (since invoking DAOFactory is slow)
     */
    private DrugTypeDAO drugTypeDAO;

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCDrugPrescriptionDAO(Connection con) throws DAOFactoryException {
        super(con);
        drugTypeDAO = DAOFACTORY.getDAO(DrugTypeDAO.class);
    }

    @Override
    public void insert(DrugPrescription drugPrescription) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, drugPrescription.getPractitionerID());
            stm.setString(2, drugPrescription.getPatientID());
            stm.setInt(3, drugPrescription.getType().getID());
            stm.setTimestamp(4, drugPrescription.getDatePrescribed());
            stm.setTimestamp(5, drugPrescription.getDateSold());
            stm.setString(6, drugPrescription.getChemistID());
            stm.setInt(7, drugPrescription.getTicket());
            stm.setBoolean(8, drugPrescription.getTicketPaid());
            stm.setString(9, drugPrescription.getDescription());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("DrugPrescriptionDAO::insert affected " + row + " rows");
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
            stm.setInt(3, drugPrescription.getType().getID());
            stm.setTimestamp(4, drugPrescription.getDatePrescribed());
            stm.setTimestamp(5, drugPrescription.getDateSold());
            stm.setString(6, drugPrescription.getChemistID());
            stm.setInt(7, drugPrescription.getTicket());
            stm.setBoolean(8, drugPrescription.getTicketPaid());
            stm.setString(9, drugPrescription.getDescription());
            stm.setInt(10, drugPrescription.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("DrugPrescriptionDAO::update affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error updating DrugPrescription: ", e);
        }
    }

    @Override
    public void delete(DrugPrescription drugPrescription) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setInt(1, drugPrescription.getID());

            int row = stm.executeUpdate();
            Logger.getLogger("C18").info("DrugPrescriptionDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting DrugPrescription: ", e);
        }
    }

    @Override
    public DrugPrescription getByPrimaryKey(Integer primaryKey) throws DAOException {
        DrugPrescription res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
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
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
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

    public List<DrugPrescription> getValidByPatient(String patientID) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;

        try (PreparedStatement stm = CON.prepareStatement(GET_VALID_BY_PATIENT)) {
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

    public List<DrugPrescription> getByPatient(String patientID) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;

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
            throw new DAOException("Error getting valid DrugPrescriptions by patient: : ", e);
        }
    }

    public List<DrugPrescription> getByDateSold(Timestamp ts) throws DAOException {
        List<DrugPrescription> res = new ArrayList<>();
        DrugPrescription tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_DATE_SOLD)) {
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

            DrugType drugType = drugTypeDAO.getByPrimaryKey(rs.getInt("drug_type"));

            drugPrescription.setID(rs.getInt("drug_prescription_id"));
            drugPrescription.setPractitionerID(rs.getString("practitioner_id"));
            drugPrescription.setPatientID(rs.getString("patient_id"));
            drugPrescription.setType(drugType);
            drugPrescription.setDatePrescribed(rs.getTimestamp("date_prescribed"));
            drugPrescription.setDateSold(rs.getTimestamp("date_sold"));
            drugPrescription.setChemistID(rs.getString("chemist_id"));
            drugPrescription.setTicket(rs.getInt("ticket"));
            drugPrescription.setTicketPaid(rs.getBoolean("ticket_paid"));
            drugPrescription.setDescription(rs.getString("description"));

            return drugPrescription;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to DrugPrescription: ", e);
        }
    }
}

