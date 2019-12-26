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
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.json.ExamSearchResult;
import it.unitn.web.centodiciotto.utils.json.JSONResults;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

/**
 * RecallServlet for handling requests to /restricted/health_service/recalls.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> recallHistory: select2 AJAX response generator for returing a list of {@link Recall}s done by this
 *                         {@link HealthService}.
 *     <li> newRecall: generates a new Recall by picking a {@link List} of {@link Patient}s in a given {@link Province}
 *                     and a given age range, inserting a new {@link Exam} for each patient as long as there's
 *                     not already a pending one in the database.
 *     <li> examRow: select2 AJAX response generator for returing a list of {@link Exam}s from a {@code examID}
 *     <li> examSearch: select2 AJAX response generator for searching {@link Exam}s by name
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused"})
@WebServlet("/restricted/health_service/recalls")
public class RecallServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();

    private ExamDAO examDAO;
    private ExamTypeDAO examTypeDAO;
    private RecallDAO recallDAO;
    private PatientDAO patientDAO;

    private EmailService emailService;

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

        try {
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
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
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (requestType == null) {
            response.setStatus(400);
            String json = "{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
            writer.write(json);
            Logger.getLogger("C18").severe(json);
            return;
        }

        if (user instanceof HealthService) {
            switch (requestType) {
                case "recallHistory": {
                    try {
                        List<Recall> recallList = recallDAO.getByHealthService(user.getID());

                        List<TableExam> patientListElements = new ArrayList<>();
                        for (Recall recall : recallList) {
                            patientListElements.add(new TableExam(
                                    recall.getExamType().getDescription(),
                                    CustomDTFormatter.formatDate(recall.getStartDate()),
                                    recall.getMinAge() + " - " + recall.getMaxAge()
                            ));
                        }

                        Gson gson = new Gson();

                        writer.write(gson.toJson(patientListElements));
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

                            String recipient = user.getID();
                            String message = "Dear " + user.toString() + ",\n\n" +
                                    "a recall was just started in your local SSP area for this exam:\n\n" +
                                    examType.getDescription() +
                                    "\n\nYours,\nThe CentoDiciotto team.\n";
                            String subject = "CentoDiciotto - Recall start notification";

                            // Avviso l'HS dell'avvenuto inizio del recall
                            emailService.sendEmail(recipient, message, subject);

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

                                        recipient = patient.getID();
                                        message = "Dear " + patient.toString() + ",\n\n" +
                                                "a recall was just started in your local SSP area for this exam:\n\n" +
                                                examType.getDescription() + "\n\nPlease contact a Specialized Doctor " +
                                                "as soon as possible to book this exam." +
                                                "\n\nYours,\nThe CentoDiciotto team.\n";
                                        subject = "CentoDiciotto - Recall exam notification";

                                        // Avviso il paziente dell'inizio del recall
                                        emailService.sendEmail(recipient, message, subject);
                                    }
                                }
                            }

                            writer.write("{}");
                        } else {
                            response.setStatus(400);
                            String json = "{\"error\":\"Invalid input (age range must be between 0 and 130).\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                        }
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in email sending: ", e);
                    } catch (NumberFormatException | NullPointerException e) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
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
                                        CustomDTFormatter.formatDateTime(lastRecall.getStartDate()),
                                        lastRecall.getMinAge() + " - " + lastRecall.getMaxAge()));
                            }
                        }

                        Gson gson = new Gson();
                        writer.write(gson.toJson(tableExams));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
                case "examSearch": {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;
                    List<ExamSearchResult> tmpResults = new ArrayList<>();

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        ALL_INTERNAL_EXAMS.stream().filter(examSearchResult
                                -> examSearchResult.getText().toLowerCase().contains(userInput.toLowerCase()))
                                .forEach(tmpResults::add);
                    }

                    Gson gson = new Gson();
                    writer.write(gson.toJson(new JSONResults<>(tmpResults.toArray(new ExamSearchResult[0]))));
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

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
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
        TableExam(String exam, String date, String age) {
            this.exam = exam;
            this.date = date;
            this.age = age;
        }
    }
}
