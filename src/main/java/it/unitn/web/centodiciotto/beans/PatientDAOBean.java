package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import java.io.Serializable;
import java.util.List;

/**
 * The type Patient dao bean.
 */
public class PatientDAOBean implements Serializable {

    private VisitDAO visitDAO = null;
    private PatientDAO patientDAO = null;
    private GeneralPractitionerDAO practitionerDAO = null;
    private ExamDAO examDAO = null;

    private String patientID = null;

    /**
     * Sets dao factory.
     *
     * @param useless the useless
     */
    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Gets patient id.
     *
     * @return the patient id
     */
    public String getPatientID() {
        return patientID;
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
     * Gets patient.
     *
     * @return the patient
     * @throws BeanException the bean exception
     */
    public Patient getPatient() throws BeanException {
        if (patientID == null) {
            throw new BeanException("PatientID is null");
        }

        Patient res;
        try {
            res = patientDAO.getByPrimaryKey(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting patient in patientDaoBean: ", e);
        }
        return res;
    }

    /**
     * Gets photo path.
     *
     * @return the photo path
     * @throws BeanException the bean exception
     */
    public String getPhotoPath() throws BeanException {
        try {
            return PhotoService.getInstance().getLastPhoto(patientID);
        } catch (ServiceException e) {
            throw new BeanException("Error getting Photo path: ", e);
        }
    }

    /**
     * Gets last visit.
     *
     * @return the last visit
     * @throws BeanException the bean exception
     */
    public Visit getLastVisit() throws BeanException {
        try {
            return visitDAO.getLastByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in patientDaoBean: ", e);
        }
    }

    /**
     * Gets exams.
     *
     * @return the exams
     * @throws BeanException the bean exception
     */
    public List<Exam> getExams() throws BeanException {
        try {
            return examDAO.getByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    /**
     * Gets done visits.
     *
     * @return the done visits
     * @throws BeanException the bean exception
     */
    public List<Visit> getDoneVisits() throws BeanException {
        try {
            return visitDAO.getDoneByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    /**
     * Gets pending visit.
     *
     * @return the pending visit
     * @throws BeanException the bean exception
     */
    public Visit getPendingVisit() throws BeanException {
        try {
            return visitDAO.getPendingByPractitionerAndPatient(getPatient().getPractitionerID(), patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    /**
     * Gets practitioner.
     *
     * @return the practitioner
     * @throws BeanException the bean exception
     */
    public GeneralPractitioner getPractitioner() throws BeanException {
        try {
            return practitionerDAO.getByPrimaryKey(getPatient().getPractitionerID());
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }
}
