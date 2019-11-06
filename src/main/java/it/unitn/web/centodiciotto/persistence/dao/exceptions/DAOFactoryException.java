/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 08 - Commons - DAO interface
 * UniTN
 */
package it.unitn.web.centodiciotto.persistence.dao.exceptions;

public class DAOFactoryException extends Exception {

    public DAOFactoryException() {
        super();
    }

    public DAOFactoryException(String message) {
        super(message);
    }

    public DAOFactoryException(Throwable cause) {
        super(cause);
    }

    public DAOFactoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
