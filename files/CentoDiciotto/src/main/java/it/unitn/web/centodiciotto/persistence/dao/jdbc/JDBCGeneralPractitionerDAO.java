package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class JDBCGeneralPractitionerDAO extends JDBCDAO<GeneralPractitioner, String> implements GeneralPractitionerDAO {

    final private String INSERT = "INSERT INTO general_practitioner (email, first_name, last_name, working_province) values (?, ?, ?, ?);";

    /**
     * The base constructor for all the JDBC DAOs.
     *
     * @param con the internal {@code Connection}.
     * @author Stefano Chirico
     * @since 1.0.0.190406
     */
    public JDBCGeneralPractitionerDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(GeneralPractitioner generalPractitioner) {
        try {
            System.out.println("ok connection");

            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, generalPractitioner.getEmail());
            preparedStatement.setString(2, generalPractitioner.getFirstName());
            preparedStatement.setString(3, generalPractitioner.getLastName());
            preparedStatement.setString(4, generalPractitioner.getWorkingProvince());

            //PreparedStatement preparedStatement = conn.prepareStatement(INSERT_TEST);
            System.out.println("ok statement");

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting User: " + e.getMessage());
        }
        // Connection and Prepared Statement automatically closed

    }

    @Override
    public void update(GeneralPractitioner generalPractitioner) {

    }

    @Override
    public void delete(GeneralPractitioner generalPractitioner) {

    }

    @Override
    public GeneralPractitioner getByEmail(String email) {
        return null;
    }

    @Override
    public Long getCount() throws DAOException {
        return null;
    }

    @Override
    public GeneralPractitioner getByPrimaryKey(String primaryKey) throws DAOException {
        return null;
    }

    @Override
    public List<GeneralPractitioner> getAll() throws DAOException {
        return null;
    }
}

