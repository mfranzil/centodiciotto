package it.unitn.web.centodiciotto.utils.entities.jsonelements;

/**
 * The type Json results.
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
