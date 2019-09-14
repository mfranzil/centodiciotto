package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.PasswordResetDAO;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.PasswordReset;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class PasswordResetServlet extends HttpServlet {

    private UserDAO userDao;
    private PasswordResetDAO prDao;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user;
        PasswordReset pr;

        response.setStatus(200);
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Pragma", "no-cache");

        try {
            String email = request.getParameter("email");
            user = userDao.getByPrimaryKey(email);
            if (user != null) {
                Date date = new Date(System.currentTimeMillis() + TimeUnit.DAYS.toMillis(1)); // 24 ore di durata
                pr = new PasswordReset(email, PasswordReset.generateRandomBase64Token(), date);

                if (prDao.getByPrimaryKey(email) == null) {
                    prDao.insert(pr);
                } else {
                    prDao.update(pr);
                }
                sendEmail(pr);
            }
            response.getWriter().write("None");
        } catch (DAOException ex) {
            request.getServletContext().log("Impossible to retrieve the user.", ex);
        } catch (Exception ex) {
            Logger.getLogger(getClass().getName()).severe(ex.toString());
            // No matter what, bisogna terminare la richiesta e dire che è stata mandata.
        }
    }

    private void sendEmail(PasswordReset pr) {
        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        String email = pr.getEmail();
        String url = "http://localhost:8080" + contextPath + "finalize_password_reset?token=" + pr.getToken();
        String message =
                "Somebody (hopefully you) requested a new password for Centodiciotto for "
                        + email + ". No changes have been done to your account, yet.\n\n" +
                        "You can reset your password by clicking here:\n" + url + "\n\n" +
                        "This link is valid for 24 hours and can only be used once.\n" +
                        "If you didn't ask for this, you can safely ignore this email.\n" +
                        "Yours,\nThe CentoDiciotto team";

        StringBuilder plainTextMessageBuilder = new StringBuilder();
        plainTextMessageBuilder.append(message).append("\n");

        StringBuilder htmlMessageBuilder = new StringBuilder();
        message = message.replace(" ", "&nbsp;");
        message = message.replace("\n", "<br>");
        htmlMessageBuilder.append(message).append("<br>");

        final String host = getServletContext().getInitParameter("smtp-hostname");
        final String port = getServletContext().getInitParameter("smtp-port");
        final String username = getServletContext().getInitParameter("smtp-username");
        final String password = getServletContext().getInitParameter("smtp-password");
        Properties props = System.getProperties();

        props.setProperty("mail.smtp.host", host);
        props.setProperty("mail.smtp.port", port);
        props.setProperty("mail.smtp.socketFactory.port", port);
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.debug", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Multipart multipart = new MimeMultipart("alternative");

            BodyPart messageBodyPart1 = new MimeBodyPart();
            messageBodyPart1.setText(plainTextMessageBuilder.toString());

            BodyPart messageBodyPart2 = new MimeBodyPart();
            messageBodyPart2.setContent(htmlMessageBuilder.toString(), "text/html; charset=utf-8");

            multipart.addBodyPart(messageBodyPart1);
            multipart.addBodyPart(messageBodyPart2);

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(username, "CentoDiciotto"));
            msg.setRecipients(Message.RecipientType.TO,
                    new InternetAddress[]{new InternetAddress(email, email.trim())});
            msg.setSubject("CentoDiciotto - reset your password");
            msg.setSentDate(new java.util.Date());
            msg.setContent(multipart);

            Transport.send(msg);

            //     request.setAttribute("emailSent", true);
            //   if (!response.isCommitted()) {
               /* RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher(response.encodeRedirectURL("/restricted/users.html"));
                dispatcher.forward(request, response);*/
            //}
        } catch (MessagingException | UnsupportedEncodingException me) {
            Logger.getLogger(getClass().getName()).severe(me.toString());

            //   request.setAttribute("emailSent", false);
            // request.setAttribute("emailError", me.getMessage());
            //  if (!response.isCommitted()) {
                /*RequestDispatcher dispatcher = request.getServletContext()
                        .getRequestDispatcher(response.encodeRedirectURL("/restricted/users.html"));
                dispatcher.forward(request, response);*/
            //      }
        }
    }

}
