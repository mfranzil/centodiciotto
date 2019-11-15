package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;

import java.util.ArrayList;
import java.util.List;

/**
 * The type Json utils.
 */
public class JSONUtils {
    /**
     * Create table entry list.
     *
     * @param title   the title
     * @param content the content
     * @return the list
     */
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
