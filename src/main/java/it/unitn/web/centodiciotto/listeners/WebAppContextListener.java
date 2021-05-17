package it.unitn.web.centodiciotto.listeners;

import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.services.*;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * ContextListener for this web application.
 * <p>
 * Initializes the DAOFactory and all the services located in the
 * {@link it.unitn.web.centodiciotto.services} package.
 * <p>
 * At the moment of Context destruction, it calls the {@link DAOFactory} destructor.
 */
@WebListener
public class WebAppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            ServletContext sc = sce.getServletContext();

            JDBCDAOFactory.configure();
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            EmailService.configure();
            CryptoService.configure(daoFactory);
            PhotoService.configure(daoFactory, sc);
            ExcelService.configure(daoFactory, sc);
            PDFService.configure(sc);

            sc.setAttribute("daoFactory", daoFactory);

            // Load the resource server URL

            Properties data = new Properties();
            InputStream stream = WebAppContextListener.class
                    .getClassLoader().getResourceAsStream("resource-server.properties");

            if (stream == null) {
                throw new ServiceException("Error loading email.properties file");
            }

            data.load(stream);
            String resourceServer = data.getProperty("URL");

            sc.setAttribute("resourceServer", resourceServer);
            sc.setAttribute("imageServer", resourceServer + "/img");
            sc.setAttribute("excelServer", resourceServer + "/xls");
            sc.setAttribute("pdfServer", "/centodiciotto/pdf");


        } catch (ServiceException e) {
            throw new RuntimeException("Error during WebApplication init: ", e);
        } catch (IOException e) {
            throw new RuntimeException("I/O error while opening email.properties file", e);
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Service initialization error for DAO", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            DAOFactory daoFactory = (DAOFactory) sce.getServletContext().getAttribute("daoFactory");
            if (daoFactory != null) {
                daoFactory.shutdown();
            }
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error during WebApplication closure: ", e);
        }
    }
}
