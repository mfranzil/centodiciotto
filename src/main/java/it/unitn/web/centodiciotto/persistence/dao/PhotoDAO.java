package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Photo;

import java.util.List;

public interface PhotoDAO extends DAO<Photo, Integer> {

    Photo getCurrentByPatient(String patientID) throws DAOException;

    List<Photo> getAllByPatient(String patientID) throws DAOException;
}
