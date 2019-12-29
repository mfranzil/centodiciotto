package it.unitn.web.centodiciotto.listeners;

import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.services.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

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
        } catch (DAOFactoryException | ServiceException e) {
            throw new RuntimeException("Error during WebApplication init: ", e);
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
