package it.unitn.web.centodiciotto.beans;


import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;

import java.io.Serializable;
import java.util.List;

public class SpecializedDoctorDAOBean implements Serializable {

    private ExamDAO examDAO = null;
    private PatientDAO patientDAO = null;
    private SpecializedDoctorDAO doctorDAO = null;

    private String doctorID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            doctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    public SpecializedDoctor getDoctor() throws BeanException {
        try {
            return doctorDAO.getByPrimaryKey(doctorID);
        } catch (DAOException e) {
            throw new BeanException("Error getting lastVisit in doctorDaoBean: ", e);
        }

    }

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
