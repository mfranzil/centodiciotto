package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
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
public class JDBCSpecializedDoctorDAO extends JDBCDAO<SpecializedDoctor, String> implements SpecializedDoctorDAO {

    final private String INSERT = "INSERT INTO specialized_doctor (doctor_id, first_name, last_name)" +
            " values (?, ?, ?);";
    final private String UPDATE = "UPDATE specialized_doctor SET (first_name, last_name) = (?, ?)" +
            " WHERE doctor_id = ?;";
    final private String DELETE = "DELETE FROM specialized_doctor WHERE doctor_id = ?;";

    final private String FINDBYPRIMARYKEY = "SELECT * FROM specialized_doctor WHERE doctor_id = ?;";
    final private String SELECTALL = "SELECT * FROM specialized_doctor;";
    final private String COUNT = "SELECT COUNT(*) FROM specialized_doctor;";

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

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

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
            stm.setString(3, specializedDoctor.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating SpecializedDoctor: ", e);
        }
    }

    @Override
    public void delete(SpecializedDoctor specializedDoctor) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, specializedDoctor.getID());

            int row = stm.executeUpdate();
            System.out.println("Rows affected: " + row);
        } catch (SQLException e) {
            throw new DAOException("Error deleting SpecializedDoctor: ", e);
        }
    }

    @Override
    public SpecializedDoctor getByPrimaryKey(String doctor_id) throws DAOException {
        SpecializedDoctor res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYPRIMARYKEY)) {
            stm.setString(1, doctor_id);

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
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
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

            return specializedDoctor;
        } catch (SQLException e) {
            throw new DAOException("Error mapping row to SpecializedDoctor: ", e);
        }
    }

}

