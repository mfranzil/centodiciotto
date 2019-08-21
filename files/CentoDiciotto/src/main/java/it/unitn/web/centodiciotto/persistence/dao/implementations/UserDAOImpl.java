package it.unitn.web.centodiciotto.persistence.dao.implementations;
import it.unitn.web.centodiciotto.persistence.dao.DAOManager;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    final private String INSERT = "INSERT INTO user_ (email, password) values (?, ?);";


    @Override
    public void insert(User user) {
        try {
            Connection conn;
            conn = DAOManager.getConnection();
            System.out.println("ok connection");

            PreparedStatement preparedStatement = conn.prepareStatement(INSERT);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());

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
    public void update(User user) {

    }

    @Override
    public void delete(User user) {

    }

    @Override
    public User getByEmail(String email) {
        return null;
    }


    public User mapRowToActor(ResultSet rs) throws SQLException {
        User user = new User(
                rs.getString("email"),
                rs.getString("password"));
        return user;
    }
}
