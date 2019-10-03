package it.unitn.web.centodiciotto.servlets.patient;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
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
    /*
    It's still testing time, please do not pay attention
     */
    private ExamListDAO examListDAO;
    private static List<ExamList> ALL_EXAMS = new ArrayList<>();
    private static final  List<Exam_> ALL_INTERNAL_EXAMS= new ArrayList<>();

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for exam_list storage system");
        }
        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for exam_list storage system", ex);
        }
        try {
            ALL_EXAMS = examListDAO.getAll();
        } catch (DAOException e) {
            e.printStackTrace();
        }
        for (ExamList exam: ALL_EXAMS) {
            ALL_INTERNAL_EXAMS.add(new Exam_(exam.getExamID(), exam.getExamDescription()));
        }
    }

    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String userInput = request.getParameter("term");
        System.out.println("User: ");
        System.out.println(userInput);

        List<Exam_> results = new ArrayList<>();

        if (userInput == null) {
            results = ALL_INTERNAL_EXAMS;
        } else {
            List<Exam_> tmp_results = new ArrayList<>();
            ALL_INTERNAL_EXAMS.stream().filter((Exam_ exam_) -> (exam_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(_item -> {
                        tmp_results.add(_item);
                System.out.println(_item.text);});
            results = tmp_results;
        }

        Gson gson = new Gson();
        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(new Results(results.toArray(new Exam_[0]))));
    }

    public static class Exam_ implements Serializable {

        private Integer id;
        private String text;

        public Exam_(Integer id, String text) {
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

        private Exam_[] results;

        public Results(Exam_[] results) {
            this.results = results;
        }

        public Exam_[] getResults() {
            return results;
        }

        public void setResults(Exam_[] results) {
            this.results = results;
        }
    }
}