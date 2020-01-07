package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.logging.Logger;

/**
 * UserServlet for handling requests to /restricted/user.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> passwordChange: changes a user's password after validating it.
 *     <li> photoUpload: uploads a new profile photo for the user.
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/user")
@MultipartConfig
public class UserServlet extends HttpServlet {

    private PhotoDAO photoDAO;

    private CryptoService cryptoService;
    private PhotoService photoService;
    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            photoDAO = daoFactory.getDAO(PhotoDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            cryptoService = CryptoService.getInstance();
            photoService = PhotoService.getInstance();
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            request.getRequestDispatcher("/jsp/shared/user.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType;

        if (request.getContentType().split(";")[0].equals("multipart/form-data")) {
            requestType = "photoUpload";
        } else {
            requestType = request.getParameter("requestType");
        }
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (requestType == null) {
            response.setStatus(400);
            String json = "{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
            writer.write(json);
            Logger.getLogger("C18").severe(json);
            return;
        }

        switch (requestType) {
            case "passwordChange": {
                if (user != null) {
                    try {
                        String oldPassword = request.getParameter("oldPassword");
                        String newPassword = request.getParameter("newPassword");

                        if (oldPassword == null || newPassword == null ||
                                newPassword.length() < 8 || newPassword.length() > 64) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. " +
                                    "Please insert your old password and a new one wtih 8 to 64 characters.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                        } else {
                            if (cryptoService.isCurrentPassword(user.getID(), oldPassword)) {
                                cryptoService.changePassword(user.getID(), newPassword);

                                String recipient = user.getID();
                                String message = "Dear " + user.toString() + ",\n\n" +
                                        "your account password has been changed. If this wasn't you," +
                                        " please request a password reset immediately or contact us." +
                                        "\n\nYours,\nThe CentoDiciotto team.\n";
                                String subject = "CentoDiciotto - Password change notification";

                                // Notifies the user of the password change
                                emailService.sendEmail(recipient, message, subject);

                                writer.write("{}");
                            } else {
                                response.setStatus(400);
                                String json = "{\"error\": \"Invalid existing password. " +
                                        "Please type your current password.\"}";
                                writer.write(json);
                                Logger.getLogger("C18").severe(json);
                            }
                        }
                    } catch (ServiceException e) {
                        throw new ServletException("Failed to change password / send email: ", e);
                    }
                }
                break;
            }
            case "photoUpload": {
                if (user instanceof Patient) {
                    OutputStream out = null;
                    InputStream filecontent = null;

                    Part filePart = request.getPart("avatarSelect");
                    String extension = request.getParameter("extension");

                    if (filePart == null || extension == null || filePart.getSize() == 0) {
                        response.setStatus(400);
                        String json = "{\"error\": \"File upload failed. Please try again.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    Photo photo = new Photo();
                    photo.setPatientID(user.getID());
                    photo.setUploadDate(new Timestamp(System.currentTimeMillis()));
                    photo.setExtension(extension);

                    try {
                        photoDAO.insert(photo);

                        String fileName = photo.getID() + "." + extension;
                        String path = getServletContext().getRealPath("/")
                                + photoService.getPatientAvatarFolder(user.getID());

                        // Create the necessary folder path if the user hasn't uploaded one yet
                        Files.createDirectories(Paths.get(path));

                        out = new FileOutputStream(new File(path + File.separator + fileName));
                        filecontent = filePart.getInputStream();

                        int read;
                        final byte[] bytes = new byte[2048];

                        while ((read = filecontent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }

                        writer.write("{\"output\": true}");
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } finally {
                        if (out != null) {
                            out.close();
                        }
                        if (filecontent != null) {
                            filecontent.close();
                        }
                    }
                }
                break;
            }
        }
    }
}
