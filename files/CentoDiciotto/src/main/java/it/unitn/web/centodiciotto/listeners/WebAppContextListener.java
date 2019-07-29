/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 12 - Shopping List Implementation
 * UniTN
 */
package it.unitn.web.centodiciotto.listeners;

import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.disi.wp.commons.persistence.dao.factories.DAOFactory;
import it.unitn.disi.wp.commons.persistence.dao.factories.jdbc.JDBCDAOFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.logging.Logger;

/**
 * Web application life-cycle listener.
 *
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
public class WebAppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String dburl = sce.getServletContext().getInitParameter("dburl");
        try {
            JDBCDAOFactory.configure(dburl);
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();
            sce.getServletContext().setAttribute("daoFactory", daoFactory);
        } catch (DAOFactoryException ex) {
            Logger.getLogger(getClass().getName()).severe(ex.toString());
            throw new RuntimeException(ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DAOFactory daoFactory = (DAOFactory) sce.getServletContext().getAttribute("daoFactory");
        if (daoFactory != null) {
            daoFactory.shutdown();
        }
        daoFactory = null;
    }
}
