package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCSpecializedDoctorDAO extends JDBCDAO<SpecializedDoctor, String> implements SpecializedDoctorDAO {

    final private String INSERT = "INSERT INTO specialized_doctor (email, first_name, last_name) values (?, ?, ?);";
    final private String FINDBYEMAIL = "SELECT * FROM specialized_doctor WHERE email = ?;";
    final private String SELECTALL = "SELECT * FROM specialized_doctor;";
    final private String DELETE = "DELETE FROM specialized_doctor WHERE email = ?;";
    final private String UPDATE = "UPDATE specialized_doctor SET (first_name, last_name) = (?, ?) WHERE email = ?;";
    public JDBCSpecializedDoctorDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(SpecializedDoctor specializedDoctor) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, specializedDoctor.getEmail());
            preparedStatement.setString(2, specializedDoctor.getFirstName());
            preparedStatement.setString(3, specializedDoctor.getLastName());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error inserting Specialized Doctor: ", e);
        }
    }

    @Override
    public void update(SpecializedDoctor specializedDoctor) throws DAOException {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, specializedDoctor.getFirstName());
            preparedStatement.setString(2, specializedDoctor.getLastName());
            preparedStatement.setString(3, specializedDoctor.getEmail());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            throw new DAOException("Error updating SpecializedDoctor: ", e);
        }
    }

    @Override
    public void delete(SpecializedDoctor specializedDoctor) throws DAOException {
        try (PreparedStatement stm = CON.prepareStatement(DELETE)) {
            stm.setString(1, specializedDoctor.getEmail());

            int row = stm.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error deleting SpecializesDoctor by email: ", e);
        }
    }

    @Override
    public SpecializedDoctor getByPrimaryKey(String email) throws DAOException {
        SpecializedDoctor res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new SpecializedDoctor(rs.getString("email"), "", "", rs.getString("first_name"), rs.getString("last_name"));
                    return res;
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting SpecializedDoctor by email: ", e);
        }
        return null;
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
            throw new DAOException("Error counting SpecializedDoctors: ", e);
        }
        return res;
    }


    @Override
    public List<SpecializedDoctor> getAll() throws DAOException {
        List<SpecializedDoctor> res = new ArrayList<>();
        SpecializedDoctor tmp;
        try (PreparedStatement stm = CON.prepareStatement(SELECTALL)) {
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    tmp = new SpecializedDoctor(rs.getString("email"), "", "", rs.getString("first_name"), rs.getString("last_name"));
                    res.add(tmp);
                }
                return res;
            }
        } catch (SQLException e) {
            throw new DAOException("Error getting all SpecializedDoctors: ", e);
        }
    }
}

