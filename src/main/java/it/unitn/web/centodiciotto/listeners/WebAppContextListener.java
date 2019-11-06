package it.unitn.web.centodiciotto.listeners;

import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.utils.ExcelService;
import it.unitn.web.utils.exceptions.ServiceException;
import it.unitn.web.utils.services.CryptoService;
import it.unitn.web.utils.services.EmailService;
import it.unitn.web.utils.services.PDFService;
import it.unitn.web.utils.services.PhotoService;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


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
