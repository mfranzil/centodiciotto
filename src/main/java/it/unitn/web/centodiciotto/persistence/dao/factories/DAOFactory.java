/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.dao.factories;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;

/**
 * The interface Dao factory.
 */
public interface DAOFactory {

    /**
     * Shutdown.
     *
     * @throws DAOFactoryException the dao factory exception
     */
    void shutdown() throws DAOFactoryException;

    /**
     * Gets dao.
     *
     * @param <DAO_CLASS>  the type parameter
     * @param daoInterface the dao interface
     * @return the dao
     * @throws DAOFactoryException the dao factory exception
     */
    <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoInterface) throws DAOFactoryException;
}
