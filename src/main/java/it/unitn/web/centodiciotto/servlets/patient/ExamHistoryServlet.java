package it.unitn.web.centodiciotto.servlets.patient;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.utils.JsonUtils;
import it.unitn.web.centodiciotto.utils.entities.HtmlElement;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/patient/exam_history")
public class ExamHistoryServlet extends HttpServlet {

    private ExamDAO examDAO;
    private ExamTypeDAO examTypeDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            examTypeDAO = daoFactory.getDAO(ExamTypeDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            // TODO Inizio codice da modificare con i beans
            try {
                List<Pair<Exam, String>> to_be_sent = new ArrayList<>();
                List<Exam> exams_history = examDAO.getByPatient(user.getID());
                // Since Exam description is in another table, here I join everything together
                for (Exam exam : exams_history) {
                    try {
                        to_be_sent.add(Pair.makePair(exam,
                                examTypeDAO.getByPrimaryKey(exam.getType().getID()).getDescription()));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                }
                request.setAttribute("exams", to_be_sent);
                request.getRequestDispatcher("/jsp/patient/exam_history-p.jsp").forward(request, response);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
            // TODO Fine codice da modificare
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");

        switch (requestType) {
            case "historyList": {
                try {
                    if (user instanceof Patient) {

                        List<ExamHistoryElement> examHistoryElements = new ArrayList<>();

                        List<Exam> patientExamList = examDAO.getByPatientBooked(user.getID());

                        for (Exam exam : patientExamList) {
                            examHistoryElements.add(new ExamHistoryElement(exam.getType().getDescription(), exam.getDate().toString(), exam.getDone(), new JsonUtils.Action("See report", exam.getDone()), exam.getID()));
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(examHistoryElements));
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
                break;
            }
            case "detailedInfo": {
                try {
                    if (user instanceof Patient) {
                        String examID = request.getParameter("item");

                        List<Object> jsonResponse = new ArrayList<>();
                        Exam currentExam = examDAO.getByPrimaryKey(Integer.valueOf(examID));

                        jsonResponse.add(new HtmlElement().setElementType("h5").setElementContent("Exam Result:"));
                        jsonResponse.add(new HtmlElement().setElementType("p").setElementContent(currentExam.getResult()));

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(jsonResponse));
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
                break;
            }
        }
    }

    private static class ExamHistoryElement {
        private String exam;
        private String date;
        private Boolean report_state;
        private JsonUtils.Action action;
        private Integer ID;

        public ExamHistoryElement(String exam, String date, Boolean reportState, JsonUtils.Action action, Integer ID) {
            this.exam = exam;
            this.date = date;
            this.report_state = reportState;
            this.action = action;
            this.ID = ID;
        }
    }
}