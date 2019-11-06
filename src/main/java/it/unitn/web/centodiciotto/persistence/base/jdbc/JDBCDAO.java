/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO JDBC Implementation
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.base.jdbc;

import it.unitn.web.centodiciotto.persistence.base.DAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.factories.jdbc.JDBCDAOFactory;

import java.sql.Connection;
import java.sql.ResultSet;

public abstract class JDBCDAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> implements DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {
    protected final Connection CON;
    protected final DAOFactory DAOFACTORY;

    protected JDBCDAO(Connection con) throws DAOFactoryException {
        super();
        this.CON = con;
        DAOFACTORY = JDBCDAOFactory.getInstance();
    }

    abstract protected ENTITY_CLASS mapRowToEntity(ResultSet rs) throws DAOException;
}
