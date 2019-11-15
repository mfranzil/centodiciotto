package it.unitn.web.centodiciotto.servlets.healthservice;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.RecallDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.ExamSearchResult;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.JSONResults;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * The type Recalls servlet.
 */
@WebServlet("/restricted/health_service/recalls")
public class RecallsServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();

    private ExamDAO examDAO;
    private ExamTypeDAO examTypeDAO;
    private RecallDAO recallDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examTypeDAO = daoFactory.getDAO(ExamTypeDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            recallDAO = daoFactory.getDAO(RecallDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);

            List<ExamType> allExams = examTypeDAO.getAll();
            for (ExamType exam : allExams) {
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
                case "recallHistory": {
                    try {
                        List<Recall> recallList = recallDAO.getByHealthService(user.getID());

                        List<TableExam> patientListElements = new ArrayList<>();
                        for (Recall recall : recallList) {
                            patientListElements.add(new TableExam(
                                    recall.getExamType().getDescription(),
                                    recall.getStartDate().toString(),
                                    recall.getMinAge() + " - " + recall.getMaxAge()
                            ));
                        }

                        Gson gson = new Gson();

                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(patientListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
                case "newRecall": {
                    try {
                        Integer examID = Integer.valueOf(request.getParameter("examID"));
                        Integer minAge = Integer.valueOf(request.getParameter("minAge"));
                        Integer maxAge = Integer.valueOf(request.getParameter("maxAge"));

                        if (minAge < maxAge && minAge >= 0 && maxAge <= 130) {
                            ExamType examType = examTypeDAO.getByPrimaryKey(examID);
                            Recall recall = new Recall();

                            recall.setExamType(examType);
                            recall.setStartDate(new Timestamp(System.currentTimeMillis()));
                            recall.setMinAge(minAge);
                            recall.setMaxAge(maxAge);
                            recall.setHealthServiceID(user.getID());

                            recallDAO.insert(recall);

                            List<Patient> allPatients = patientDAO.getByProvince(
                                    ((HealthService) user).getOperatingProvince().getAbbreviation());

                            for (Patient patient : allPatients) {
                                if (isWithinAgeRange(patient.getBirthDate(), minAge, maxAge)) {
                                    Exam pending = examDAO.getPendingRecallByHSPatientType(
                                            user.getID(), patient.getID(), examType.getID());

                                    if (pending == null) {
                                        Exam exam = new Exam();
                                        exam.setPatientID(patient.getID());
                                        exam.setType(examType);
                                        exam.setDone(false);
                                        exam.setTicket(0);
                                        exam.setTicketPaid(false);
                                        exam.setBooked(false);
                                        exam.setHealthServiceID(user.getID());
                                        exam.setRecall(recall.getID());

                                        examDAO.insert(exam);
                                    }
                                }
                            }

                            response.setContentType("application/json");
                            String json = "{\"output\": true}";
                            response.getWriter().write(json);
                        }
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (NumberFormatException | NullPointerException e) {
                        throw new ServletException("Malformed input: ", e);
                    }
                    break;
                }
                case "examRow": {
                    try {
                        String examID = request.getParameter("examID");

                        List<TableExam> tableExams = new ArrayList<>();

                        if (examID != null) {
                            Integer integerExamID = Integer.valueOf(examID);
                            Recall lastRecall = recallDAO.getLastByHSAndExamType(
                                    user.getID(), integerExamID);

                            if (lastRecall == null) {
                                tableExams.add(new TableExam(
                                        examTypeDAO.getByPrimaryKey(integerExamID).getDescription(),
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
                        results = ALL_INTERNAL_EXAMS.stream().filter(examSearchResult
                                -> examSearchResult.getText().toLowerCase().contains(userInput.toLowerCase()))
                                .collect(Collectors.toList());
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new JSONResults<>(results.toArray(new ExamSearchResult[0]))));
                }
                break;
            }
        }
    }

    private boolean isWithinAgeRange(Date date, Integer minAge, Integer maxAge) {
        ZoneId zoneId = ZoneId.systemDefault();

        long minAgeLong = LocalDate.now().minusYears(minAge).atStartOfDay(zoneId).toEpochSecond();
        long maxAgeLong = LocalDate.now().minusYears(maxAge).atStartOfDay(zoneId).toEpochSecond();
        long dateLong = date.getTime() / 1000;

        return dateLong <= minAgeLong && dateLong >= maxAgeLong;
    }

    private static class TableExam implements Serializable {
        private String exam;
        private String date;
        private String age;

        /**
         * Instantiates a new Table exam.
         *
         * @param exam the exam
         * @param date the date
         * @param age  the age
         */
        public TableExam(String exam, String date, String age) {
            this.exam = exam;
            this.date = date;
            this.age = age;
        }
    }
}
