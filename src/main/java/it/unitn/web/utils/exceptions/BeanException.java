package it.unitn.web.utils.exceptions;

public class BeanException extends Exception {

    public BeanException() {
        super();
    }

    public BeanException(String message) {
        super(message);
    }

    public BeanException(Throwable cause) {
        super(cause);
    }

    public BeanException(String message, Throwable cause) {
        super(message, cause);
    }
}
