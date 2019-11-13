package it.unitn.web.centodiciotto.beans;


import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;

import java.io.Serializable;
import java.util.List;

public class ExamDAOBean implements Serializable {

    private ExamDAO examDAO = null;

    private String userID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            examDAO = daoFactory.getDAO(ExamDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public List<Exam> getPatientsNotPaid() throws BeanException {
        List<Exam> exams;

        if (userID == null) {
            throw new BeanException("Practitioner is null");
        }

        try {
            exams = examDAO.getUnpaidByPatient(userID);
        } catch (DAOException e) {
            throw new BeanException("Error getting exam list in examDaoBean: ", e);
        }
        return exams;
    }
}
