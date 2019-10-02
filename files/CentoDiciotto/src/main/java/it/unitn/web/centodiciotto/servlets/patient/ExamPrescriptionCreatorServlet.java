package it.unitn.web.centodiciotto.servlets.patient;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import netscape.javascript.JSObject;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

public class ExamPrescriptionCreatorServlet extends HttpServlet {
    private static final List<Language> LANGUAGES = new ArrayList<>();

    static {
        LANGUAGES.add(new Language(1, "ActionScript"));
        LANGUAGES.add(new Language(2, "Bootstrap"));
        LANGUAGES.add(new Language(3, "C"));
        LANGUAGES.add(new Language(4, "C++"));
        LANGUAGES.add(new Language(5, "Ecommerce"));
        LANGUAGES.add(new Language(6, "Jquery"));
        LANGUAGES.add(new Language(7, "Groovy"));
        LANGUAGES.add(new Language(8, "Java"));
        LANGUAGES.add(new Language(9, "JavaScript"));
        LANGUAGES.add(new Language(10, "Lua"));
        LANGUAGES.add(new Language(11, "Perl"));
        LANGUAGES.add(new Language(12, "Ruby"));
        LANGUAGES.add(new Language(13, "Scala"));
        LANGUAGES.add(new Language(14, "Swing"));
        LANGUAGES.add(new Language(15, "XHTML"));
    }


    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userInput = request.getParameter("term");
        System.out.println(userInput);

        List<Language> results = new ArrayList<>();
        if (userInput == null) {
            results.addAll(LANGUAGES);
        } else {
            LANGUAGES.stream().filter((Language language) -> (language.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(_item -> {
                results.add(_item);
            });
        }

        Gson gson = new Gson();
        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(new Results(results.toArray(new Language[0]))));
    }

    public static class Language implements Serializable {

        private Integer id;
        private String text;

        public Language(Integer id, String text) {
            this.id = id;
            this.text = text;
        }

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }
    }

    public static class Results implements Serializable {

        private Language[] results;

        public Results(Language[] results) {
            this.results = results;
        }

        public Language[] getResults() {
            return results;
        }

        public void setResults(Language[] results) {
            this.results = results;
        }
    }
}