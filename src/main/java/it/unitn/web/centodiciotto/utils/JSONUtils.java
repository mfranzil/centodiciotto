package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;

import java.util.ArrayList;
import java.util.List;

public class JSONUtils {
    public static List<Object> createTableEntry(String title, String content) {
        List<Object> res = new ArrayList<>();
        List<HTMLElement> tmp = new ArrayList<>();

        res.add(new HTMLElement().setElementType("tr"));
        tmp.add(new HTMLElement().setElementType("th").setElementContent(title));
        tmp.add(new HTMLElement().setElementType("td").setElementContent(content));
        res.add(tmp);

        return res;
    }
}
