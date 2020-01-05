package it.unitn.web.centodiciotto.persistence.base;

import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;

import java.util.List;

/**
 * The basic DAO interface that all DAOs must implement.
 *
 * @param <ENTITY_CLASS>      the class of the entity to handle.
 * @param <PRIMARY_KEY_CLASS> the class of the primary key of the entity the DAO
 *                            handle.
 */
public interface DAO<ENTITY_CLASS, PRIMARY_KEY_CLASS> {

    /**
     * Gets an {@code ENTITY_CLASS} as a parameter and inserts it into the database.
     * <p>
     * If the entity has a {@code SERIAL} type as a primary key, then returns it internally
     * from the query and tries to assign it.
     *
     * @param entityClass the entity class
     * @throws DAOException in case of a malformed input or query
     */
    void insert(ENTITY_CLASS entityClass) throws DAOException;

    /**
     * Gets an {@code ENTITY_CLASS} as a parameter and updates it in the database, if it exists.
     *
     * @param entityClass the entity class
     * @throws DAOException in case of a malformed input or query
     */
    void update(ENTITY_CLASS entityClass) throws DAOException;

    /**
     * Gets an {@code ENTITY_CLASS} as a parameter and deletes it from the database, if it exists.
     *
     * @param entityClass the entity class
     * @throws DAOException in case of a malformed input or query
     */
    void delete(ENTITY_CLASS entityClass) throws DAOException;

    /**
     * Returns the {@code ENTITY_CLASS} instance of the storage system record
     * with the primary key equals to the one passed as parameter.
     *
     * @param primaryKey the primary key used to obtain the entity instance.
     * @return the {@code ENTITY_CLASS} instance of the storage system record
     * with the primary key equals to the one passed as parameter or
     * {@code null} if no entities with that primary key is present into the
     * storage system.
     * @throws DAOException in case of a malformed input or query
     */
    ENTITY_CLASS getByPrimaryKey(PRIMARY_KEY_CLASS primaryKey) throws DAOException;

    /**
     * Returns the list of all the valid entities of type {@code ENTITY_CLASS}
     * stored by the storage system.
     *
     * @return the list of all the valid entities of type {@code ENTITY_CLASS}.
     * @throws DAOException in case of a malformed input or query
     */
    List<ENTITY_CLASS> getAll() throws DAOException;

    /**
     * Returns the number of records of {@code ENTITY_CLASS} stored on the
     * persistence system of the application.
     *
     * @return the number of records present into the storage system.
     * @throws DAOException in case of a malformed input or query
     */
    Long getCount() throws DAOException;
}
