package it.unitn.web.centodiciotto.services;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Properties;
import java.util.logging.Logger;

/**
 * EmaiLService service class, used to send emails to other users.
 * <p>
 * The service implements the Singleton pattern.
 * <p>
 * The service uses the resource bundle "email.properties" to correctly instantiate itself.
 */
public class EmailService {
    private static EmailService instance;

    private final transient Session session;
    private final transient InternetAddress sender;

    private final transient String host;
    private final transient String port;
    private final transient String username;
    private final transient String password;

    private EmailService() throws ServiceException {
        Properties data = new Properties();
        InputStream stream = EmailService.class.getClassLoader().getResourceAsStream("email.properties");

        if (stream == null) {
            throw new ServiceException("Error loading email.properties file");
        }

        try {
            data.load(stream);
            host = data.getProperty("smtp-hostname");
            port = data.getProperty("smtp-port");
            username = data.getProperty("smtp-username");
            password = data.getProperty("smtp-password");

            sender = new InternetAddress(username, "CentoDiciotto");

            Properties systemProperties = System.getProperties();

            systemProperties.setProperty("mail.smtp.host", host);
            systemProperties.setProperty("mail.smtp.port", port);
            systemProperties.setProperty("mail.smtp.auth", "true");
            systemProperties.setProperty("mail.smtp.ssl.enable", "true");
            systemProperties.setProperty("mail.debug", "true");

            this.session = Session.getInstance(systemProperties);

            session.setDebug(false);
        } catch (IOException e) {
            throw new ServiceException("Error sending email", e);
        }
    }

    /**
     * Configuration method for the service.
     *
     * @throws ServiceException in case of error during processing
     */
    public static void configure() throws ServiceException {
        if (instance == null) {
            instance = new EmailService();
        } else {
            throw new ServiceException("EmailService already configured. You can call configure only one time");
        }
    }

    /**
     * Instance retriever for the service.
     *
     * @return the instance
     * @throws ServiceException in case of error during processing
     */
    public static EmailService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("EmailService not yet configured. " +
                    "Call EmailService.configure() before use the class");
        }
        return instance;
    }

    /**
     * Sends an email.
     *
     * @param recipient the recipient
     * @param message   the message
     * @param subject   the subject
     * @throws ServiceException in case of error during processing
     */
    public void sendEmail(final String recipient, final String message, final String subject) throws ServiceException {
        try {
            process(new Address[]{new InternetAddress(recipient, recipient.trim())}, message, subject);
        } catch (Exception e) {
            throw new ServiceException(e);
        }
    }

    /**
     * Sends an email to multiple recipients.
     *
     * @param recipients the recipients
     * @param message    the message
     * @param subject    the subject
     * @throws ServiceException in case of error during processing
     */
    public void sendMultipleEmails(final String[] recipients, final String message, final String subject) throws ServiceException {
        Address[] cc = new Address[recipients.length];

        for (int i = 0; i < recipients.length; i++) {
            String rec = recipients[i].replace('à', 'a')
                    .replace('ò', 'o')
                    .replace('ì', 'i')
                    .replace('è', 'e')
                    .replace('ù', 'u');
            try {
                cc[i] = new InternetAddress(rec, rec.trim());
            } catch (UnsupportedEncodingException e) {
                throw new ServiceException("Unknown encoding for address " + recipients[i], e);
            }
        }

        try {
            process(cc, message, subject);
        } catch (Exception e) {
            throw new ServiceException(e);
        }
    }

    @SuppressWarnings("StringBufferReplaceableByString")
    private void process(Address[] recipients, String message, String subject)
            throws MessagingException {
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
        msg.setFrom(sender);

        if (recipients.length == 1) {
            msg.setRecipient(Message.RecipientType.TO, recipients[0]);
        } else {
            msg.addRecipients(Message.RecipientType.BCC, recipients);
        }

        msg.setRecipient(Message.RecipientType.CC, sender);

        msg.setSubject(subject);
        msg.setSentDate(new java.util.Date());
        msg.setContent(multipart);

        Transport transport = session.getTransport("smtps");
        transport.connect(host, Integer.parseInt(port), username, password);
        msg.saveChanges();
        transport.sendMessage(msg, msg.getAllRecipients());

        Logger.getLogger("C18").info("Email sent to " + Arrays.toString(recipients)
                + " with subject " + subject);
    }
}
