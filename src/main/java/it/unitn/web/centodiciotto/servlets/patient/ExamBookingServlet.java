package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.json.ExamSearchResult;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;
import it.unitn.web.centodiciotto.utils.json.HTMLElement;
import it.unitn.web.centodiciotto.utils.json.JSONResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * ExamBookingServlet for handling requests to /restricted/patient/exam_booking.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> examList: select2 AJAX response generator for returning a list of available {@link Exam}s, all exams,
 *                    or just one (selected via examSearch) to show to the Patient
 *     <li> examSearch: select2 AJAX response generator for returing a list of {@link Exam}s the Patient is
 *                      able to choose from a dropdown
 *     <li> doctorSearch: select2 AJAX response generator for returing a list {@link SpecializedDoctor}s
 *                        for the user to choose from and book an exam
 *     <li> doctorExamBook: receives an {@code examID} of a pending Exam and assigns either a {@link HealthService} or
 *                          a {@link SpecializedDoctor} doctor to it (but keeping it pending)
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup showing an additional select2
 *                        selector served by doctorSearch
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/patient/exam_booking")
public class ExamBookingServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static List<ExamType> ALL_EXAMS = new ArrayList<>();

    private ExamTypeDAO examTypeDAO;
    private ExamDAO examDAO;
    private DoctorExamDAO doctorExamDAO;
    private HealthServiceDAO healthServiceDAO;
    private SpecializedDoctorDAO specializedDoctorDAO;

    private String contextPath;

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
            doctorExamDAO = daoFactory.getDAO(DoctorExamDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);

            ALL_EXAMS = examTypeDAO.getAll();
            for (ExamType exam : ALL_EXAMS) {
                ALL_INTERNAL_EXAMS.add(new ExamSearchResult(exam.getID(), exam.getDescription()));
            }
        } catch (DAOFactoryException | DAOException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
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

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/exam_booking-p.jsp").forward(request, response);
        }
    }

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

        if (user instanceof Patient) {
            switch (requestType) {
                case "examList" -> {
                    try {
                        boolean onlyAvailable = Boolean.parseBoolean(request.getParameter("onlyAvailable"));

                        String examID = request.getParameter("examID");

                        List<ExamListElement> examListElements = new ArrayList<>();

                        List<Exam> patientExamList = examDAO.getUnassignedByPatient(user.getID());

                        if (examID == null) {
                            if (onlyAvailable) {
                                for (Exam exam : patientExamList) {
                                    examListElements.add(new ExamListElement(exam.getType().getDescription(), new HTMLAction("Book Now", true), exam.getType().getID()));
                                }
                            } else {
                                List<Integer> examListIDs = new ArrayList<>();

                                for (Exam exam : patientExamList) {
                                    examListIDs.add(exam.getType().getID());
                                }

                                for (ExamType examType : ALL_EXAMS) {
                                    examListElements.add(new ExamListElement(examType.getDescription(), new HTMLAction("Book Now", examListIDs.contains(examType.getID())), examType.getID()));
                                }
                            }
                        } else {
                            Integer integerExamID = Integer.valueOf(examID);
                            boolean found = false;

                            for (Exam exam : patientExamList) {
                                if (exam.getType().getID().equals(integerExamID)) {
                                    found = true;
                                    break;
                                }
                            }
                            ExamType examType = examTypeDAO.getByPrimaryKey(integerExamID);
                            examListElements.add(new ExamListElement(examType.getDescription(), new HTMLAction("Book Now", found), examType.getID()));
                        }

                        Gson gson = new Gson();
                        writer.write(gson.toJson(examListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                }
                case "examSearch" -> {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        List<ExamSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_EXAMS.stream().filter(examSearchResult
                                -> (examSearchResult.getText().toLowerCase()
                                .contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    writer.write(gson.toJson(new JSONResult<>(results.toArray(new ExamSearchResult[0]))));
                }
                case "doctorSearch" -> {
                    String userInput = request.getParameter("term");
                    String examID = request.getParameter("examID");

                    if (examID != null) {
                        ExamType examType = new ExamType();
                        examType.setID(Integer.valueOf(examID));

                        try {
                            List<DoctorSearchResult> results = new ArrayList<>();
                            List<DoctorExam> doctorExamList = doctorExamDAO.getByExamType(examType);

                            for (DoctorExam doctorExam : doctorExamList) {
                                SpecializedDoctor specializedDoctor = specializedDoctorDAO.getByPrimaryKey(
                                        doctorExam.getDoctorID());
                                results.add(new DoctorSearchResult(doctorExam.getDoctorID(),
                                        specializedDoctor.toString(), false));
                            }
                            HealthService livingHealthService = healthServiceDAO.getByProvince(((Patient) user)
                                    .getLivingProvince().getID());
                            results.add(new DoctorSearchResult(livingHealthService.getID(),
                                    livingHealthService.toString(), true));

                            if (userInput != null) {
                                List<DoctorSearchResult> tmpResults = new ArrayList<>();
                                results.stream().filter(doctorSearchResult
                                        -> (doctorSearchResult.getText().toLowerCase()
                                        .contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                                results = tmpResults;
                            }

                            Gson gson = new Gson();
                            writer.write(gson.toJson(new JSONResult<>(results.toArray(new DoctorSearchResult[0]))));
                        } catch (DAOException e) {
                            throw new ServletException("Error in DAO usage: ", e);
                        }
                    }
                }
                case "doctorExamBook" -> {
                    int examID;
                    String doctorID = request.getParameter("doctorID");
                    String isHealthService = request.getParameter("isHealthService");

                    try {
                        examID = Integer.parseInt(request.getParameter("examID"));
                    } catch (NumberFormatException e) {
                        response.setStatus(400);
                        String json = "{\"error\":\"Malformed input. Please choose a valid exam.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    if (doctorID != null && isHealthService != null) {
                        try {
                            ExamType examType = examTypeDAO.getByPrimaryKey(examID);
                            Exam toUpdate = examDAO.getPendingByPatientAndExamType(
                                    user.getID(), examType.getID());

                            if (toUpdate != null) {
                                User performer;
                                String performerType;

                                if (Boolean.parseBoolean(isHealthService)) {
                                    toUpdate.setHealthServiceID(doctorID);
                                    toUpdate.setTicket(11);
                                    performer = healthServiceDAO.getByPrimaryKey(doctorID);
                                    performerType = "Local Health Service";
                                } else {
                                    toUpdate.setDoctorID(doctorID);
                                    toUpdate.setTicket(50);
                                    performer = specializedDoctorDAO.getByPrimaryKey(doctorID);
                                    performerType = "Specialized Doctor";
                                }

                                toUpdate.setBooked(false);
                                toUpdate.setType(examType);
                                toUpdate.setDone(false);

                                examDAO.update(toUpdate);

                                String recipient = user.getID();
                                String message = "Dear " + user + ",\n\n" +
                                        "your exam booking request for the following exam has been accepted:\n\n" +
                                        "Exam: " + examType.getDescription() + "\n\n" +
                                        performerType + ": " + performer.toString() + "\n\n" +
                                        "You will receieve an email once " +
                                        "the " + performerType + " sets a date and time for this exam." +
                                        "\n\nYours,\nThe CentoDiciotto team.\n";
                                String subject = "CentoDiciotto - Exam request notification";

                                // Avviso il paziente della richiesta d'esame
                                emailService.sendEmail(recipient, message, subject);

                                writer.write("{}");
                            } else {
                                response.setStatus(400);
                                String json = "{\"error\":\"" +
                                        "Requested exam is not pending and cannot be booked.\"}";
                                writer.write(json);
                                Logger.getLogger("C18").severe(json);
                            }
                        } catch (DAOException e) {
                            throw new ServletException("Error in DAO usage: ", e);
                        } catch (ServiceException e) {
                            throw new ServletException("Error in email sending: ", e);
                        }
                    } else {
                        response.setStatus(400);
                        String json = "{\"error\":\"Malformed input. Please try again.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                    }
                }
                case "detailedInfo" -> {
                    String examID = request.getParameter("item");

                    if (examID == null) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please choose a valid exam.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    List<Object> jsonResponse = new ArrayList<>();

                    jsonResponse.add(new HTMLElement().setElementType("form").setElementClass("doctor-form").setElementFormAction(contextPath + "restricted/patient/exam_booking").setElementFormMethod("POST"));

                    List<HTMLElement> examForm = new ArrayList<>();
                    examForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden").setElementInputName("examID").setElementInputValue(examID));
                    examForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden").setElementInputName("requestType").setElementInputValue("doctorExamBook"));
                    examForm.add(new HTMLElement().setElementType("h5").setElementContent("Select a Specialized Doctor from the menu below"));
                    examForm.add(new HTMLElement().setElementType("select").setElementClass("select2-allow-clear form-control doctor-search mt-2").setElementSelectName("doctorID"));
                    examForm.add(new HTMLElement().setElementType("button").setElementClass("btn btn-lg btn-block btn-personal prescribe-exam mt-2").setElementButtonType("submit").setElementContent("Book exam"));
                    examForm.add(new HTMLElement().setElementType("small").setElementClass("doctor-label"));

                    jsonResponse.add(examForm);

                    jsonResponse.add(new HTMLElement().setElementType("script").setElementScriptType("text/javascript").setElementScriptSrc(contextPath + "js/details/doctorExam.js"));

                    Gson gson = new Gson();
                    writer.write(gson.toJson(jsonResponse));
                }
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class ExamListElement implements Serializable {
        private final String exam;
        private final HTMLAction action;
        private final Integer ID;

        /**
         * Instantiates a new Exam list element.
         *
         * @param exam   the exam
         * @param action the action
         * @param ID     the id
         */
        ExamListElement(String exam, HTMLAction action, Integer ID) {
            this.exam = exam;
            this.action = action;
            this.ID = ID;
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class DoctorSearchResult implements Serializable {
        private final String id;
        private final String text;
        private final Boolean healthService;

        /**
         * Instantiates a new Doctor search result.
         *
         * @param id            the id
         * @param text          the text
         * @param healthService the health service
         */
        DoctorSearchResult(String id, String text, Boolean healthService) {
            this.id = id;
            this.text = text;
            this.healthService = healthService;
        }

        /**
         * Gets text.
         *
         * @return the text
         */
        public String getText() {
            return text;
        }

    }
}