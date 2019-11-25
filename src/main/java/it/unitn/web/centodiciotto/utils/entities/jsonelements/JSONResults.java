package it.unitn.web.centodiciotto.utils.entities.jsonelements;

import com.google.gson.Gson;

/**
 * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
 * <p>
 * Used by all classes that implement JSON functionality as a wrapper for returning their results.
 *
 * @param <T> the type parameter
 */
public class JSONResults<T> {
    private T[] results;

    /**
     * Instantiates a new Json results.
     *
     * @param results the results
     */
    public JSONResults(T[] results) {
        this.results = results;
    }
}
