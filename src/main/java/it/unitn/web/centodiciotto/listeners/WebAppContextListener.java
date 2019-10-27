package it.unitn.web.centodiciotto.listeners;

import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.utils.Crypto;
import it.unitn.web.utils.PhotoService;
import it.unitn.web.utils.SendEmail;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class WebAppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            JDBCDAOFactory.configure();
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            SendEmail.configure();

            Crypto.configure(daoFactory);
            PhotoService.configure(daoFactory, sce.getServletContext());

            sce.getServletContext().setAttribute("daoFactory", daoFactory);
        } catch (DAOFactoryException e) {
            throw new RuntimeException(e);
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
