package it.unitn.web.centodiciotto.beans;

/**
 * Generic exception thrown by JavaBeans in this package.
 */
public class BeanException extends Exception {

    /**
     * Instantiates a new Bean exception with an empty message.
     */
    public BeanException() {
        super();
    }

    /**
     * Instantiates a new Bean exception with a string as a message.
     *
     * @param message the message
     */
    public BeanException(String message) {
        super(message);
    }

    /**
     * Instantiates a new Bean exception wrapping a {@link Throwable}.
     *
     * @param cause the cause
     */
    public BeanException(Throwable cause) {
        super(cause);
    }

    /**
     * Instantiates a new Bean exception wrapping a {@link Throwable} with a string as a message.
     *
     * @param message the message
     * @param cause   the cause
     */
    public BeanException(String message, Throwable cause) {
        super(message, cause);
    }
}
