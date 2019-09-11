package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class PasswordChangeServlet extends HttpServlet {

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            userDao = daoFactory.getDAO(UserDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /*
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String oldPassword = request.getParameter("old-password");
        String newPassword = request.getParameter("new-password");

        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        try {

        if (user.getPassword().equals(oldPassword)) {
            user.setPassword(newPassword);
            userDao.update(user);
            response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/user"));

        }


        // LA SEGUENTE CAGATA E' TEMPORANEA

            if (user == null) {
                request.setAttribute("loginResult", true);
                response.sendRedirect(response.encodeRedirectURL(contextPath + "login"));
            } else {
                request.getSession().setAttribute("user", user);
               /* } else {
                    response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/shopping.lists.html?id=" + user.getId()));
                }
            }
        } catch (DAOException ex) {
            //TODO: log exception
            request.getServletContext().log("Error while updating the user", ex);
        }
        */
    }
}
