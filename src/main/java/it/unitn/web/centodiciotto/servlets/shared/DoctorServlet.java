package it.unitn.web.centodiciotto.servlets.shared;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.DoctorExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/restricted/patient/doctors"})
public class DoctorServlet extends HttpServlet {
    private SpecializedDoctorDAO specializedDoctorDAO;
    private DoctorExamDAO doctorExamDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            doctorExamDAO = daoFactory.getDAO(DoctorExamDAO.class);

        } catch (DAOFactoryException e) {
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
        String requestType = request.getParameter("requestType");

        switch (requestType) {
            case "doctorSearch": {
                if (user instanceof Patient) {
                    String userInput = request.getParameter("term");
                    String examID = request.getParameter("examID");

                    if (examID != null) {
                        ExamType examType = new ExamType();
                        examType.setID(Integer.valueOf(examID));

                        try {
                            List<DoctorSearchResult> results = new ArrayList<>();
                            List<DoctorExam> doctorExamList = doctorExamDAO.getByExamList(examType);

                            for (DoctorExam doctorExam : doctorExamList) {
                                SpecializedDoctor specializedDoctor = specializedDoctorDAO.getByPrimaryKey(doctorExam.getDoctorID());
                                results.add(new DoctorSearchResult(doctorExam.getDoctorID(), specializedDoctor.toString()));
                            }

                            if (userInput != null) {
                                List<DoctorSearchResult> tmpResults = new ArrayList<>();
                                results.stream().filter(exam_SearchResult_
                                        -> (exam_SearchResult_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                                results = tmpResults;
                            }

                            Gson gson = new Gson();
                            response.setContentType("application/json");
                            response.getWriter().write(gson.toJson(new Results(results.toArray(new DoctorSearchResult[0]))));
                        } catch (DAOException e) {
                            e.printStackTrace();
                        }
                    }
                }
                break;
            }
        }
    }

    private static class DoctorSearchResult implements Serializable {
        private String id;
        private String text;

        public DoctorSearchResult(String id, String text) {
            this.id = id;
            this.text = text;
        }

        public String getText() {
            return text;
        }

    }

    private static class Results implements Serializable {
        private DoctorSearchResult[] results;

        Results(DoctorSearchResult[] results) {
            this.results = results;
        }
    }
}