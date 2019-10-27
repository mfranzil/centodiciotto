package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface PhotoDAO extends DAO<Photo, Integer> {

    Photo getCurrentPhoto(String patientID) throws DAOException;

    List<Photo> getAllPhotos(String patientID) throws DAOException;
}
