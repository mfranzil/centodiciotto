package it.unitn.web.centodiciotto.beans.entities;

import it.unitn.web.centodiciotto.beans.BeanException;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

import java.io.Serializable;
import java.util.List;

/**
 * JavaBean representing a {@link GeneralPractitionerDAO} bound to a {@link GeneralPractitioner}.
 */
public class GeneralPractitionerDAOBean implements Serializable {
    private VisitDAO visitDAO = null;
    private PatientDAO patientDAO = null;
    private GeneralPractitionerDAO generalPractitionerDAO = null;

    private String practitionerID = null;

    /**
     * Initializes the bean.
     * <p>
     * Retrieves a DAOFactory implementation and then retrieves the DAOS.
     *
     * @param initializer a parameter required by the JavaBeans implementation that can be left to null.
     */
    public void setInit(String initializer) throws BeanException {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            throw new BeanException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Sets the practitionerID.
     *
     * @param practitionerID the practitionerID
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    /**
     * Gets the {@link GeneralPractitioner} entity associated to this ID.
     *
     * @return the {@link GeneralPractitioner} entity associated to this ID
     * @throws BeanException thrown for any generic exception
     */
    public GeneralPractitioner getPractitioner() throws BeanException {
        if (practitionerID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            return generalPractitionerDAO.getByPrimaryKey(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in practitionerDaoBean: ", e);
        }
    }

    /**
     * Gets a {@link List} of pending {@link Visit}s associated with this {@link GeneralPractitioner}.
     *
     * @return the {@link List} of pending {@link Visit}s associated with this {@link GeneralPractitioner}
     * @throws BeanException thrown for any generic exception
     */
    public List<Visit> getPendingVisits() throws BeanException {
        if (practitionerID == null) {
            throw new BeanException("Practitioner is null.");
        }

        try {
            return visitDAO.getPendingByPractitioner(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Visits: ", e);
        }
    }

    /**
     * Gets {@link List} of booked {@link Visit}s associated with this {@link GeneralPractitioner}.
     *
     * @return the {@link List} of booked {@link Visit}s associated with this {@link GeneralPractitioner}.
     * @throws BeanException thrown for any generic exception
     */
    public List<Visit> getBookedVisits() throws BeanException {
        if (practitionerID == null) {
            throw new BeanException("Practitioner is null.");
        }

        try {
            return visitDAO.getBookedByPractitioner(practitionerID);
        } catch (DAOException e) {
            throw new BeanException("Error getting booked Visits: ", e);
        }
    }
}
