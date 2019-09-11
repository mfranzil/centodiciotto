package it.unitn.web.centodiciotto.persistence.dao.jdbc;

import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class JDBCUserDAO extends JDBCDAO<User, String> implements UserDAO {

    final private String INSERT = "INSERT INTO user_ (email, password) values (?, ?);";
    final private String UPDATE = "UPDATE user_ SET password = ? WHERE email = ?;";

    private static boolean containsItemFromArray(String inputString, String[] items) {
        // Convert the array of String items as a Stream
        // For each element of the Stream call inputString.contains(element)
        // If you have any match returns true, false otherwise
        return Arrays.stream(items).anyMatch(inputString::contains);
    }

    public JDBCUserDAO(Connection con) {
        super(con);
    }

    @Override
    public void insert(User user) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(INSERT);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error inserting user: " + e.getMessage());
        }
    }

    @Override
    public void update(User user) {
        try {
            PreparedStatement preparedStatement = CON.prepareStatement(UPDATE);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());

            int row = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + row);

        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
        }
    }

/*
    @Override
    public void delete(User user) {
    }

    @Override
    public User getByEmail(String email) {
        return null;
    }
*/

    public User getByEmailAndPassword(String email, String password, String role) throws DAOException {
        if (email == null || password == null) {
            throw new DAOException("Email and password are mandatory fields",
                    new NullPointerException("email or password are null"));
        }

        String role_table;

        String[] roles = { "patient", "general_practitioner", "specialized_doctor", "chemist", "health_service"};

        role_table = role;
        if(!containsItemFromArray(role, roles)){
            role_table = "user_";
        }

        String Select = "SELECT * FROM user_ JOIN " + role_table + " ON user_.email = " + role_table + ".email ";

        try (PreparedStatement stm = CON.prepareStatement(Select + "WHERE user_.email = ? AND password = ?")) {
            stm.setString(1, email);
            stm.setString(2, password);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    User user; // = new User(rs.getString("email"), rs.getString("password"));
                    //TODO add all classes
                    switch (role) {
                        case "patient":
                            user = new Patient(rs.getString("email"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"), rs.getDate("birth_date"), rs.getString("birth_place"), rs.getString("ssn"), rs.getString("gender").charAt(0), rs.getString("living_province"), rs.getString("general_practitioner_email"));
                            break;
                        case "general_practitioner":
                            user = new GeneralPractitioner(rs.getString("email"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("working_province"));
                            break;
                        case "specialized_doctor":
                        case "chemist":
                        case "health_service":
                        default:
                            user = new User(rs.getString("email"), rs.getString("password"));
                    }
                    System.out.println(user instanceof Patient);
                    return user;
                }
                return null;
            }
        } catch (SQLException ex) {
            throw new DAOException("Impossible to get the list of users", ex);
        }
    }

    // TODO Da modificare

    @Override
    public Long getCount() throws DAOException {
        return null;
    }

    @Override
    public User getByPrimaryKey(String primaryKey) throws DAOException {
        return null;
    }

    @Override
    public List<User> getAll() throws DAOException {
        return null;
    }
}
