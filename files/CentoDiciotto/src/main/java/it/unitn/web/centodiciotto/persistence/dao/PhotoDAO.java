package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface PhotoDAO extends DAO<Photo, Integer> {

    void insert(Photo photo) throws DAOException;

    void update(Photo photo) throws DAOException;

    void delete(Photo photo) throws DAOException;

    Photo getCurrentPhoto(Patient patient) throws DAOException;

    List<Photo> getAllPhotos(Patient patient) throws DAOException;


}
