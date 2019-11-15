/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.dao.exceptions;

/**
 * Exception thrown by DAO methods at the moment of the query execution.
 */
public class DAOException extends Exception {

    /**
     * Instantiates a new DAO exception with an empty message.
     */
    public DAOException() {
        super();
    }

    /**
     * Instantiates a new DAO exception with a {@link String} as a message.
     *
     * @param message the message
     */
    public DAOException(String message) {
        super(message);
    }

    /**
     * Instantiates a new DAO exception wrapping a {@link Throwable}.
     *
     * @param cause the cause
     */
    public DAOException(Throwable cause) {
        super(cause);
    }

    /**
     * Instantiates a new DAO exception wrapping a {@link Throwable} with a {@link String} as a message.
     *
     * @param message the message
     * @param cause   the cause
     */
    public DAOException(String message, Throwable cause) {
        super(message, cause);
    }
}
