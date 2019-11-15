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
 * This interface must be implemented by all the concrete {@link DAOFactory}.
 */
public interface DAOFactory {

    /**
     * Shutdowns the connection to the storage system.
     *
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    void shutdown() throws DAOFactoryException;

    /**
     * Returns the concrete {@link DAO} whose type is the class passed as parameter.
     *
     * @param <DAO_CLASS> the class name of the {@link DAO} to get.
     * @param daoInterface the class instance of the {@link DAO} to get.
     * @return the concrete {@link DAO} which type is the class passed as
     * parameter.
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoInterface) throws DAOFactoryException;
}
