package it.unitn.web.centodiciotto.utils.entities.jsonelements;

import java.io.Serializable;

/**
 * The type Exam search result.
 */
public class ExamSearchResult implements Serializable {
    private Integer id;
    private String text;

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