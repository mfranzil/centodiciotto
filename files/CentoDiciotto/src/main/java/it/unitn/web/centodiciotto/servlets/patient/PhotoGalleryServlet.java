package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Common;
import it.unitn.web.utils.Pair;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PhotoGalleryServlet extends HttpServlet {

    private PhotoDAO photoDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            photoDAO = daoFactory.getDAO(PhotoDAO.class);

        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            if (user instanceof Patient) {
                List<Photo> photos;
                List<Pair<String, Integer>> photoPathList = new ArrayList<>();
                try {
                    photos = photoDAO.getByEmail(user.getEmail());

                    for (Photo photo : photos) {
                        String photoPath = Common.getPhotoPosition(getServletContext(),
                                user.getEmail(), photo.getPhotoId());
                        photoPathList.add(Pair.makePair(photoPath, photo.getPhotoId()));
                    }

                    request.setAttribute("photos", photoPathList);
                    request.getRequestDispatcher("/jsp/patient/photo_gallery-p.jsp").forward(request, response);
                } catch (DAOException ex) {
                    throw new ServletException("Cannot load page for photo gallery", ex);
                }
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        Integer photoId = Integer.valueOf(request.getParameter("photoid"));

        try {
            Photo chosenPhoto = photoDAO.getByPrimaryKey(photoId);
            chosenPhoto.setUploadDate(new Timestamp(System.currentTimeMillis()));
            photoDAO.update(chosenPhoto);

            String photoPath = Common.getPhotoPosition(getServletContext(), user.getEmail(), chosenPhoto.getPhotoId());
            request.getSession().setAttribute("photo_path", photoPath);
        } catch (DAOException ex) {
            throw new ServletException("Cannot update profile photo", ex);
        }


        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (!response.isCommitted()) {
            response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/user"));
        }
    }
}
