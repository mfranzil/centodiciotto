package it.unitn.web.centodiciotto.servlets.healthservice;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.RecallDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.utils.Common;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/health_service/recalls")
public class RecallsServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static List<ExamList> ALL_EXAMS = new ArrayList<>();

    private ExamDAO examDAO;
    private ExamListDAO examListDAO;
    private RecallDAO recallDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            recallDAO = daoFactory.getDAO(RecallDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);

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

        if (user instanceof HealthService) {
            request.getRequestDispatcher("/jsp/health_service/recalls-hs.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");

        if (user instanceof HealthService) {
            switch (requestType) {
                case "newRecall": {
                    try {
                        Integer examID = Integer.valueOf(request.getParameter("examID"));
                        Integer minAge = Integer.valueOf(request.getParameter("minAge"));
                        Integer maxAge = Integer.valueOf(request.getParameter("maxAge"));

                        if (minAge < maxAge) {
                            ExamList examType = examListDAO.getByPrimaryKey(examID);
                            Recall recall = new Recall();

                            recall.setExamType(examType);
                            recall.setStartDate(new Timestamp(System.currentTimeMillis()));
                            recall.setMinAge(minAge);
                            recall.setMaxAge(maxAge);
                            recall.setHealthServiceID(user.getID());

                            recallDAO.insert(recall);

                            List<Patient> allPatients = patientDAO.getPatientsByProvince(((HealthService) user).getOperatingProvince().getAbbreviation());

                            for (Patient patient : allPatients) {
                                if (Common.isWithinAgeRange(patient.getBirthDate(), minAge, maxAge)) {
                                    Exam exam = new Exam();
                                    exam.setPatientID(patient.getID());
                                    exam.setType(examType);
                                    exam.setDone(false);
                                    exam.setTicket(0);
                                    exam.setTicketPaid(false);
                                    exam.setBooked(false);
                                    exam.setHealthServiceID(user.getID());
                                    exam.setRecall(recall.getID());

                                    System.out.println(exam);
                                    examDAO.insert(exam);
                                }
                            }

                        }
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (NumberFormatException | NullPointerException e) {
                        throw new ServletException("Malformed input: ", e);
                    }
                }
                case "examRow": {
                    try {
                        String examID = request.getParameter("examID");

                        List<TableExam> tableExams = new ArrayList<>();

                        if (examID != null) {
                            Integer integerExamID = Integer.valueOf(examID);
                            Recall lastRecall = recallDAO.getLastByHealthServiceAndExam(
                                    user.getID(), integerExamID);

                            if (lastRecall == null) {
                                tableExams.add(new TableExam(
                                        examListDAO.getByPrimaryKey(integerExamID).getDescription(),
                                        "Not done yet", "Not done yet"));
                            } else {
                                tableExams.add(new TableExam(
                                        lastRecall.getExamType().getDescription(),
                                        lastRecall.getStartDate().toString(),
                                        lastRecall.getMinAge() + " - " + lastRecall.getMaxAge()));
                            }
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(tableExams));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
                case "examSearch": {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        List<ExamSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_EXAMS.stream().filter(examSearchResult
                                -> (examSearchResult.getText().toLowerCase().contains(userInput.toLowerCase())))
                                .forEach(tmpResults::add);
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

    private static class TableExam {
        private String exam;
        private String date;
        private String age;

        public TableExam(String exam, String date, String age) {
            this.exam = exam;
            this.date = date;
            this.age = age;
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
