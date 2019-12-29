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
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

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
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/password_reset")
public class PasswordResetServlet extends HttpServlet {

    private PasswordResetDAO prDAO;

    private CryptoService cryptoService;
    private EmailService emailService;

    private String contextPath;

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

        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            String requestType = request.getParameter("requestType");
            String userID = request.getParameter("userID");
            String json;

            if (requestType == null || userID == null) {
                response.setStatus(400);
                json = "{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            switch (requestType) {
                case "confirm": {
                    String newPassword = request.getParameter("newPassword");

                    if (newPassword == null || newPassword.length() < 8 || newPassword.length() > 64) {
                        response.setStatus(400);
                        json = "{\"error\": \"Password must be between 8 and 64 characters.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                    } else {
                        try {
                            cryptoService.changePassword(userID, newPassword);
                            prDAO.delete(prDAO.getByPrimaryKey(userID));

                            String message = "Dear CentoDiciotto user,\n\n" +
                                    "your account password has been changed. If this wasn't you," +
                                    " please request a password reset immediately or contact us." +
                                    "\n\nYours,\nThe CentoDiciotto team.\n";
                            String subject = "CentoDiciotto - Password change notification";

                            // Notifies the user of the password change
                            emailService.sendEmail(userID, message, subject);

                            writer.write("{}");
                        } catch (DAOException e) {
                            throw new ServletException("Error in DAO usage: ", e);
                        } catch (ServiceException e) {
                            throw new ServletException("Error in CryptoService while changing password: ", e);
                        }
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

                        String start = request.getScheme() + "://"
                                + request.getServerName() + ":" + request.getServerPort();
                        String url = start + contextPath + "password_reset?token=" + pr.getToken();
                        String message =
                                "Somebody (hopefully you) requested a new password for Centodiciotto for "
                                        + userID + ". No changes have been done to your account, yet.\n\n" +
                                        "You can reset your password by clicking here:\n" + url + "\n\n" +
                                        "This link is valid for 24 hours and can only be used once.\n" +
                                        "If you didn't ask for this, you can safely ignore this email.\n\n" +
                                        "Yours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - reset your password";

                        emailService.sendEmail(userID, message, subject);

                        writer.write("{}");
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage. ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in mail sending or CryptoService: ", e);
                    }
                }
            }
        }
    }
}