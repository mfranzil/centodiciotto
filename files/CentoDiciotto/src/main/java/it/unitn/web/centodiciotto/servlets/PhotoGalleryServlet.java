package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Common;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
                List<Photo> photos = null;
                List<String> photoPathList = new ArrayList<>();
                try {
                    photos = photoDAO.getByEmail(user.getEmail());

                    for (Photo photo : photos) {
                        String photoPath = Common.getPhotoPosition(getServletContext(),
                                user.getEmail(),photo.getPhotoid());
                        photoPathList.add(photoPath);
                    }

                    request.setAttribute("photos", photoPathList);
                    request.getRequestDispatcher("/jsp/patient/photo_gallery.jsp").forward(request, response);
                } catch (DAOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
