package it.unitn.web.persistence.dao;

import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;

import java.util.List;

public interface DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {

    Long getCount() throws DAOException;

    ENTITY_CLASS getByPrimaryKey(PRIMARY_KEY_CLASS primaryKey) throws DAOException;

    List<ENTITY_CLASS> getAll() throws DAOException;

    <DAO_CLASS extends DAO> DAO_CLASS getDAO(Class<DAO_CLASS> daoClass) throws DAOFactoryException;
}
