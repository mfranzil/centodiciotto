package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Crypto;
import it.unitn.web.utils.SendEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;

@WebServlet("/request_password_reset")
public class RequestPasswordResetServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            try {
                String userID = request.getParameter("userID");

                PasswordReset pr = new PasswordReset();
                pr.setUserID(userID);
                pr.setToken(Crypto.getNextBase64Token());
                pr.setExpiringDate(new Timestamp(System.currentTimeMillis() + TimeUnit.DAYS.toMillis(1)));

                if (prDAO.getByPrimaryKey(userID) == null) {
                    prDAO.insert(pr);
                } else {
                    prDAO.update(pr);
                }

                String url = "http://localhost:8080" + contextPath + "password_reset?token=" + pr.getToken();
                String message =
                        "Somebody (hopefully you) requested a new password for Centodiciotto for "
                                + userID + ". No changes have been done to your account, yet.\n\n" +
                                "You can reset your password by clicking here:\n" + url + "\n\n" +
                                "This link is valid for 24 hours and can only be used once.\n" +
                                "If you didn't ask for this, you can safely ignore this email.\n" +
                                "Yours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - reset your password";

                SendEmail.send(userID, message, subject);

                response.setStatus(200);
            } catch (DAOException e) {
                response.setStatus(400);
                throw new ServletException("Impossible to retrieve the user.", e);
            }
        }
    }
}