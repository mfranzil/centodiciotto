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

/**
 * The type Jdbcdao.
 *
 * @param <ENTITY_CLASS>      the type parameter
 * @param <PRIMARY_KEY_CLASS> the type parameter
 */
public abstract class JDBCDAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> implements DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {
    /**
     * The Con.
     */
    protected final Connection CON;
    /**
     * The Daofactory.
     */
    protected final DAOFactory DAOFACTORY;

    /**
     * Instantiates a new Jdbcdao.
     *
     * @param con the con
     * @throws DAOFactoryException the dao factory exception
     */
    protected JDBCDAO(Connection con) throws DAOFactoryException {
        super();
        this.CON = con;
        DAOFACTORY = JDBCDAOFactory.getInstance();
    }

    /**
     * Map row to entity entity class.
     *
     * @param rs the rs
     * @return the entity class
     * @throws DAOException the dao exception
     */
    abstract protected ENTITY_CLASS mapRowToEntity(ResultSet rs) throws DAOException;
}
