package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;
//import it.unitn.web.centodiciotto.persistence.dao.DAOManager;

public class DAOMain {


    public static void main(String[] args) {
        DAOManager dao = new DAOManager();

        User user = new User("prova", "prova");

        dao.userDAO.insert(user);

    }
}
