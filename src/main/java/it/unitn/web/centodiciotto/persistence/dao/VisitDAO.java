package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;

import java.sql.Timestamp;
import java.util.List;

public interface VisitDAO extends DAO<Visit, Integer> {

    List<Visit> getByPatient(String patientID) throws DAOException;

    List<Visit> getDoneByPatient(String patientID) throws DAOException;

    List<Visit> getByPractitioner(String practitionerID) throws DAOException;

    Visit getLastVisitByPatientID(String patient) throws DAOException;

    Visit getPendingVisitByPractitionerAndPatient(String practictionerID, String patientID) throws DAOException;

    List<Visit> getPendingVisitsByPractitioner(String practictionerID) throws DAOException;

    List<Visit> getByDate(Timestamp ts) throws DAOException;

}
