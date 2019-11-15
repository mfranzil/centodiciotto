package it.unitn.web.centodiciotto.beans;

/**
 * The type Bean exception.
 */
public class BeanException extends Exception {

    /**
     * Instantiates a new Bean exception.
     */
    public BeanException() {
        super();
    }

    /**
     * Instantiates a new Bean exception.
     *
     * @param message the message
     */
    public BeanException(String message) {
        super(message);
    }

    /**
     * Instantiates a new Bean exception.
     *
     * @param cause the cause
     */
    public BeanException(Throwable cause) {
        super(cause);
    }

    /**
     * Instantiates a new Bean exception.
     *
     * @param message the message
     * @param cause   the cause
     */
    public BeanException(String message, Throwable cause) {
        super(message, cause);
    }
}
