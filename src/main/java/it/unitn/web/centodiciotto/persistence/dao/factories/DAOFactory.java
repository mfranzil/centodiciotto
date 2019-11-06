/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.dao.factories;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;

public interface DAOFactory {

    void shutdown() throws DAOFactoryException;

    <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoInterface) throws DAOFactoryException;
}
