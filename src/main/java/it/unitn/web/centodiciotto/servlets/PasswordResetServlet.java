package it.unitn.web.centodiciotto.servlets;


import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;


/**
 * PasswordResetServlet for handling requests to /restricted/health_service/recalls.
 * <p>
 * GET requests pass through as long as the user isn't logged in. They are then filtered
 * by checking the {@code token} received and verifies if a valid row exists in the {@link PasswordReset} table.
 * If true, sets the userID attribute for the request and forwards to the JSP.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> confirm: receives a newPassword parameter and sets it as the new password for the user.
 *     <li> request: creates a new {@link PasswordReset} object for the user.
 * </ul>
 */
@WebServlet("/password_reset")
public class PasswordResetServlet extends HttpServlet {

    private PasswordResetDAO prDAO;

    private CryptoService cryptoService;
    private EmailService emailService;

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

        try {
            cryptoService = CryptoService.getInstance();
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
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
        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            String requestType = request.getParameter("requestType");
            String userID = request.getParameter("userID");

            switch (requestType) {
                case "confirm": {
                    String newPassword = request.getParameter("newPassword");

                    if (newPassword.length() < 8 || newPassword.length() > 64) {
                        throw new ServletException("Password must be between 8 and 64 characters.");
                    }

                    try {
                        cryptoService.changePassword(userID, newPassword);
                        prDAO.delete(prDAO.getByPrimaryKey(userID));

                        response.setStatus(200);
                    } catch (DAOException e) {
                        response.setStatus(400);
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        response.setStatus(400);
                        throw new ServletException("Error in CryptoService while changing password: ", e);
                    }
                    break;
                }
                case "request": {
                    try {

                        PasswordReset pr = new PasswordReset();
                        pr.setUserID(userID);
                        pr.setToken(cryptoService.getNextBase64Token());
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
                                        "If you didn't ask for this, you can safely ignore this email.\n\n" +
                                        "Yours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - reset your password";

                        emailService.sendEmail(userID, message, subject);

                        response.setStatus(200);
                    } catch (DAOException e) {
                        response.setStatus(400);
                        throw new ServletException("Error in DAO usage. ", e);
                    } catch (ServiceException e) {
                        response.setStatus(400);
                        throw new ServletException("Error in mail sending or CryptoService: ", e);
                    }
                }
            }
        }
    }
}