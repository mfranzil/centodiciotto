package it.unitn.web.centodiciotto.services;

/**
 * The type Service exception.
 */
public class ServiceException extends Exception {

    /**
     * Instantiates a new Service exception with an empty message.
     */
    public ServiceException() {
        super();
    }

    /**
     * Instantiates a new Service exception with a {@link String} as a message.
     *
     * @param message the message
     */
    public ServiceException(String message) {
        super(message);
    }

    /**
     * Instantiates a new Service exception wrapping a {@link Throwable}.
     *
     * @param cause the cause
     */
    public ServiceException(Throwable cause) {
        super(cause);
    }

    /**
     * Instantiates a new Service exception wrapping a {@link Throwable} with a {@link String} as a message.
     *
     * @param message the message
     * @param cause   the cause
     */
    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}
