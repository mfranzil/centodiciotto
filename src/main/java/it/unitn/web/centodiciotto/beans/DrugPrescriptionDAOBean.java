package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.utils.exceptions.BeanException;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public class DrugPrescriptionDAOBean implements Serializable {

    private DrugPrescriptionDAO drugPrescriptionDAO = null;
    private String patientID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public List<DrugPrescription> getByPatient() throws BeanException {
        List<DrugPrescription> drugPrescriptions = Collections.emptyList();

        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            drugPrescriptions = drugPrescriptionDAO.getValidByPatient(patientID);

        } catch (DAOException e) {
            throw new BeanException("Error getting drugPre list in practitionerDaoBean: ", e);
        }
        return drugPrescriptions;
    }

}
