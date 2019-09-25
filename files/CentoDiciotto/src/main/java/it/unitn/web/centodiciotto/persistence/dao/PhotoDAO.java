package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;


import java.util.List;

public interface PhotoDAO extends DAO<Photo, Integer> {

    void insert(Photo photo);

    void update(Photo photo);

    void delete(Photo photo);

    List<Photo> getByEmail(String email) throws DAOException;

    Photo getLastPhotoByEmail(String email) throws DAOException;

}
