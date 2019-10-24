package it.unitn.web.utils;

import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletContext;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class PhotoService {
    private static ServletContext sc;
    private static PhotoDAO photoDAO;

    public static void configure(DAOFactory daoFactory, ServletContext servletContext) throws RuntimeException {
        sc = servletContext;

        if (daoFactory == null) {
            throw new RuntimeException("Impossible to get dao factory for user storage system");
        }
        try {
            photoDAO = daoFactory.getDAO(PhotoDAO.class);
        } catch (DAOFactoryException ex) {
            throw new RuntimeException("Impossible to get dao factory for user storage system", ex);
        }
    }

    public static String getLastPhoto(Patient patient) throws RuntimeException {
        int id;
        Photo photo = null;

        if (patient == null) {
            return null;
        }

        try {
            photo = photoDAO.getCurrentPhoto(patient);
        } catch (DAOException ex) {
            throw new RuntimeException("Error contacting the DAO for photo retrieval", ex);
        }

        return getPhotoPath(photo);
    }


    public static List<String> getAllPhotos(Patient patient) throws RuntimeException {
        int id;
        List<Photo> photos = null;
        List<String> photo_paths = new ArrayList<>();

        if (patient == null) {
            return null;
        }

        try {
            photos = photoDAO.getAllPhotos(patient);
        } catch (DAOException ex) {
            throw new RuntimeException("Error contacting the DAO for photo retrieval", ex);
        }

        for (Photo photo : photos) {
            photo_paths.add(getPhotoPath(photo));
        }

        return photo_paths;
    }


    public static List<Pair<String, Integer>> getAllPhotosWithId(Patient patient) throws RuntimeException {
        int id;
        List<Photo> photos = null;
        List<Pair<String, Integer>> photo_paths = new ArrayList<>();

        if (patient == null) {
            return null;
        }

        try {
            photos = photoDAO.getAllPhotos(patient);
        } catch (DAOException ex) {
            throw new RuntimeException("Error contacting the DAO for photo retrieval", ex);
        }

        for (Photo photo : photos) {
            photo_paths.add(Pair.makePair(getPhotoPath(photo), photo.getID()));
        }

        return photo_paths;
    }

    public static String getPhotoPath(Photo photo) {
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

        return photoPath;
    }

    private static String getAvatarFolder() {
        return File.separator + sc.getInitParameter("avatar-folder") + File.separator;
    }


}