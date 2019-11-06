package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Pair;
import it.unitn.web.utils.exceptions.ServiceException;
import it.unitn.web.utils.services.PhotoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/restricted/patient/photo_gallery")
public class PhotoGalleryServlet extends HttpServlet {

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            try {
                PhotoService photoService = PhotoService.getInstance();
                List<Pair<String, Integer>> photoPathList = photoService.getAllPhotosWithID(user.getID());

                request.setAttribute("photos", photoPathList);
                request.getRequestDispatcher("/jsp/patient/photo_gallery-p.jsp").forward(request, response);
            } catch (ServiceException e) {
                throw new ServletException("Error in Service usage: ", e);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        Integer photoID = Integer.valueOf(request.getParameter("photoID"));

        if (user instanceof Patient) {
            try {
                Photo chosenPhoto = photoDAO.getByPrimaryKey(photoID);
                chosenPhoto.setUploadDate(new Timestamp(System.currentTimeMillis()));
                photoDAO.update(chosenPhoto);

                String contextPath = getServletContext().getContextPath();
                if (!contextPath.endsWith("/")) {
                    contextPath += "/";
                }

                if (!response.isCommitted()) {
                    response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/user"));
                }
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }
}
