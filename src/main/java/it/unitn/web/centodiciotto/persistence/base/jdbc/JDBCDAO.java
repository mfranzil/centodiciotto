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
 * This is the base DAO class all concrete DAO using JDBC technology must extend.
 * @param <ENTITY_CLASS> the class of the entities the dao handle.
 * @param <PRIMARY_KEY_CLASS> the class of the primary key of the entity the
 * dao handle.
 */
public abstract class JDBCDAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> implements DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {
    /**
     * The JDBC {@link Connection} used to access the persistence system.
     */
    protected final Connection CON;
    /**
     * The JDBC {@link DAOFactory} used to access other DAOS, mainly for static tables.
     */
    protected final DAOFactory DAOFACTORY;

    /**
     * The base constructor for all the JDBC DAOs.
     * @param con the internal {@link Connection}.
     * @throws DAOFactoryException in case of DAO instantiation or connection failures
     */
    protected JDBCDAO(Connection con) throws DAOFactoryException {
        super();
        this.CON = con;
        DAOFACTORY = JDBCDAOFactory.getInstance();
    }

    /**
     * Abstract method that all concrete DAOS using JDBC technology must implement
     * for properly assigning {@link ResultSet} to entities.
     *
     * It must properly instantiate an {@code ENTITY_CLASS}.
     *
     * @param rs the {@link ResultSet} from a query
     * @return an {@code ENTITY_CLASS} with all the parameters properly assigned
     * @throws DAOException in case of a malformed input or query
     */
    abstract protected ENTITY_CLASS mapRowToEntity(ResultSet rs) throws DAOException;
}
