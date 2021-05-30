package it.unitn.web.centodiciotto.persistence.dao.factories.jdbc;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.base.jdbc.JDBCDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;

/**
 * A JDBC implementation of {@link DAOFactory}.
 */
@SuppressWarnings("unchecked")
public class JDBCDAOFactory implements DAOFactory {
    private static JDBCDAOFactory instance;
    private final transient Connection CON;
    private final transient HashMap<Class, DAO> DAO_CACHE;
    private final int MAX_RETRIES = 20;

    /**
     * Private singleton constructor for this {@link DAOFactory}.
     * <p>
     * It retrieves configuration info for the database from the Resource {@code database.properties} located in the
     * appropriate folder, then sets up a connection using the {@link org.postgresql.Driver} driver.
     *
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    private JDBCDAOFactory() throws DAOFactoryException {
        String url;
        String username;
        String password;

        Properties data = new Properties();

        InputStream stream = JDBCDAOFactory.class.getClassLoader().getResourceAsStream("database.properties");

        if (stream != null) {
            try {
                data.load(stream);
                String hostname = data.getProperty("HostName");
                String defaultDatabase = data.getProperty("DefaultDatabase");
                username = data.getProperty("UserName");
                password = data.getProperty("Password");

                url = "jdbc:postgresql://" + hostname + "/" + defaultDatabase;
            } catch (IOException e) {
                throw new DAOFactoryException("Error reading database.properties file: ", e);
            }
        } else {
            throw new DAOFactoryException("Missing database.properties file.");
        }

        try {
            Class.forName("org.postgresql.Driver", true, getClass().getClassLoader());
        } catch (ClassNotFoundException cnfe) {
            throw new DAOFactoryException(cnfe.getMessage(), cnfe.getCause());
        }

        Connection tmpConn = null;
        Exception thrownEx = null;

        for (int i = 0; i < MAX_RETRIES && tmpConn == null; i++) {
            try {
                tmpConn = DriverManager.getConnection(url, username, password);
            } catch (SQLException sqle) {
                thrownEx = sqle;
                System.out.println("Cannot create connection [" + sqle.getMessage() + "], " +
                        "(retries left:" + (MAX_RETRIES - i) + ")...");
            }
        }

        if (tmpConn != null) {
            CON = tmpConn;
        } else {
            throw new DAOFactoryException("Cannot create connection. Out of tries.", thrownEx);
        }

        DAO_CACHE = new HashMap<>();
    }

    /**
     * Call this method before use the instance of this class.
     *
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    public static void configure() throws DAOFactoryException {
        if (instance == null) {
            instance = new JDBCDAOFactory();
        } else {
            throw new DAOFactoryException("DAOFactory already configured. You can call configure only one time");
        }
    }

    /**
     * Returns the singleton instance of this {@link DAOFactory}.
     *
     * @return the singleton instance of this {@link DAOFactory}.
     * @throws DAOFactoryException if this {@link DAOFactory} is not yet configured.
     */
    public static JDBCDAOFactory getInstance() throws DAOFactoryException {
        if (instance == null) {
            throw new DAOFactoryException("DAOFactory not yet configured. " +
                    "Call DAOFactory.configure() before use the class");
        }
        return instance;
    }

    @Override
    public void shutdown() throws DAOFactoryException {
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
            } catch (SQLException e) {
                throw new DAOFactoryException("Error deregistering driver " + driver + ": ", e);
            }

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
        } catch (ClassNotFoundException | NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException | SecurityException e) {
            throw new DAOFactoryException("Impossible to return the DAO", e);
        }
    }
}
