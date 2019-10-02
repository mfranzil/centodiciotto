package it.unitn.web.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class SendEmail {
    private static Session session;

    public static void configure() throws RuntimeException {
        Properties data = new Properties();

        InputStream stream = SendEmail.class.getClassLoader().getResourceAsStream("email.properties");

        if (stream == null) {
            throw new RuntimeException("Error loading email.properties file");
        }

        try {
            data.load(stream);
            final String host = data.getProperty("smtp-hostname");
            final String port = data.getProperty("smtp-port");
            final String username = data.getProperty("smtp-username");
            final String password = data.getProperty("smtp-password");

            Properties systemProperties = System.getProperties();

            systemProperties.setProperty("mail.smtp.host", host);
            systemProperties.setProperty("mail.smtp.port", port);
            systemProperties.setProperty("mail.smtp.socketFactory.port", port);
            systemProperties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            systemProperties.setProperty("mail.smtp.auth", "true");
            systemProperties.setProperty("mail.smtp.starttls.enable", "true");
            systemProperties.setProperty("mail.debug", "true");

            SendEmail.session = Session.getInstance(systemProperties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
        } catch (IOException e) {
            throw new RuntimeException("Error sending email", e);
        }

    }

    @SuppressWarnings("StringBufferReplaceableByString")
    public static void send(String recipient, String message, String subject)
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
        msg.setRecipients(Message.RecipientType.TO,
                new InternetAddress[]{new InternetAddress(recipient, recipient.trim())});
        msg.setSubject(subject);
        msg.setSentDate(new java.util.Date());
        msg.setContent(multipart);
        Transport.send(msg);
    }
}
