package it.unitn.web.centodiciotto.services;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class EmailService {
    private static EmailService instance;

    private final transient Session session;
    private final transient InternetAddress sender;

    private EmailService() throws ServiceException {
        Properties data = new Properties();

        InputStream stream = EmailService.class.getClassLoader().getResourceAsStream("email.properties");

        if (stream == null) {
            throw new ServiceException("Error loading email.properties file");
        }

        try {
            data.load(stream);
            final String host = data.getProperty("smtp-hostname");
            final String port = data.getProperty("smtp-port");
            final String username = data.getProperty("smtp-username");
            final String password = data.getProperty("smtp-password");

            sender = new InternetAddress(username, username.trim());

            Properties systemProperties = System.getProperties();

            systemProperties.setProperty("mail.smtp.host", host);
            systemProperties.setProperty("mail.smtp.port", port);
            systemProperties.setProperty("mail.smtp.socketFactory.port", port);
            systemProperties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            systemProperties.setProperty("mail.smtp.auth", "true");
            systemProperties.setProperty("mail.smtp.starttls.enable", "true");
            systemProperties.setProperty("mail.debug", "true");

            this.session = Session.getInstance(systemProperties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
        } catch (IOException e) {
            throw new ServiceException("Error sending email", e);
        }
    }

    public static void configure() throws ServiceException {
        if (instance == null) {
            instance = new EmailService();
        } else {
            throw new ServiceException("EmailService already configured. You can call configure only one time");
        }
    }

    public static EmailService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("EmailService not yet configured. " +
                    "Call EmailService.configure() before use the class");
        }
        return instance;
    }

    public void sendEmail(final String recipient, final String message, final String subject) throws ServiceException {
        var throwableWrapper = new Object() {
            Throwable tr = null;
        };

        Runnable runnable = () -> {
            try {
                process(recipient, message, subject);
            } catch (MessagingException | UnsupportedEncodingException e) {
                throwableWrapper.tr = e;
            }
        };

        if (throwableWrapper.tr != null) {
            throw new ServiceException(throwableWrapper.tr);
        }

        Thread thread = new Thread(runnable);
        thread.start();
    }

    @SuppressWarnings("StringBufferReplaceableByString")
    private void process(String recipient, String message, String subject)
            throws MessagingException, UnsupportedEncodingException {
        StringBuilder plainTextMessageBuilder = new StringBuilder();
        plainTextMessageBuilder.append(message).append("\n");

        StringBuilder htmlMessageBuilder = new StringBuilder();
        message = message.replace(" ", "&nbsp;");
        message = message.replace("\n", "<br>");
        htmlMessageBuilder.append(message).append("<br>");

        Multipart multipart = new MimeMultipart("alternative");

        BodyPart messageBodyPart1 = new MimeBodyPart();
        messageBodyPart1.setText(plainTextMessageBuilder.toString());

        BodyPart messageBodyPart2 = new MimeBodyPart();
        messageBodyPart2.setContent(htmlMessageBuilder.toString(), "text/html; charset=utf-8");

        multipart.addBodyPart(messageBodyPart1);
        multipart.addBodyPart(messageBodyPart2);

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(recipient, "CentoDiciotto"));

        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient, recipient.trim()));
        msg.setRecipient(Message.RecipientType.CC, sender);

        msg.setSubject(subject);
        msg.setSentDate(new java.util.Date());
        msg.setContent(multipart);
        Transport.send(msg);
    }
}