package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.logging.Logger;

/**
 * PhotoGalleryRequest for handling requests to /restricted/patient/photo_gallery.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests take a photoID as a parameter and set the relative {@link Patient} photo as the current one.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/patient/photo_gallery")
public class PhotoGalleryServlet extends HttpServlet {

    private PhotoDAO photoDAO;

    private String contextPath;

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

        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/photo_gallery-p.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");


        if (user instanceof Patient) {
            Integer photoID;

            try {
                photoID = Integer.valueOf(request.getParameter("photoID"));
            } catch (NumberFormatException | NullPointerException e) {
                response.setStatus(400);
                String json = "{\"error\": \"Malformed input. Please try the photo again.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            try {
                Photo chosenPhoto = photoDAO.getByPrimaryKey(photoID);
                chosenPhoto.setUploadDate(new Timestamp(System.currentTimeMillis()));
                photoDAO.update(chosenPhoto);

                if (!response.isCommitted()) {
                    response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/user"));
                }
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }
}
