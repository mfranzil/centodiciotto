package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;

public interface UserDAO {

    public void insert(User user);

    public void update(User user); // TODO: throws exceptions ?

    public void delete(User user);

    public User getByEmail(String email);

}
