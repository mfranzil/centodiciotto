/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO JDBC Implementation
 * UniTN
 */
package it.unitn.web.persistence.dao.factories.jdbc;

import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.jdbc.JDBCDAO;

import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Logger;

public class JDBCDAOFactory implements DAOFactory {
    private static JDBCDAOFactory instance;
    private final transient Connection CON;
    private final transient HashMap<Class, DAO> DAO_CACHE;

    private JDBCDAOFactory() throws DAOFactoryException {
        super();

        String url = null;
        String username = null;
        String password = null;

        Properties data = new Properties();

        try (InputStream stream = JDBCDAOFactory.class
                .getClassLoader().getResourceAsStream("database.properties")) {
            data.load(stream);

            String hostname = data.getProperty("HostName");
            String defaultDatabase = data.getProperty("DefaultDatabase");
            username = data.getProperty("UserName");
            password = data.getProperty("Password");

            url = "jdbc:postgresql://" + hostname + "/" + defaultDatabase;
        } catch (Exception e) {
            throw new RuntimeException("Error reading configuration file: " + e.getMessage());
        }

        try {
            Class.forName("org.postgresql.Driver", true, getClass().getClassLoader());
        } catch (ClassNotFoundException cnfe) {
            throw new RuntimeException(cnfe.getMessage(), cnfe.getCause());
        }

        try {
            CON = DriverManager.getConnection(url, username, password);
        } catch (SQLException sqle) {
            throw new DAOFactoryException("Cannot create connection", sqle);
        }

        DAO_CACHE = new HashMap<>();
    }

    public static void configure() throws DAOFactoryException {
        if (instance == null) {
            instance = new JDBCDAOFactory();
        } else {
            throw new DAOFactoryException("DAOFactory already configured. You can call configure only one time");
        }
    }

    public static JDBCDAOFactory getInstance() throws DAOFactoryException {
        if (instance == null) {
            throw new DAOFactoryException("DAOFactory not yet configured. " +
                    "Call DAOFactory.configure(String ini_file) before use the class");
        }
        return instance;
    }

    @Override
    public void shutdown() {
        try {
            DriverManager.getConnection("jdbc:postgresql:;shutdown=true");
        } catch (SQLException sqle) {
            Logger.getLogger(JDBCDAOFactory.class.getName()).info(sqle.getMessage());
        }
    }

    @Override
    public <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoInterface) throws DAOFactoryException {
        DAO dao = DAO_CACHE.get(daoInterface);
        if (dao != null) {
            return (DAO_CLASS) dao;
        }

        Package pkg = daoInterface.getPackage();
        String prefix = pkg.getName() + ".jdbc.JDBC";

        try {
            Class daoClass = Class.forName(prefix + daoInterface.getSimpleName());

            Constructor<DAO_CLASS> constructor = daoClass.getConstructor(Connection.class);
            DAO_CLASS daoInstance = constructor.newInstance(CON);
            if (!(daoInstance instanceof JDBCDAO)) {
                throw new DAOFactoryException("The daoInterface passed as parameter doesn't extend JDBCDAO class");
            }
            DAO_CACHE.put(daoInterface, daoInstance);
            return daoInstance;
        } catch (ClassNotFoundException | NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException | SecurityException ex) {
            throw new DAOFactoryException("Impossible to return the DAO", ex);
        }
    }
}
