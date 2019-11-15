package it.unitn.web.centodiciotto.services;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import javax.servlet.ServletContext;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * The type Photo service.
 */
public class PhotoService {
    private static PhotoService instance;

    private transient ServletContext sc;
    private transient PhotoDAO photoDAO;

    private PhotoService(DAOFactory daoFactory, ServletContext servletContext) throws ServiceException {
        sc = servletContext;

        if (daoFactory == null) {
            throw new ServiceException("DAOFactory is null.");
        }
        try {
            photoDAO = daoFactory.getDAO(PhotoDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServiceException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Configure.
     *
     * @param daoFactory     the dao factory
     * @param servletContext the servlet context
     * @throws ServiceException the service exception
     */
    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws ServiceException {
        if (instance == null) {
            instance = new PhotoService(daoFactory, servletContext);
        } else {
            throw new ServiceException("PhotoService already configured. You can call configure only one time");
        }
    }

    /**
     * Gets instance.
     *
     * @return the instance
     * @throws ServiceException the service exception
     */
    public static PhotoService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("PhotoService not yet configured. " +
                    "Call PhotoService.configure() before use the class");
        }
        return instance;
    }

    /**
     * Gets last photo.
     *
     * @param patientID the patient id
     * @return the last photo
     * @throws ServiceException the service exception
     */
    public String getLastPhoto(String patientID) throws ServiceException {
        Photo photo;

        if (patientID == null) {
            return null;
        }

        try {
            photo = photoDAO.getCurrentByPatient(patientID);
        } catch (DAOException e) {
            throw new ServiceException("Error in DAO usage: ", e);
        }

        return getPhotoPath(photo);
    }

    /**
     * Gets all photos.
     *
     * @param patientID the patient id
     * @return the all photos
     * @throws ServiceException the service exception
     */
    public List<String> getAllPhotos(String patientID) throws ServiceException {
        int id;
        List<Photo> photos = null;
        List<String> photo_paths = new ArrayList<>();

        if (patientID == null) {
            return null;
        }

        try {
            photos = photoDAO.getAllByPatient(patientID);
        } catch (DAOException e) {
            throw new ServiceException("Error in DAO usage: ", e);
        }

        for (Photo photo : photos) {
            photo_paths.add(getPhotoPath(photo));
        }

        return photo_paths;
    }


    /**
     * Gets all photos with id.
     *
     * @param patientID the patient id
     * @return the all photos with id
     * @throws ServiceException the service exception
     */
    public List<Pair<String, Integer>> getAllPhotosWithID(String patientID) throws ServiceException {
        List<Photo> photos;
        List<Pair<String, Integer>> photo_paths = new ArrayList<>();

        if (patientID == null) {
            return null;
        }

        try {
            photos = photoDAO.getAllByPatient(patientID);
        } catch (DAOException e) {
            throw new ServiceException("Error in DAO usage: ", e);
        }

        for (Photo photo : photos) {
            photo_paths.add(Pair.makePair(getPhotoPath(photo), photo.getID()));
        }

        return photo_paths;
    }

    private String getPhotoPath(Photo photo) {
        int id;
        String avatarFolder = getAvatarFolder();

        if (photo == null) {
            return avatarFolder + "default.png";
        } else {
            id = photo.getID();
        }

        String context = sc.getRealPath("/");
        String patientID = photo.getPatientID();
        String photoPath = avatarFolder + patientID + File.separator + id;

        if (new File(context + photoPath + ".jpg").exists()) {
            photoPath = avatarFolder + patientID + File.separator + id + ".jpg";
        } else if (new File(context + photoPath + ".png").exists()) {
            photoPath = avatarFolder + patientID + File.separator + id + ".png";
        } else {
            return avatarFolder + "default.png";
        }

        return photoPath.replace('\\', '/');
    }

    /**
     * Gets avatar folder.
     *
     * @return the avatar folder
     */
    public String getAvatarFolder() {
        return File.separator + sc.getInitParameter("avatar-folder") + File.separator;
    }

    /**
     * Gets patient avatar folder.
     *
     * @param patientID the patient id
     * @return the patient avatar folder
     */
    public String getPatientAvatarFolder(String patientID) {
        return File.separator + sc.getInitParameter("avatar-folder") + File.separator + patientID;
    }


}