package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

/**
 * The type Drug prescription dao bean.
 */
public class DrugPrescriptionDAOBean implements Serializable {

    private DrugPrescriptionDAO drugPrescriptionDAO = null;
    private String patientID = null;
    private String drugName = null;

    /**
     * Sets dao factory.
     *
     * @param useless the useless
     */
    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Sets patient id.
     *
     * @param patientID the patient id
     */
    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    /**
     * Gets by patient.
     *
     * @return the by patient
     * @throws BeanException the bean exception
     */
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

    /**
     * Gets patients not paid.
     *
     * @return the patients not paid
     * @throws BeanException the bean exception
     */
    public List<DrugPrescription> getPatientsNotPaid() throws BeanException {
        List<DrugPrescription> prescriptions;

        if (patientID == null) {
            throw new BeanException("Patient is null");
        }

        try {
            prescriptions = drugPrescriptionDAO.getByPatientNotPaid(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exam list in examDaoBean: ", e);
        }
        return prescriptions;
    }

}
