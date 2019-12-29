package it.unitn.web.centodiciotto.persistence.dao.exceptions;

/**
 * Exception thrown by DAO methods at the moment of DAO instantiation.
 * <p>
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
     * Instantiates a new DAOFactory exception with a {@link String} as a message.
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
     * Instantiates a new DAOFactory exception wrapping a {@link Throwable} with a {@link String} as a message.
     *
     * @param message the message
     * @param cause   the cause
     */
    public DAOFactoryException(String message, Throwable cause) {
        super(message, cause);
    }
}
