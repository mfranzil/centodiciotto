package it.unitn.web.centodiciotto.servlets.shared;


import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;

@WebServlet("/restricted/user")
public class UserServlet extends HttpServlet {

    private PhotoDAO photoDAO;

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
        String requestType = request.getParameter("requestType");

        switch (requestType) {
            case "passwordChange": {
                if (user != null) {
                    try {
                        String oldPassword = request.getParameter("oldPassword");
                        String newPassword = request.getParameter("newPassword");
                        CryptoService cryptoService = CryptoService.getInstance();

                        if (cryptoService.isCurrentPassword(user.getID(), oldPassword)) {
                            cryptoService.changePassword(user.getID(), newPassword);
                            response.setStatus(200);
                        } else {
                            response.setStatus(400);
                        }
                    } catch (ServiceException e) {
                        response.setStatus(400);
                        throw new ServletException("Failed to change password: ", e);
                    }
                }
                break;
            }
            case "photoUpload": {
                if (user instanceof Patient) {
                    OutputStream out = null;
                    InputStream filecontent = null;
                    String json = "{\"output\": false}";

                    Part filePart = request.getPart("avatarSelect");
                    String extension = request.getParameter("extension");

                    Photo photo = new Photo();
                    photo.setPatientID(user.getID());
                    photo.setUploadDate(new Timestamp(System.currentTimeMillis()));

                    try {
                        PhotoService photoService = PhotoService.getInstance();

                        photoDAO.insert(photo);

                        String fileName = Integer.toString(photo.getID());
                        String path = getServletContext().getRealPath("/")
                                + photoService.getPatientAvatarFolder(user.getID());

                        Files.createDirectories(Paths.get(path));

                        out = new FileOutputStream(new File(path + File.separator + fileName + "." + extension));
                        filecontent = filePart.getInputStream();

                        int read = 0;
                        final byte[] bytes = new byte[1024];

                        while ((read = filecontent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }

                        response.setStatus(200);
                        json = "{\"output\": true}";
                    } catch (DAOException e) {
                        response.setStatus(400);
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrival: ", e);
                    } finally {
                        if (out != null) {
                            out.close();
                        }
                        if (filecontent != null) {
                            filecontent.close();
                        }
                        response.getWriter().write(json);
                    }
                }
                break;
            }
        }
    }
}