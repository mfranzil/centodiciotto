package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

public interface SpecializedDoctorDAO extends DAO<SpecializedDoctor, String> {

    void insert(SpecializedDoctor specializedDoctor) throws DAOException;

    void update(SpecializedDoctor specializedDoctor) throws DAOException;

    void delete(SpecializedDoctor specializedDoctor) throws DAOException;

}
