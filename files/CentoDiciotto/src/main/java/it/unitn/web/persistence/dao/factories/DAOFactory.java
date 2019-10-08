/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.persistence.dao.factories;

import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;

public interface DAOFactory {

    void shutdown();

    <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoInterface) throws DAOFactoryException;
}
