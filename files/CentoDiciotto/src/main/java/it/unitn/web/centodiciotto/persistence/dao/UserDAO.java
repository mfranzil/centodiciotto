package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface UserDAO {

    public void insert(User user);

    public void update(User user); // TODO: throws exceptions ?

    public void delete(User user);

    public User getByEmail(String email);

    public User mapRowToUser(ResultSet rs) throws SQLException;

}
