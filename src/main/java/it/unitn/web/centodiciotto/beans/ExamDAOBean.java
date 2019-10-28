package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.persistence.dao.factories.jdbc.JDBCDAOFactory;

import java.io.Serializable;
import java.util.List;

public class ExamDAOBean implements Serializable {
    private ExamDAO examDAO = null;
    private String userID = null;

    public void setDAOFactory(String useless){
        try {
            //TODO change with proper model
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            examDAO = daoFactory.getDAO(ExamDAO.class);
        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public List<Exam> getPatientsNotPaid() throws DAOException {
        List<Exam> exams;

        if (userID == null) {
            throw new DAOException("Practitioner is null");
        }

        try {
            exams = examDAO.getByPatientNotPaid(userID);
        } catch (DAOException e) {
            throw new DAOException("Error getting exam list in examDaoBean: ", e);
        }
        return exams;
    }
}
