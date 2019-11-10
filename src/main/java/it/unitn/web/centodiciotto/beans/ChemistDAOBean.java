package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.persistence.dao.ChemistDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;

import java.io.Serializable;

public class ChemistDAOBean implements Serializable {

    private ChemistDAO chemistDAO = null;

    private String chemistID = null;

    public void setDAOFactory(String useless) {
        try {
            DAOFactory daoFactory = JDBCDAOFactory.getInstance();

            chemistDAO = daoFactory.getDAO(ChemistDAO.class);

        } catch (DAOFactoryException e) {
            throw new RuntimeException("Error in DAO retrieval: ", e);
        }
    }

    public String getChemistID() {
        return chemistID;
    }

    public void setChemistID(String patientID) {
        this.chemistID = patientID;
    }

    public Chemist getChemist() throws BeanException {
        if (chemistID == null) {
            throw new BeanException("ChemistID is null");
        }

        Chemist res;
        try {
            res = chemistDAO.getByPrimaryKey(chemistID);
        } catch (DAOException e) {
            throw new BeanException("Error getting patient in chemistDaoBean: ", e);
        }
        return res;
    }

}
