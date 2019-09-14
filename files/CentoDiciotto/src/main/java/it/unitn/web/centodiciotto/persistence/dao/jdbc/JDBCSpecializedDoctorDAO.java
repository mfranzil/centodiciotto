package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class JDBCSpecializedDoctorDAO extends JDBCDAO<SpecializedDoctor, String> implements SpecializedDoctorDAO {

    final private String INSERT = "INSERT INTO specialized_doctor (email, first_name, last_name) values (?, ?, ?);";
    final private String FINDBYEMAIL = "SELECT * FROM specialized_doctor WHERE email = ?;";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCSpecializedDoctorDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(SpecializedDoctor specializedDoctor) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, specializedDoctor.getEmail());
            preparedStatement.setString(2, specializedDoctor.getFirstName());
            preparedStatement.setString(3, specializedDoctor.getLastName());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting Specialized Doctor: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(SpecializedDoctor specializedDoctor) {

    }

    @Override
    public void delete(SpecializedDoctor specializedDoctor) {

    }

    @Override
    public SpecializedDoctor getByPrimaryKey(String email) {
        SpecializedDoctor res;
        try (PreparedStatement stm = CON.prepareStatement(FINDBYEMAIL)) {
            stm.setString(1, email);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    res = new SpecializedDoctor(rs.getString("email"), "", rs.getString("first_name"), rs.getString("last_name"));
                    return res;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting SpecializedDoctor by email: " + e.getMessage());
        }
        return null;
    }

    @Override
    public Long getCount() throws DAOException {
        return null;
    }

    @Override
    public List<SpecializedDoctor> getAll() throws DAOException {
        return null;
    }
}

