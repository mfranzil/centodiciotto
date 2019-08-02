package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.User;
//import it.unitn.web.centodiciotto.persistence.dao.DAOManager;

public class DAOMain {


    public static void main(String[] args) {
        DAOManager dao = new DAOManager();
        System.out.println("1");

        User user = new User(null, "prova", "prova", "mario", "rossi", 1);

        System.out.println("2");

        dao.userDAO.insert(user);
        System.out.println("3");
    }
}
