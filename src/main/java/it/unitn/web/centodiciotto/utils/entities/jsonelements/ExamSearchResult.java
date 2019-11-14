package it.unitn.web.centodiciotto.utils.entities.jsonelements;

import java.io.Serializable;

public class ExamSearchResult implements Serializable {
    private Integer id;
    private String text;

    public ExamSearchResult(Integer id, String text) {
        this.id = id;
        this.text = text;
    }

    public String getText() {
        return text;
    }

}