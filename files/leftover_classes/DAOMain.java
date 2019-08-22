package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;

import java.sql.Date;
//import it.unitn.web.centodiciotto.persistence.dao.DAOManager;

public class DAOMain {


    public static void main(String[] args) {
        DAOManager dao = new DAOManager();

        //User user = new User("prova", "prova");

        Patient patient = new Patient("prova", "alessio", "marcolino", new Date(0),
                "VR", "erterer", 'M', "TN", "concetta.pisano@gmail.com", 2);



        //dao.userDAO.insert(user);

        dao.patientDAO.insert(patient);

    }
}
