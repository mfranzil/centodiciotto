package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.DAO;

public interface UserDAO extends DAO<User, String> {

    void insert(User user);

    void update(User user);

    void delete(User user);
}
