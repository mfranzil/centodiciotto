/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 12 - Shopping List Implementation
 * UniTN
 */
package it.unitn.web.centodiciotto.servlets;

import com.alibaba.fastjson.JSON;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOException;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.disi.wp.commons.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.DatatablesResponse;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet that sends users collection.
 *
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
public class UsersServlet extends HttpServlet {

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for storage system");
        }
        try {
            userDao = daoFactory.getDAO(UserDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer draw = 0;
            Long start = 0L;
            Long length = -1L;
            String searchValue = request.getParameter("search[value]");
            String drawParameter = request.getParameter("draw");
            if (drawParameter != null) {
                draw = Integer.parseInt(drawParameter);
            }
            String startParameter = request.getParameter("start");
            if (startParameter != null) {
                start = Long.parseLong(startParameter);
            }
            String lengthParameter = request.getParameter("length");
            if (lengthParameter != null) {
                length = Long.parseLong(lengthParameter);
            }

            Long usersCount = userDao.getCount();
            if (length < 0) {
                length = usersCount - start;
            }
            List<User> users = userDao.pageBySearchValue(searchValue, start, length);

            DatatablesResponse tableResponse = new DatatablesResponse(draw, usersCount, usersCount, users);

            String usersJsoned = JSON.toJSONString(tableResponse);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.append(usersJsoned);
            out.flush();

        } catch (DAOException ex) {
            response.sendError(500, "Impossible to access the persistence layer: " + ex.getMessage());
        }
    }
}
