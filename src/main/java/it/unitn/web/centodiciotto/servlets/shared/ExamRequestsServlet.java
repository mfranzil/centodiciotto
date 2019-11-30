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
import it.unitn.web.centodiciotto.utils.entities.jsonelements.Action;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

/**
 * ExamRequestsServlet for handling requests to /restricted/role/exam_requests,
 * where role can be health_service or specialized_doctor.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> requestBook: retrieves {@code patientID}, date and time from the request, validate them and try to update the
 *                       date of the {@link Exam}.
 *     <li> requestList: select2 AJAX response generator for returning a list of available {@link Exam}s
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup to let the user choose a
 *                        date and time for the {@link Exam}.
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet(urlPatterns = {"/restricted/specialized_doctor/exam_requests", "/restricted/health_service/exam_requests"})
public class ExamRequestsServlet extends HttpServlet {
    private ExamDAO examDAO;
    private PatientDAO patientDAO;

    private PhotoService photoService;
    private EmailService emailService;

    private String contextPath;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            photoService = PhotoService.getInstance();
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }

        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            request.getRequestDispatcher("/jsp/shared/exam_requests-hs-sd.jsp").forward(request, response);
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
            return;
        }

        switch (requestType) {
            case "requestBook": {
                if (user instanceof SpecializedDoctor || user instanceof HealthService) {
                    String patientID = request.getParameter("patientID");
                    String examID = request.getParameter("examID");
                    String examDate = request.getParameter("examDate");
                    String examTime = request.getParameter("examTime");

                    if (examDate == null || examTime == null || patientID == null
                            || examTime.equals("") || examDate.equals("") || examID == null) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please insert a valid date and time.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                    } else {
                        try {
                            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                            Date date = formatter.parse(examDate + " " + examTime);
                            Exam pendingExam;

                            if (user instanceof SpecializedDoctor) {
                                pendingExam = examDAO.getPendingByDoctorPatientType(user.getID(),
                                        patientID, Integer.valueOf(examID));
                            } else { // HealthService
                                pendingExam = examDAO.getPendingByHSPatientType(user.getID(),
                                        patientID, Integer.valueOf(examID));
                            }

                            if (pendingExam != null) {
                                pendingExam.setDate(new Timestamp(date.getTime()));
                                pendingExam.setBooked(true);
                                examDAO.update(pendingExam);

                                Patient patient = patientDAO.getByPrimaryKey(pendingExam.getPatientID());
                                String handler = user instanceof SpecializedDoctor ? "Specialized Doctor" : "Local Health Service";

                                String recipient = patient.getID();
                                String message = "Dear " + patient.toString() + ",\n\n" +
                                        "an exam with your " + handler + " was just appointed.\n\n" +
                                        "Here are the exam details:\n\n" +
                                        "Exam handler: " + user.toString() + "\n" +
                                        "Date: " + CustomDTFormatter.formatDate(pendingExam.getDate()) +
                                        "\n\nYours,\nThe CentoDiciotto team.\n";
                                String subject = "CentoDiciotto - Exam appointment notification";

                                // Avviso il paziente dell'avvenuta aggiunta di data e ora
                                emailService.sendEmail(recipient, message, subject);

                                writer.write("{}");
                            } else {
                                response.setStatus(400);
                                String json = "{\"error\": \"Requested exam is not pending. Cannot assign a date and time.\"}";
                                writer.write(json);
                                Logger.getLogger("C18").severe(json);
                            }
                        } catch (DAOException e) {
                            throw new ServletException("Error in DAO usage: ", e);
                        } catch (ParseException e) {
                            throw new ServletException("Error in Date parsing: ", e);
                        } catch (ServiceException e) {
                            throw new ServletException("Error in email sending: ", e);
                        }
                    }
                }
                break;
            }
            case "requestList": {
                if (user instanceof SpecializedDoctor || user instanceof HealthService) {
                    try {
                        List<ExamRequestListElement> examRequestListElements = new ArrayList<>();
                        List<Exam> examList;

                        if (user instanceof SpecializedDoctor) {
                            examList = examDAO.getPendingByDoctor(user.getID());
                        } else {
                            examList = examDAO.getPendingByHS(user.getID());
                        }

                        for (Exam exam : examList) {
                            Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            examRequestListElements.add(new ExamRequestListElement(
                                    photoPath, patient.toString(), exam.getType().getDescription(),
                                    new Action("Choose date and time", true),
                                    patient.getID() + ";" + exam.getType().getID()));
                        }

                        Gson gson = new Gson();
                        writer.write(gson.toJson(examRequestListElements));
                    } catch (ServiceException e) {
                        throw new ServletException("Error in retrieving Photo path: ", e);
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage in requestList: ", e);
                    }
                }
                break;
            }
            case "detailedInfo": {
                String patientIDExamID = request.getParameter("item");

                if (patientIDExamID == null) {
                    response.setStatus(400);
                    String json = "{\"error\": \"Malformed input. Please choose a valid exam.\"}";
                    writer.write(json);
                    Logger.getLogger("C18").severe(json);
                    return;
                }

                List<Object> jsonResponse = new ArrayList<>();

                try {
                    String patientID = patientIDExamID.split(";")[0];
                    String examID = patientIDExamID.split(";")[1];

                    Patient patient = patientDAO.getByPrimaryKey(patientID);

                    jsonResponse.add(new HTMLElement().setElementType("form").
                            setElementClass("set-exam")
                            .setElementFormMethod("POST"));

                    List<Object> setExamForm = new ArrayList<>();
                    setExamForm.add(new HTMLElement().setElementType("p")
                            .setElementContent("Insert a date and time for " +
                                    "the appointment, then confirm."));
                    setExamForm.add(new HTMLElement().setElementType("div")
                            .setElementStyle("display: flex; width: 100%;"));

                    List<Object> div = new ArrayList<>();

                    div.add(new HTMLElement().setElementType("label")
                            .setElementStyle("flex: 50%").setElementClass("my-2 mr-1"));
                    List<HTMLElement> firstLabel = new ArrayList<>();
                    firstLabel.add(new HTMLElement().setElementType("input")
                            .setElementInputName("examDate").setElementInputType("text")
                            .setElementInputAutocomplete("off")
                            .setElementClass("form-control datepicker exam-date"));
                    div.add(firstLabel);

                    div.add(new HTMLElement().setElementType("label")
                            .setElementStyle("flex: 50%").setElementClass("my-2 ml-1"));
                    List<HTMLElement> secondLabel = new ArrayList<>();
                    secondLabel.add(new HTMLElement().setElementType("input")
                            .setElementInputName("examTime").setElementInputType("text")
                            .setElementInputAutocomplete("off")
                            .setElementClass("form-control timepicker exam-time"));
                    div.add(secondLabel);

                    setExamForm.add(div);
                    setExamForm.add(new HTMLElement().setElementType("input")
                            .setElementInputType("hidden").setElementInputValue(patientID)
                            .setElementInputName("patientID"));
                    setExamForm.add(new HTMLElement().setElementType("input")
                            .setElementInputType("hidden").setElementInputValue(examID)
                            .setElementInputName("examID"));
                    setExamForm.add(new HTMLElement().setElementType("button")
                            .setElementClass("btn btn-lg btn-block btn-personal submit")
                            .setElementButtonType("submit")
                            .setElementContent("Confirm the appointment"));

                    jsonResponse.add(setExamForm);

                    jsonResponse.add(new HTMLElement().setElementType("script")
                            .setElementScriptType("text/javascript")
                            .setElementScriptSrc(contextPath + "/js/details/examRequests.js"));

                    Gson gson = new Gson();
                    writer.write(gson.toJson(jsonResponse));
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
                break;
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class ExamRequestListElement implements Serializable {
        private String avt;
        private String patient;
        private String exam;
        private Action action;
        private String ID;

        ExamRequestListElement(String avt, String patient, String exam, Action action, String ID) {
            this.avt = avt;
            this.patient = patient;
            this.exam = exam;
            this.action = action;
            this.ID = ID;
        }
    }
}
