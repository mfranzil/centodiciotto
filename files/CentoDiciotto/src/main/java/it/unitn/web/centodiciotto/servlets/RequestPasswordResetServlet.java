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
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;

public class RequestPasswordResetServlet extends HttpServlet {

    private UserDAO userDAO;
    private PasswordResetDAO prDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            userDAO = daoFactory.getDAO(UserDAO.class);
            prDAO = daoFactory.getDAO(PasswordResetDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user;
        PasswordReset pr;

        try {
            String email = request.getParameter("email");
            user = userDAO.getByPrimaryKey(email);
            if (user != null) {
                Timestamp date = new Timestamp(System.currentTimeMillis() + TimeUnit.DAYS.toMillis(1)); // 24 ore di durata
                pr = new PasswordReset(email, PasswordReset.generateRandomBase64Token(), date);

                if (prDAO.getByPrimaryKey(email) == null) {
                    prDAO.insert(pr);
                } else {
                    prDAO.update(pr);
                }

                String contextPath = getServletContext().getContextPath();
                if (!contextPath.endsWith("/")) {
                    contextPath += "/";
                }

                String url = "http://localhost:8080" + contextPath + "password_reset?token=" + pr.getToken();
                String message =
                        "Somebody (hopefully you) requested a new password for Centodiciotto for "
                                + email + ". No changes have been done to your account, yet.\n\n" +
                                "You can reset your password by clicking here:\n" + url + "\n\n" +
                                "This link is valid for 24 hours and can only be used once.\n" +
                                "If you didn't ask for this, you can safely ignore this email.\n" +
                                "Yours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - reset your password";

                request.setAttribute("recipient", pr.getEmail());
                request.setAttribute("message", message);
                request.setAttribute("subject", subject);

                response.setStatus(200);
                request.getRequestDispatcher("/restricted/send_email").forward(request, response);
            }
        } catch (DAOException ex) {
            response.setStatus(400);
            throw new ServletException("Impossible to retrieve the user.", ex);
        }
    }


}
