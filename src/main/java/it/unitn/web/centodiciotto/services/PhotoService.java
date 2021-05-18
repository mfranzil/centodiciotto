package it.unitn.web.centodiciotto.services;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.entities.Pair;
import jakarta.servlet.ServletContext;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * PhotoService service class, used to generate file paths for profile pictures.
 * <p>
 * The service implements the Singleton pattern.
 * <p>
 * The service needs an initialized DAOFactory to instantiate a PhotoDAO, and a
 * servletContext for retrieving the system path.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
public class PhotoService {
    private static PhotoService instance;

    private final transient ServletContext sc;
    private final transient PhotoDAO photoDAO;

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
     * Gets a {@link List} of {@link Photo}s of a {@link Patient}, represented as a list of {@link Pair}s
     * with the photo path and the corresponding date.
     *
     * @param patientID the patient id
     * @return a {@link List} of {@link Pair}s containing file paths representing the relative positions
     * of a {@link Patient} with the corresponding date.
     * @throws ServiceException in case of error during processing
     */
    public List<Pair<String, String>> getAllPhotos(String patientID) throws ServiceException {
        List<Photo> photos;
        List<Pair<String, String>> photoPaths = new ArrayList<>();

        if (patientID == null) {
            return null;
        }

        try {
            photos = photoDAO.getAllByPatient(patientID);
        } catch (DAOException e) {
            throw new ServiceException("Error in DAO usage: ", e);
        }

        for (Photo photo : photos) {
            photoPaths.add(Pair.makePair(getPhotoPath(photo),
                    CustomDTFormatter.formatDateTime(photo.getUploadDate())
            ));
        }

        return photoPaths;
    }

    /**
     * Retrieves the file path for a given photo using its {@code ID}, the {@code patientID} and the file extension.
     *
     * @param photo the photo entity
     * @return a file path representing the relative position of a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}
     */
    private String getPhotoPath(Photo photo) {
        String avatarFolder = getAvatarFolder();

        if (photo == null) {
            return avatarFolder + "/default.png";
        }

        String patientAvatarFolder = getPatientAvatarFolder(photo.getPatientID());

        String photoPath = patientAvatarFolder + "/" + photo.getID();

        if (photoExists(photoPath + "." + photo.getExtension())) {
            return photoPath + "." + photo.getExtension();
        } else {
            return avatarFolder + "/default.png";
        }
    }

    /**
     * Gets the current avatar folder as a relative path.
     *
     * @return the avatar folder as a relative path
     */
    public String getAvatarFolder() {
        return sc.getAttribute("imageServer") + "/avatars";
    }

    /**
     * Gets a {@link it.unitn.web.centodiciotto.persistence.entities.Patient}'s avatar folder as a relative path.
     *
     * @param patientID the patientID
     * @return the {@link it.unitn.web.centodiciotto.persistence.entities.Patient}'s avatar folder as a relative path
     */
    public String getPatientAvatarFolder(String patientID) {
        return sc.getAttribute("imageServer") + "/avatars/" + patientID;
    }

    public boolean photoExists(String URL) {
        try {
            CloseableHttpClient client = HttpClientBuilder.create().build();

            HttpGet request = new HttpGet(URL);
            Logger.getLogger("C18").info("HTTP GET " + URL);

            HttpResponse response = client.execute(request);
            int statusCode = response.getStatusLine().getStatusCode();

            return HttpURLConnection.HTTP_OK == statusCode;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}