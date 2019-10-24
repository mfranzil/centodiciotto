package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.PendingVisit;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.utils.Pair;

import java.util.List;

public interface PendingVisitDAO extends DAO<PendingVisit, Pair<String, String>> {

    List<PendingVisit> getByPractitioner(String PractitionerEmail) throws DAOException;

}
