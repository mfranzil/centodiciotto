package it.unitn.web.centodiciotto.servlets;

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
import java.util.Properties;
import java.util.logging.Logger;

public class SendEmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        sendEmail(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        sendEmail(request, response);
    }

    private void sendEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String recipient = (String) request.getAttribute("recipient");
        String message = (String) request.getAttribute("message");
        String subject = (String) request.getAttribute("subject");

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
                    new InternetAddress[]{new InternetAddress(recipient, recipient.trim())});
            msg.setSubject(subject);
            msg.setSentDate(new java.util.Date());
            msg.setContent(multipart);
            Transport.send(msg);
        } catch (MessagingException | UnsupportedEncodingException me) {
            Logger.getLogger(getClass().getName()).severe(me.toString());
        }
    }
}
