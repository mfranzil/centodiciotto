package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/patient/exams")
public class ExamPrescriptionCreatorServlet extends HttpServlet {
    private static final List<Exam_> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static List<ExamList> ALL_EXAMS = new ArrayList<>();
    /*
    TODO It's still testing time, please do not pay attention
     */
    private ExamListDAO examListDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);

            ALL_EXAMS = examListDAO.getAll();
            for (ExamList exam : ALL_EXAMS) {
                ALL_INTERNAL_EXAMS.add(new Exam_(exam.getID(), exam.getDescription()));
            }
        } catch (DAOFactoryException | DAOException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            doPost(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            String userInput = request.getParameter("term");

            List<Exam_> results;

            if (userInput == null) {
                results = ALL_INTERNAL_EXAMS;
            } else {
                List<Exam_> tmpResults = new ArrayList<>();
                ALL_INTERNAL_EXAMS.stream().filter(exam_
                        -> (exam_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                results = tmpResults;
            }

            Gson gson = new Gson();
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(new Results(results.toArray(new Exam_[0]))));
        }
    }

    private static class Exam_ implements Serializable {
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

    private static class Results implements Serializable {

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