package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface VisitDAO extends DAO<Visit, Integer> {

    void insert(Visit visit) throws DAOException;

    void update(Visit visit) throws DAOException;

    void delete(Visit visit) throws DAOException;

    List<Visit> getByPatient(String PatientEmail) throws DAOException;

    List<Visit> getByPractitioner(String PractitionerEmail) throws DAOException;
}
