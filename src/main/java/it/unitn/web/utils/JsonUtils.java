package it.unitn.web.utils;
import java.util.ArrayList;
import java.util.List;

public class JsonUtils {
    public static List<Object> createTableEntry(String title, String content){
        List<Object> res = new ArrayList<>();
        List<HtmlElement> tmp = new ArrayList<>();

        res.add(new HtmlElement("tr", "", ""));
        tmp.add(new HtmlElement("th", "", title));
        tmp.add(new HtmlElement("td", "", content));
        res.add(tmp);

        return res;
    }

    public static class HtmlElement {
        private String elementType;
        private String elementClass;
        private String elementContent;

        public HtmlElement(String elementType, String elementClass, String elementContent) {
            this.elementType = elementType;
            this.elementClass = elementClass;
            this.elementContent = elementContent;
        }
    }
}
