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
 * PhotoService service class, used to generate file paths for profile pictures.
 * <p>
 * The service implements the Singleton pattern.
 * <p>
 * The service needs an initialized DAOFactory to instantiate a PhotoDAO, and a
 * servletContext for retrieving the system path.
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
     * Configuration method for the service.
     *
     * @param daoFactory     the DAOFactory
     * @param servletContext the servletContext
     * @throws ServiceException in case of error during processing
     */
    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws ServiceException {
        if (instance == null) {
            instance = new PhotoService(daoFactory, servletContext);
        } else {
            throw new ServiceException("PhotoService already configured. You can call configure only one time");
        }
    }

    /**
     * Instance retriever for the service.
     *
     * @return the instance
     * @throws ServiceException in case of error during processing
     */
    public static PhotoService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("PhotoService not yet configured. " +
                    "Call PhotoService.configure() before use the class");
        }
        return instance;
    }

    /**
     * Gets the last {@link Photo} of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}.
     *
     * @param patientID the patientID
     * @return a file path representing the relative position of the last {@link Photo}
     * @throws ServiceException in case of error during processing
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
     * Gets a {@link List} of {@link Photo}s of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}.
     *
     * @param patientID the patient id
     * @return a {@link List} of file paths representing the relative positions of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}.
     * @throws ServiceException in case of error during processing
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
     * Gets a {@link List} of {@link Photo}s of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}
     * coupled with its {@code id}.
     *
     * @param patientID the patient id
     * @return a {@link List} of {@link Pair}s, the first of which is a file path representing the relative position of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}, the second being the ID.
     * @throws ServiceException in case of error during processing
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

    /**
     * Retrieves the file path for a given photo using its {@code ID} and the {@code patientID}.
     * @param photo the photo entity
     * @return a file path representing the relative position of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}
     */
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
     * Gets the current avatar folder.
     *
     * @return the avatar folder
     */
    public String getAvatarFolder() {
        return File.separator + sc.getInitParameter("avatar-folder") + File.separator;
    }

    /**
     * Gets a {@link it.unitn.web.centodiciotto.persistence.entities.Patient} avatar folder.
     *
     * @param patientID the patientID
     * @return the {@link it.unitn.web.centodiciotto.persistence.entities.Patient} avatar folder
     */
    public String getPatientAvatarFolder(String patientID) {
        return File.separator + sc.getInitParameter("avatar-folder") + File.separator + patientID;
    }


}