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

    final private String INSERT_ALL = "INSERT INTO TABLE utenti (email, password, first_name, last_name, avatar_id) " +
            "values (?, ?, ?, ?, ?);";
    final private String INSERT_TEST = "INSERT INTO utenti (email, password, first_name, last_name, avatar_id) " +
            "values ('test', 'test', 'test', 'test', 1);";

    // TODO: insert without avatar_id

    @Override
    public void insert(User user) {
        try {
            Connection conn;
            conn = DAOManager.getConnection();
            System.out.println("ok connection");
    /*
            PreparedStatement preparedStatement = conn.prepareStatement(INSERT_ALL);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getFirstName());
            preparedStatement.setString(4, user.getLastName());
            preparedStatement.setInt(5, user.getAvatarPathId());
*/
            PreparedStatement preparedStatement = conn.prepareStatement(INSERT_TEST);
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
    public User getById(int user_id) {
        return null;
    }


    public User mapRowToActor(ResultSet rs) throws SQLException {
        User user = new User(
                rs.getInt("user_id"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getInt("avatar_id"));
        return user;
    }
}
