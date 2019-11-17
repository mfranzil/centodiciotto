package it.unitn.web.centodiciotto.beans.entities;

import it.unitn.web.centodiciotto.beans.BeanException;
import it.unitn.web.centodiciotto.persistence.dao.ChemistDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Chemist;

import java.io.Serializable;

/**
 * JavaBean representing a {@link ChemistDAO} bound to a {@link Chemist}.
 */
public class ChemistDAOBean implements Serializable {
    private ChemistDAO chemistDAO = null;

    private String chemistID = null;

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

            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
        } catch (DAOFactoryException e) {
            throw new BeanException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Sets the chemistID.
     *
     * @param chemistID the chemistID
     */
    public void setChemistID(String chemistID) {
        this.chemistID = chemistID;
    }

    /**
     * Gets the {@link Chemist} entity associated to this ID.
     *
     * @return the {@link Chemist} entity associated to this ID
     * @throws BeanException thrown for any generic exception
     */
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
