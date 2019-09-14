package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

public class FinalizePasswordResetServlet extends HttpServlet {

    private UserDAO userDao;
    private PasswordResetDAO prDao;
    private String emailRequestingReset;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            userDao = daoFactory.getDAO(UserDAO.class);
            prDao = daoFactory.getDAO(PasswordResetDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        String token = request.getParameter("token");
        PasswordReset pr = prDao.getByToken(token);

        if (pr != null && pr.getExpiringDate().after(new Date(System.currentTimeMillis()))) {
            emailRequestingReset = pr.getEmail();
            request.getRequestDispatcher("/jsp/password_recovery.jsp").forward(request, response);
        } else {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user;

        String email = request.getParameter("email");
        String newPassword = request.getParameter("new-password");

        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");

        if (!email.equals(emailRequestingReset)) {
            response.setStatus(400);
            return;
        }
        try {
            user = userDao.getByPrimaryKey(email);
            user.setPassword(newPassword);
            userDao.update(user);
            response.setStatus(200);
        } catch (DAOException e) {
            response.setStatus(400);
        }

    }
}