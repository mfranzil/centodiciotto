package it.unitn.web.centodiciotto.beans.entities;

import it.unitn.web.centodiciotto.beans.BeanException;
import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import java.io.Serializable;
import java.util.List;

/**
 * JavaBean representing a {@link PatientDAO} bound to a {@link Patient}.
 */
public class PatientDAOBean implements Serializable {
    private VisitDAO visitDAO = null;
    private PatientDAO patientDAO = null;
    private GeneralPractitionerDAO practitionerDAO = null;
    private DrugPrescriptionDAO drugPrescriptionDAO = null;
    private ExamDAO examDAO = null;

    private String patientID = null;

    /**
     * Initializes the bean.
     *
     * Retrieves a DAOFactory implementation and then retrieves the DAOS.
     *
     * @param useless a parameter required by the JavaBeans implementation that can be left to null.
     */
    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Sets the patientID.
     *
     * @param patientID the patientID
     */
    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    /**
     * Gets the {@link Patient} entity associated to this ID.
     *
     * @return the {@link Patient} entity associated to this ID
     * @throws BeanException thrown for any generic exception
     */
    public Patient getPatient() throws BeanException {
        Patient res;

        if (patientID == null) {
            throw new BeanException("PatientID is null");
        }

        try {
            res = patientDAO.getByPrimaryKey(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting patient in patientDaoBean: ", e);
        }
        return res;
    }

    /**
     * Gets the {@link Photo} path associated with this {@link Patient}.
     *
     * @return a {@link String} representing the relative {@link Photo} path of the current {@link Patient}
     * @throws BeanException thrown for any generic exception bean exception
     */
    public String getPhotoPath() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return PhotoService.getInstance().getLastPhoto(patientID);
        } catch (ServiceException e) {
            throw new BeanException("Error getting PhotoPath in patientDaoBean: ", e);
        }
    }

    /**
     * Gets the last {@link Visit} done by this {@link Patient}.
     *
     * @return a {@link Visit}, the last one made chronologically by the {@link Patient}
     * @throws BeanException thrown for any generic exception bean exception
     */
    public Visit getLastVisit() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return visitDAO.getLastByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in patientDaoBean: ", e);
        }
    }

    /**
     * Gets all the {@link Exam}s done by this {@link Patient} in chronological order.
     *
     * @return a {@link List} of {@link Exam}s done by this patient, ordered chronologically
     * @throws BeanException thrown for any generic exception bean exception
     */
    public List<Exam> getExams() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return examDAO.getByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    /**
     * Gets all the {@link Visit}s done by this {@link Patient} in chronological order.
     *
     * @return a {@link List} of {@link Visit}s done by this patient, ordered chronologically
     * @throws BeanException thrown for any generic exception bean exception
     */
    public List<Visit> getDoneVisits() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return visitDAO.getDoneByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting done visits in patientDaoBean: ", e);
        }
    }


    /**
     * Gets the pending {@link Visit}, if exists, for this {@link Patient}.
     *
     * @return the pending {@link Visit}, if exists, for this {@link Patient}
     * @throws BeanException thrown for any generic exception bean exception
     */
    public Visit getPendingVisit() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return visitDAO.getPendingByPractitionerAndPatient(getPatient().getPractitionerID(), patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting the pending Visit in patientDaoBean: ", e);
        }
    }

    /**
     * Gets this {@link Patient}'s {@link GeneralPractitioner}.
     *
     * @return the {@link Patient}'s associated {@link GeneralPractitioner}
     * @throws BeanException thrown for any generic exception bean exception
     */
    public GeneralPractitioner getPractitioner() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return practitionerDAO.getByPrimaryKey(getPatient().getPractitionerID());
        } catch (DAOException e) {
            throw new BeanException("Error getting exams in patientDaoBean: ", e);
        }
    }

    /**
     * Gets this {@link Patient}'s valid {@link DrugPrescription}s.
     *
     * @return the {@link Patient}'s valid {@link DrugPrescription}s
     * @throws BeanException thrown for any generic exception bean exception
     */
    public List<DrugPrescription> getValidPrescriptions() throws BeanException {
        List<DrugPrescription> prescriptions;

        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            prescriptions = drugPrescriptionDAO.getValidByPatient(patientID);

        } catch (DAOException e) {
            throw new BeanException("Error getting drugPre list in patientDaoBean: ", e);
        }
        return prescriptions;
    }

    /**
     * Gets this {@link Patient}'s unpaid {@link DrugPrescription}s.
     *
     * @return the {@link Patient}'s unpaid {@link DrugPrescription}s
     * @throws BeanException thrown for any generic exception bean exception
     */
    public List<DrugPrescription> getUnpaidPrescriptions() throws BeanException {
        List<DrugPrescription> prescriptions;

        if (patientID == null) {
            throw new BeanException("Patient is null");
        }

        try {
            prescriptions = drugPrescriptionDAO.getUnpaidByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting unpaid Prescriptions in patientDaoBean: ", e);
        }
        return prescriptions;
    }

    /**
     * Gets this {@link Patient}'s unpaid {@link Exam}s.
     *
     * @return the {@link Patient}'s unpaid {@link Exam}s
     * @throws BeanException thrown for any generic exception bean exception
     */
    public List<Exam> getUnpaidExams() throws BeanException {
        List<Exam> exams;

        if (patientID == null) {
            throw new BeanException("Patient is null");
        }

        try {
            exams = examDAO.getUnpaidByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting unpaid Exams in patientDaoBean: ", e);
        }
        return exams;
    }

}

