package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.JsonUtils;

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
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static List<ExamList> ALL_EXAMS = new ArrayList<>();

    /*
    TODO It's still testing time, please do not pay attention
     */
    private ExamListDAO examListDAO;
    private ExamPrescriptionDAO examPrescriptionDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
            examPrescriptionDAO = daoFactory.getDAO(ExamPrescriptionDAO.class);

            ALL_EXAMS = examListDAO.getAll();
            for (ExamList exam : ALL_EXAMS) {
                ALL_INTERNAL_EXAMS.add(new ExamSearchResult(exam.getID(), exam.getDescription()));
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
        String requestType = (String) request.getParameter("requestType");

        switch (requestType) {
            case "examList": {
                try {
                    if (user instanceof Patient) {
                        Boolean onlyAvailable = Boolean.valueOf(request.getParameter("onlyAvailable"));
                        String examID = request.getParameter("examID");

                        List<ExamListElement> examListElements = new ArrayList<>();
                        System.out.println(onlyAvailable.toString() + " " + examID);
                        List<ExamPrescription> patientExamPrescriptionList = examPrescriptionDAO.getByPatientNotBooked(user.getID());

                        if (examID == null) {
                            for (ExamList examList : ALL_EXAMS) {
                                if (examList.getID() == patientExamPrescriptionList.get(0).getExamType().getID()) {
                                    examListElements.add(new ExamListElement(examList.getDescription(), new JsonUtils.Action("Book Now", true)));
                                    patientExamPrescriptionList.remove(0);
                                } else {
                                    if (!onlyAvailable) {
                                        examListElements.add(new ExamListElement(examList.getDescription(), new JsonUtils.Action("Book Now", false)));
                                    }
                                }
                            }
                        } else {
                            Integer integerExamID = Integer.valueOf(examID);
                            boolean found = false;
                            for (ExamPrescription examPrescription : patientExamPrescriptionList) {
                                if (examPrescription.getExamType().getID() == integerExamID) {
                                    examListElements.add(new ExamListElement(examListDAO.getByPrimaryKey(integerExamID).getDescription(), new JsonUtils.Action("Book Now", true)));
                                    found = true;
                                }
                            }
                            if (!found) {
                                examListElements.add(new ExamListElement(examListDAO.getByPrimaryKey(integerExamID).getDescription(), new JsonUtils.Action("Book Now", false)));
                            }
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(examListElements));
                    }
                } catch (DAOException e) {
                    e.printStackTrace();
                }
                break;
            }
            case "examSearch": {
                if (user instanceof Patient) {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        List<ExamSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_EXAMS.stream().filter(exam_SearchResult_
                                -> (exam_SearchResult_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new Results(results.toArray(new ExamSearchResult[0]))));
                }
                break;
            }
        }
    }


    private static class ExamListElement {
        private String exam;
        private JsonUtils.Action action;

        ExamListElement(String exam, JsonUtils.Action action) {
            this.exam = exam;
            this.action = action;
        }
    }

    private static class ExamSearchResult implements Serializable {
        private Integer id;
        private String text;

        ExamSearchResult(Integer id, String text) {
            this.id = id;
            this.text = text;
        }

        public String getText() {
            return text;
        }

    }

    private static class Results implements Serializable {
        private ExamSearchResult[] results;

        Results(ExamSearchResult[] results) {
            this.results = results;
        }
    }
}