package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.PendingVisit;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface PendingVisitDAO extends DAO<PendingVisit, Integer> {

    void insert(PendingVisit pendingVisit) throws DAOException;

    void update(PendingVisit pendingVisit) throws DAOException;

    void delete(PendingVisit pendingVisit) throws DAOException;

    List<PendingVisit> getByPractitioner(String PractitionerEmail) throws DAOException;

}
