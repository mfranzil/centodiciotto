package it.unitn.web.centodiciotto.servlets;


import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.ServiceException;

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
            throw new ServletException("DAOFactory is null.");
        }
        try {
            prDAO = daoFactory.getDAO(PasswordResetDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            try {
                String token = request.getParameter("token");
                PasswordReset pr = prDAO.getByToken(token);

                if (pr != null && pr.getExpiringDate().after(new Timestamp(System.currentTimeMillis()))) {
                    request.setAttribute("userID", pr.getUserID());
                    request.getRequestDispatcher("/jsp/password_reset.jsp").forward(request, response);
                } else {
                    response.sendRedirect(response.encodeRedirectURL(contextPath));
                }
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            String contextPath = getServletContext().getContextPath();
            if (!contextPath.endsWith("/")) {
                contextPath += "/";
            }

            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            String userID = request.getParameter("userID");
            String newPassword = request.getParameter("newPassword");

            try {
                CryptoService.getInstance().changePassword(userID, newPassword);
                prDAO.delete(prDAO.getByPrimaryKey(userID));

                response.setStatus(200);
            } catch (DAOException e) {
                response.setStatus(400);
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ServiceException e) {
                response.setStatus(400);
                throw new ServletException("Error in CryptoService while changing password: ", e);
            }
        }
    }
}