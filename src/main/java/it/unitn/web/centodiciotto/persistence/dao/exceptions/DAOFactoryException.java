/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.dao.exceptions;

/**
 * Exception thrown by DAO methods at the moment of DAO instantiation.
 *
 * Can be also thrown in case of DB connection failures.
 */
public class DAOFactoryException extends Exception {

    /**
     * Instantiates a new DAOFactory exception with an empty message.
     */
    public DAOFactoryException() {
        super();
    }

    /**
     * Instantiates a new DAOFactory exception with a string as a message.
     *
     * @param message the message
     */
    public DAOFactoryException(String message) {
        super(message);
    }

    /**
     * Instantiates a new DAOFactory exception wrapping a {@link Throwable}.
     *
     * @param cause the cause
     */
    public DAOFactoryException(Throwable cause) {
        super(cause);
    }

    /**
     * Instantiates a new DAOFactory exception wrapping a {@link Throwable} with a string as a message.
     *
     * @param message the message
     * @param cause   the cause
     */
    public DAOFactoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
