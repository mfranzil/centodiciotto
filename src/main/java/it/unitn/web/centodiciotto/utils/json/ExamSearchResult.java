package it.unitn.web.centodiciotto.utils.json;

import com.google.gson.Gson;

import java.io.Serializable;

/**
 * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
 * <p>
 * This class is used by mutiple classes and is thus defined outside them to avoid duplicate code.
 */
public class ExamSearchResult implements Serializable {
    private final Integer id;
    private final String text;

    /**
     * Instantiates a new Exam search result.
     *
     * @param id   the id
     * @param text the text
     */
    public ExamSearchResult(Integer id, String text) {
        this.id = id;
        this.text = text;
    }

    /**
     * Gets text.
     *
     * @return the text
     */
    public String getText() {
        return text;
    }

}