package it.unitn.web.utils;

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
}
