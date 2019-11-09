package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.utils.entities.HtmlElement;

import java.util.ArrayList;
import java.util.List;

public class JsonUtils {
    public static List<Object> createTableEntry(String title, String content) {
        List<Object> res = new ArrayList<>();
        List<HtmlElement> tmp = new ArrayList<>();

        res.add(new HtmlElement().setElementType("tr"));
        tmp.add(new HtmlElement().setElementType("th").setElementContent(title));
        tmp.add(new HtmlElement().setElementType("td").setElementContent(content));
        res.add(tmp);

        return res;
    }

    public static class Action {
        private String label;
        private Boolean enable;

        public Action(String label, Boolean enable) {
            this.label = label;
            this.enable = enable;
        }
    }
}
