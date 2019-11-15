/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.dao.exceptions;

/**
 * The type Dao factory exception.
 */
public class DAOFactoryException extends Exception {

    /**
     * Instantiates a new Dao factory exception.
     */
    public DAOFactoryException() {
        super();
    }

    /**
     * Instantiates a new Dao factory exception.
     *
     * @param message the message
     */
    public DAOFactoryException(String message) {
        super(message);
    }

    /**
     * Instantiates a new Dao factory exception.
     *
     * @param cause the cause
     */
    public DAOFactoryException(Throwable cause) {
        super(cause);
    }

    /**
     * Instantiates a new Dao factory exception.
     *
     * @param message the message
     * @param cause   the cause
     */
    public DAOFactoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
