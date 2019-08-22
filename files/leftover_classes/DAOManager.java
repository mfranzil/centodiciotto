package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.dao.implementations.PatientDaoImpl;
import it.unitn.web.centodiciotto.persistence.dao.implementations.UserDAOImpl;
import org.ini4j.Wini;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAOManager {

    public UserDAO userDAO = new UserDAOImpl();
    public PatientDAO patientDAO = new PatientDaoImpl();

    public static Connection initConn(String ini_file) {

        try {
            Wini ini = new Wini(new File(ini_file)); // TODO: relative path
            String hostname = ini.get("database", "HostName");
            String defaultDatabase = ini.get("database", "DefaultDatabase");

            username = ini.get("database", "UserName");
            password = ini.get("database", "Password");

            url = "jdbc:postgresql://" + hostname + "/" + defaultDatabase;

        } catch (Exception e) {
            System.err.println("Error reading configuration file: " + e.getMessage());
        }

        if (url != null && username != null && password != null) {
            try {
                conn = DriverManager.getConnection(url, username, password);
            } catch (SQLException e) {
                System.err.println("Error while connecting to database: " + e.getMessage());

            }
        }

        return conn;

    }

    public static Connection getConnection() {
        return initConn();
    }

}
