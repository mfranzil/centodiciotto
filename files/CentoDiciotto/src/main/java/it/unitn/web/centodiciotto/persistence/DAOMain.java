package it.unitn.web.centodiciotto.persistence;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;

import java.util.HashSet;
import java.util.List;


public class DAOMain {
    public static void main(String[] args){
        try {
            JDBCDAOFactory.configure();
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            PhotoDAO photoDAO = daoFactory.getDAO(PhotoDAO.class);
            PatientDAO patientDAO = daoFactory.getDAO(PatientDAO.class);

            String email =  "dionisia.monaldo@gmail.com";
            Patient patient = patientDAO.getByPrimaryKey(email);
            System.out.println("email: " + patient.getEmail());

            Photo p = photoDAO.getCurrentPhoto(patient);
            System.out.println("Current photo ID: " + p.getPhotoId());

            List<Photo> photos = photoDAO.getAllPhotos(patient);

            System.out.println("All photos");
            for (Photo photo : photos){
                System.out.println("- id: " + photo.getPhotoId());
            }


        } catch (DAOFactoryException | DAOException e) {
            e.printStackTrace();
        }
    }


}
