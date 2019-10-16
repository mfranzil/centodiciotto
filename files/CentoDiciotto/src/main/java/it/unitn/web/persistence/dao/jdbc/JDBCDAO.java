/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO JDBC Implementation
 * UniTN
 */
package it.unitn.web.persistence.dao.jdbc;

import it.unitn.web.persistence.dao.DAO;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;

public abstract class JDBCDAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> implements DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {
    protected final Connection CON;
    protected final HashMap<Class, DAO> FRIEND_DAOS;

    protected JDBCDAO(Connection con) {
        super();
        this.CON = con;
        FRIEND_DAOS = new HashMap<>();
    }

    @Override
    public <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoClass) throws DAOFactoryException {
        return (DAO_CLASS) FRIEND_DAOS.get(daoClass);
    }

    abstract protected ENTITY_CLASS mapRowToEntity(ResultSet resultSet) throws DAOException;
}
