package it.unitn.web.centodiciotto.beans.entities;

import it.unitn.web.centodiciotto.beans.BeanException;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;

import java.io.Serializable;
import java.util.List;

/**
 * JavaBean representing a {@link SpecializedDoctorDAO} bound to a {@link SpecializedDoctor}.
 */
public class SpecializedDoctorDAOBean implements Serializable {
    private ExamDAO examDAO = null;
    private SpecializedDoctorDAO doctorDAO = null;

    private String doctorID = null;

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

            doctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
        } catch (DAOFactoryException e) {
            throw new BeanException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Sets the doctorID.
     *
     * @param doctorID the doctorID
     */
    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    /**
     * Gets the {@link SpecializedDoctor} entity associated to this ID.
     *
     * @return the {@link SpecializedDoctor} entity associated to this ID
     * @throws BeanException thrown for any generic exception
     */
    public SpecializedDoctor getDoctor() throws BeanException {
        try {
            return doctorDAO.getByPrimaryKey(doctorID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in doctorDaoBean: ", e);
        }

    }

    /**
     * Gets a {@link List} of pending {@link Exam}s associated with this {@link SpecializedDoctor}
     *
     * @return the {@link List} of pending {@link Exam}s associated with this {@link SpecializedDoctor}
     * @throws BeanException thrown for any generic exception
     */
    public List<Exam> getPendingExams() throws BeanException {
        if (doctorID == null) {
            throw new BeanException("DoctorID is null");
        }

        try {
            return examDAO.getPendingByDoctor(doctorID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Exams: ", e);
        }
    }

    /**
     * Gets a {@link List} of booked {@link Exam}s associated with this {@link SpecializedDoctor}
     *
     * @return the {@link List} of booked {@link Exam}s associated with this {@link SpecializedDoctor}
     * @throws BeanException thrown for any generic exception
     */
    public List<Exam> getBookedExams() throws BeanException {
        if (doctorID == null) {
            throw new BeanException("DoctorID is null");
        }

        try {
            return examDAO.getBookedByDoctor(doctorID);
        } catch (DAOException e) {
            throw new BeanException("Error getting pending Visits: ", e);
        }
    }
}
