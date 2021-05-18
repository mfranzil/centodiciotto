package it.unitn.web.centodiciotto.utils.json;

import com.google.gson.Gson;

/**
 * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
 * <p>
 * Used by all classes that implement JSON functionality as a wrapper for returning their results.
 *
 * @param <T> the type parameter
 */
public class JSONResult<T> {
    private final T[] results;

    /**
     * Instantiates a new Json results.
     *
     * @param results the results
     */
    public JSONResult(T[] results) {
        this.results = results;
    }
}
