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
import it.unitn.web.centodiciotto.utils.entities.Pair;

import java.io.Serializable;
import java.util.ArrayList;
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

    private PhotoService photoService;

    /**
     * Initializes the bean.
     * <p>
     * Retrieves a DAOFactory implementation and then retrieves the DAOS.
     *
     * @param initializer a parameter required by the JavaBeans implementation that can be left to null.
     * @throws BeanException if errors during the DAO initialization occur
     */
    public void setInit(String initializer) throws BeanException {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);

            photoService = PhotoService.getInstance();
        } catch (DAOFactoryException e) {
            throw new BeanException("Error in DAO retrieval: ", e);
        } catch (ServiceException e) {
            throw new BeanException("Error in initializing PhotoService: ", e);
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
     * @throws BeanException thrown for any generic exception
     */
    public String getPhotoPath() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return photoService.getLastPhoto(patientID);
        } catch (ServiceException e) {
            throw new BeanException("Error getting PhotoPath in patientDaoBean: ", e);
        }
    }

    /**
     * Gets a {@link List} of {@link Pair}s, each containing a {@link Photo} path associated with this {@link Patient},
     * and a {@link String} representing a fully-formatted date of upload for such photo, in antichronological order.
     *
     * @return a {@link List} of {@link Pair}s with photo paths and dates
     * @throws BeanException thrown for any generic exception
     */
    public List<Pair<String, String>> getAllPhotos() throws BeanException {
        if (patientID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return photoService.getAllPhotos(patientID);
        } catch (ServiceException e) {
            throw new BeanException("Error getting PhotoPath in patientDaoBean: ", e);
        }
    }

    /**
     * Gets all the {@link Exam}s done by this {@link Patient} in chronological order.
     *
     * @return a {@link List} of {@link Exam}s done by this patient, ordered chronologically
     * @throws BeanException thrown for any generic exception
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
     * @throws BeanException thrown for any generic exception
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
     * @throws BeanException thrown for any generic exception
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
     * @throws BeanException thrown for any generic exception
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
     * Gets all this {@link Patient}'s {@link DrugPrescription}s.
     *
     * @return the {@link Patient}'s {@link DrugPrescription}s
     * @throws BeanException thrown for any generic exception
     */
    public List<DrugPrescription> getPrescriptions() throws BeanException {
        List<DrugPrescription> prescriptions;

        if (patientID == null) {
            throw new BeanException("Patient is null");
        }

        try {
            prescriptions = drugPrescriptionDAO.getByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting unpaid Prescriptions in patientDaoBean: ", e);
        }
        return prescriptions;
    }

    /**
     * Gets this {@link Patient}'s done {@link Exam}s.
     *
     * @return the {@link Patient}'s done {@link Exam}s
     * @throws BeanException thrown for any generic exception
     */
    public List<Exam> getDoneExams() throws BeanException {
        List<Exam> exams;

        if (patientID == null) {
            throw new BeanException("Patient is null");
        }

        try {
            exams = examDAO.getDoneByPatient(patientID);
        } catch (DAOException e) {
            throw new BeanException("Error getting unpaid Exams in patientDaoBean: ", e);
        }
        return exams;
    }

    /**
     * Gets a {@link List} of potential {@link GeneralPractitioner}s for this Patient in this {@link Province}.
     *
     * @return a {@link List} of potential {@link GeneralPractitioner}s for this Patient in this {@link Province}
     * @throws BeanException thrown for any generic exception
     */
    public List<GeneralPractitioner> getAvailablePractitioners() throws BeanException {
        List<GeneralPractitioner> practitioners;
        List<GeneralPractitioner> chosenPractitioners = new ArrayList<>();

        if (patientID == null) {
            throw new BeanException("Patient is null");
        }

        try {
            GeneralPractitioner currentPractitioner = getPractitioner();
            practitioners = practitionerDAO.getByProvince(getPatient().getLivingProvince().getID());

            practitioners.stream().filter(practitioner -> !practitioner.getID().equals(currentPractitioner.getID()))
                    .forEach(chosenPractitioners::add);
        } catch (DAOException e) {
            throw new BeanException("Error getting unpaid Exams in patientDaoBean: ", e);
        }
        return chosenPractitioners;
    }

}

