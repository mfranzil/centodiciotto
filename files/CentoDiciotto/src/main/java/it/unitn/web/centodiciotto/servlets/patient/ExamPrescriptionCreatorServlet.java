package it.unitn.web.centodiciotto.servlets.patient;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import netscape.javascript.JSObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

public class ExamPrescriptionCreatorServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userInput = request.getParameter("term");
        System.out.println(userInput);


        List<String> results = new ArrayList<>();

        results.add("a");
        results.add("b");
        results.add("c");
        results.add("d");

        JSONObject json = new JSONObject();

        int k = 0;
        for (String i : results ) {
            json.put("id", k);
            json.put("text", i);
            k++;
        }

        String a = "{\n" +
                "\"id\": 1,\n" +
                "\"text\": 'bug'\n" +
                "},\n" +
                "{\n" +
                "\"id\": 2,\n" +
                "\"text\": 'duplicate'\n" +
                "},\n" +
                "{\n" +
                "\"id\": 3,\n" +
                "\"text\": 'invalid'\n" +
                "},\n" +
                "{\n" +
                "\"id\": 4,\n" +
                "\"text\": 'wontfix'\n" +
                "}";
        System.out.println(a);
        response.setContentType("application/json");
        response.getWriter().write(a);
    }
}
