package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.persistence.dao.DAO;

import java.util.List;

public interface PhotoDAO extends DAO<Photo, Integer> {

    void insert(Photo photo);

    void update(Photo photo);

    void delete(Photo photo);

    public Photo getCurrentPhoto(Patient patient);

    public List<Photo> getAllPhotos(Patient patient);


}
