package it.unitn.web.centodiciotto.utils.json;

import java.util.ArrayList;
import java.util.List;

/**
 * Wrapper class for the createTableEntry method, used by classes that implement JSON functionality.
 */
public class JSONUtils {
    /**
     * Creates a new table that contains {@link HTMLElement}s, to be returned in JSON form.
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
