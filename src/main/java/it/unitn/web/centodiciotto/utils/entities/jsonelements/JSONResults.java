package it.unitn.web.centodiciotto.utils.entities.jsonelements;

public class JSONResults<T> {
    private T[] results;

    public JSONResults(T[] results) {
        this.results = results;
    }
}
