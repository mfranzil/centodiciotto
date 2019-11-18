package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * {@link SpecializedDoctorDAO} JDBC concrete implementation.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class JDBCSpecializedDoctorDAO extends JDBCDAO<SpecializedDoctor, String> implements SpecializedDoctorDAO {

    final private String INSERT = "INSERT INTO specialized_doctor (doctor_id, first_name, last_name, working_place)" +
            " values (?, ?, ?, ?);";
    final private String UPDATE = "UPDATE specialized_doctor SET (first_name, last_name, working_place) = (?, ?, ?)" +
            " WHERE doctor_id = ?;";
    final private String DELETE = "DELETE FROM specialized_doctor WHERE doctor_id = ?;";

    final private String GET_BY_PRIMARY_KEY = "SELECT * FROM specialized_doctor WHERE doctor_id = ?;";
    final private String GET_ALL = "SELECT * FROM specialized_doctor ORDER BY last_name ASC;";
    final private String COUNT = "SELECT COUNT(*) FROM specialized_doctor;";

    /**
     * Instantiates the {@link JDBCDAO} using the currently opened connection.
     *
     * @param con the {@link Connection} to the database
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public JDBCSpecializedDoctorDAO(Connection con) throws DAOFactoryException {
        super(con);
    }

    @Override
    public void insert(SpecializedDoctor specializedDoctor) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(INSERT);
            stm.setString(1, specializedDoctor.getID());
            stm.setString(2, specializedDoctor.getFirstName());
            stm.setString(3, specializedDoctor.getLastName());
            stm.setString(4, specializedDoctor.getWorkingPlace());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO, "SpecializedDoctorDAO::insert affected " + row + " rows");

        } catch (SQLException e) {
            throw new DAOException("Error inserting Specialized Doctor: ", e);
        }
    }

    @Override
    public void update(SpecializedDoctor specializedDoctor) throws DAOException {
        try {
            PreparedStatement stm = CON.prepareStatement(UPDATE);
            stm.setString(1, specializedDoctor.getFirstName());
            stm.setString(2, specializedDoctor.getLastName());
            stm.setString(3, specializedDoctor.getWorkingPlace());
            stm.setString(4, specializedDoctor.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO, "SpecializedDoctorDAO::update affected " + row + " rows");

        } catch (SQLException e) {
            throw new DAOException("Error updating SpecializedDoctor: ", e);
        }
    }

    @Override
    public void delete(SpecializedDoctor specializedDoctor) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, specializedDoctor.getID());

            int row = stm.executeUpdate();
            Logger.getGlobal().log(Level.INFO, "SpecializedDoctorDAO::delete affected " + row + " rows");
        } catch (SQLException e) {
            throw new DAOException("Error deleting SpecializedDoctor: ", e);
        }
    }

    @Override
    public SpecializedDoctor getByPrimaryKey(String primaryKey) throws DAOException {
        SpecializedDoctor res;
        try (PreparedStatement stm = CON.prepareStatement(GET_BY_PRIMARY_KEY)) {
            stm.setString(1, primaryKey);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = mapRowToEntity(rs);
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting SpecializedDoctor by primary key: ", e);
        }
        return null;
    }

    @Override
    public List<SpecializedDoctor> getAll() throws DAOException {
        List<SpecializedDoctor> res = new ArrayList<>();
        SpecializedDoctor tmp;
        try (PreparedStatement stm = CON.prepareStatement(GET_ALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = mapRowToEntity(rs);
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all SpecializedDoctors: ", e);
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
            throw new DAOException("Error counting SpecializedDoctors: ", e);
        }
        return -1L;
    }

    @Override
    protected SpecializedDoctor mapRowToEntity(ResultSet rs) throws DAOException {
        try {
            SpecializedDoctor specializedDoctor = new SpecializedDoctor();

            specializedDoctor.setID(rs.getString("doctor_id"));
            specializedDoctor.setFirstName(rs.getString("first_name"));
            specializedDoctor.setLastName(rs.getString("last_name"));
            specializedDoctor.setWorkingPlace(rs.getString("working_place"));

            return specializedDoctor;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to SpecializedDoctor: ", e);
        }
    }

}

