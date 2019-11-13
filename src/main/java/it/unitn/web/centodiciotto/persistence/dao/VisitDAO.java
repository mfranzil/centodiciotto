package it.unitn.web.centodiciotto.persistence.dao;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

import java.sql.Timestamp;
import java.util.List;

public interface VisitDAO extends DAO<Visit, Integer> {

    List<Visit> getPendingByPractitioner(String practictionerID) throws DAOException;

    List<Visit> getBookedByPractitioner(String practitionerID) throws DAOException;

    List<Visit> getDoneByPractitioner(String practitionerID) throws DAOException;

    List<Visit> getDoneByPatient(String patientID) throws DAOException;

    Visit getLastByPatient(String patient) throws DAOException;

    Visit getPendingByPractitionerAndPatient(String practictionerID, String patientID) throws DAOException;

    List<Visit> getByDate(Timestamp ts) throws DAOException;

}
