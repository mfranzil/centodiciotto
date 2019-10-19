package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Crypto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/password_reset")
public class PasswordResetServlet extends HttpServlet {

    private PasswordResetDAO prDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            prDAO = daoFactory.getDAO(PasswordResetDAO.class);
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
        PasswordReset pr;

        try {
            pr = prDAO.getByToken(token);
            if (pr != null && pr.getExpiringDate().after(new Timestamp(System.currentTimeMillis()))) {
                request.setAttribute("email", pr.getUserID());
                request.getRequestDispatcher("/jsp/password_reset.jsp").forward(request, response);
            } else {
                response.sendRedirect(response.encodeRedirectURL(contextPath));
            }
        } catch (DAOException e) {
            throw new ServletException("Error in PR retrieval. ", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("new-password");

        try {
            Crypto.changePassword(email, newPassword);
            prDAO.delete(prDAO.getByPrimaryKey(email));
            response.setStatus(200);
        } catch (DAOException ex) {
            request.getServletContext().log("Impossible to add a new password", ex);
            response.setStatus(400);
        }

    }
}