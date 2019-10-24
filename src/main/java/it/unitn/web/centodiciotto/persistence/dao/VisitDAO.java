package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.util.List;

public interface VisitDAO extends DAO<Visit, Integer> {

    List<Visit> getByPatient(String patientEmail) throws DAOException;

    List<Visit> getByPractitioner(String practitionerEmail) throws DAOException;

    Visit getLastVisitByPatient(Patient patient) throws DAOException;

    List<Visit> getPendingVisitsByPractitioner(String practictionerEmail) throws DAOException;

}
