package it.unitn.web.centodiciotto.persistence.base;

import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;

import java.util.List;

/**
 * The interface Dao.
 *
 * @param <ENTITY_CLASS>      the type parameter
 * @param <PRIMARY_KEY_CLASS> the type parameter
 */
public interface DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {

    /**
     * Insert.
     *
     * @param entityClass the entity class
     * @throws DAOException the dao exception
     */
    void insert(ENTITY_CLASS entityClass) throws DAOException;

    /**
     * Update.
     *
     * @param entityClass the entity class
     * @throws DAOException the dao exception
     */
    void update(ENTITY_CLASS entityClass) throws DAOException;

    /**
     * Delete.
     *
     * @param entityClass the entity class
     * @throws DAOException the dao exception
     */
    void delete(ENTITY_CLASS entityClass) throws DAOException;

    /**
     * Gets by primary key.
     *
     * @param primaryKey the primary key
     * @return the by primary key
     * @throws DAOException the dao exception
     */
    ENTITY_CLASS getByPrimaryKey(PRIMARY_KEY_CLASS primaryKey) throws DAOException;

    /**
     * Gets all.
     *
     * @return the all
     * @throws DAOException the dao exception
     */
    List<ENTITY_CLASS> getAll() throws DAOException;

    /**
     * Gets count.
     *
     * @return the count
     * @throws DAOException the dao exception
     */
    Long getCount() throws DAOException;

}
