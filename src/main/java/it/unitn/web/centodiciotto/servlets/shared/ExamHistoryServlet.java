package it.unitn.web.centodiciotto.servlets.shared;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;
import it.unitn.web.centodiciotto.utils.json.HTMLElement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.text.StringEscapeUtils;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * ExamHistoryServlet for handling requests to /restricted/role/exam_history,
 * where role can be health_service or specialized_doctor.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> examList: select2 AJAX response generator for returning a list of available {@link Exam}s
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup to
 *                        let the user update a {@link Exam}'s report.
 *     <li> setResult: updates a {@link Exam}'s report.
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet(urlPatterns = {"/restricted/specialized_doctor/exam_history", "/restricted/health_service/exam_history"})
public class ExamHistoryServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private ExamDAO examDAO;

    private PhotoService photoService;
    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            photoService = PhotoService.getInstance();
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            request.getRequestDispatcher("/jsp/shared/exam_history-hs-sd.jsp").forward(request, response);
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

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            switch (requestType) {
                case "examList" -> {
                    try {
                        List<Exam> examList;

                        if (user instanceof SpecializedDoctor) {
                            examList = examDAO.getDoneByDoctor(user.getID());
                        } else {
                            examList = examDAO.getDoneByHS(user.getID());
                        }

                        List<ExamListElement> examListElements = new ArrayList<>();

                        for (Exam exam : examList) {
                            Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            HTMLAction action = ((exam.getResult() == null)
                                    ? new HTMLAction("Insert result", true)
                                    : new HTMLAction("Edit result", true));
                            examListElements.add(new ExamListElement(
                                    exam.getID().toString(),
                                    patient.toString(),
                                    exam.getType().getDescription(),
                                    photoPath,
                                    CustomDTFormatter.formatDateTime(exam.getDate()),
                                    action));
                        }

                        Gson gson = new Gson();
                        writer.write(gson.toJson(examListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                }
                case "detailedInfo" -> {
                    try {
                        String examID = request.getParameter("item");

                        if (examID == null) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. Please choose a valid exam.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                            return;
                        }

                        List<Object> jsonResponse = new ArrayList<>();

                        Exam currentExam = examDAO.getByPrimaryKey(Integer.valueOf(examID));

                        jsonResponse.add(new HTMLElement()
                                .setElementType("form")
                                .setElementClass("submit-result")
                                .setElementFormMethod("POST"));

                        List<HTMLElement> form = new ArrayList<>();

                        if (currentExam.getResult() != null) {
                            form.add(new HTMLElement().setElementType("h5").setElementContent("Old result:"));
                            form.add(new HTMLElement().setElementType("p").setElementContent(currentExam.getResult()));
                        }

                        form.add(new HTMLElement().setElementType("h5").setElementContent("Please enter the result in the form below, " +
                                "then click on submit to set it."));

                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputValue(examID)
                                .setElementInputName("examID"));
                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputValue("setResult")
                                .setElementInputName("requestType"));
                        form.add(new HTMLElement().setElementType("textarea")
                                .setElementTextAreaPlaceholder("Click to start typing...")
                                .setElementTextAreaName("resultText"));
                        form.add(new HTMLElement().setElementType("button")
                                .setElementClass("btn btn-lg btn-block btn-personal mt-2 submit-button")
                                .setElementButtonType("submit")
                                .setElementContent("Submit result"));
                        jsonResponse.add(form);

                        Gson gson = new Gson();
                        writer.write(gson.toJson(jsonResponse));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ");
                    }
                }
                case "setResult" -> {
                    int examID;
                    String resultText = request.getParameter("resultText");

                    String json;

                    try {
                        examID = Integer.parseInt(request.getParameter("examID"));
                    } catch (NumberFormatException | NullPointerException e) {
                        response.setStatus(400);
                        json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    if (resultText == null) {
                        response.setStatus(400);
                        json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    try {
                        Exam exam = examDAO.getByPrimaryKey(examID);
                        exam.setResult(StringEscapeUtils.escapeHtml4(resultText));
                        examDAO.update(exam);

                        Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                        String handler = user instanceof SpecializedDoctor ? "Specialized Doctor" : "Local Health Service";

                        String recipient = patient.getID();
                        String message = "Dear " + patient + ",\n\n" +
                                "an exam with your " + handler + " has had its report updated.\n\n" +
                                "Here are the exam details:\n\n" +
                                "Exam: " + exam.getType().getDescription() + "\n" +
                                "Exam handler: " + user + "\n" +
                                "Date: " + CustomDTFormatter.formatDate(exam.getDate()) +
                                "\n\nYours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - Exam report update notification";

                        // Notifies the patient of the result update
                        emailService.sendEmail(recipient, message, subject);

                        writer.write("{}");
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in email sending: ", e);
                    }

                }
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class ExamListElement implements Serializable {
        private final String name;
        private final String exam;
        private final String avt;
        private final String date;
        private final HTMLAction action;
        private final String ID;

        ExamListElement(String ID, String name, String exam, String avt, String date, HTMLAction action) {
            this.ID = ID;
            this.name = name;
            this.exam = exam;
            this.avt = avt;
            this.date = date;
            this.action = action;
        }
    }
}
