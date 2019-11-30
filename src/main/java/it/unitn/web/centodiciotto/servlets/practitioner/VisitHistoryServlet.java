package it.unitn.web.centodiciotto.servlets.practitioner;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * VisitHistoryServlet for handling requests to /restricted/general_practitioner/visit_history.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> visitList: select2 AJAX response generator for returning a list of available {@link Visit}s
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup to
 *                        let the user update a {@link Visit}'s report.
 *     <li> setReport: updates a {@link Visit}'s report.
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/general_practitioner/visit_history")
public class VisitHistoryServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

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
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
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

        if (user instanceof GeneralPractitioner) {
            request.getRequestDispatcher("/jsp/general_practitioner/visit_history-gp.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (requestType == null) {
            response.setStatus(400);
            String json ="{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
            writer.write(json);
            Logger.getLogger("C18").severe(json);
            return;
        }

        if (user instanceof GeneralPractitioner) {
            switch (requestType) {
                case "visitList": {
                    try {
                        List<Visit> visitList = visitDAO.getDoneByPractitioner(user.getID());
                        List<VisitListElement> visitListElements = new ArrayList<>();

                        for (Visit visit : visitList) {
                            Patient patient = patientDAO.getByPrimaryKey(visit.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            Action action = visit.getReport() == null
                                    ? new Action("Insert report", true)
                                    : new Action("Edit report", true);
                            visitListElements.add(new VisitListElement(
                                    patient.toString(), patient.getSSN(),
                                    photoPath, CustomDTFormatter.formatDateTime(visit.getDate()),
                                    action, visit.getID().toString()));
                        }

                        Gson gson = new Gson();
                        writer.write(gson.toJson(visitListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                    break;
                }
                case "detailedInfo": {
                    try {
                        String visitID = request.getParameter("item");

                        if (visitID == null) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. Please choose a valid visit.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                            return;
                        }

                        List<Object> jsonResponse = new ArrayList<>();

                        Visit currentVisit = visitDAO.getByPrimaryKey(Integer.valueOf(visitID));

                        jsonResponse.add(new HTMLElement()
                                .setElementType("form")
                                .setElementClass("submit-report")
                                .setElementFormAction(contextPath + "/restricted/general_practitioner/visit_history")
                                .setElementFormMethod("POST"));

                        List<HTMLElement> form = new ArrayList<>();

                        if (currentVisit.getReport() != null) {
                            form.add(new HTMLElement().setElementType("h5").setElementContent("Old report:"));
                            form.add(new HTMLElement().setElementType("p").setElementContent(currentVisit.getReport()));
                        }

                        form.add(new HTMLElement().setElementType("h5").setElementContent("Please enter the report in the form below, " +
                                "then click on submit to set it."));

                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputValue(visitID)
                                .setElementInputName("visitID"));
                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputValue("setReport")
                                .setElementInputName("requestType"));
                        form.add(new HTMLElement().setElementType("textarea")
                                .setElementTextAreaPlaceholder("Click to start typing...")
                                .setElementTextAreaName("reportText"));
                        form.add(new HTMLElement().setElementType("button")
                                .setElementClass("btn btn-lg btn-block btn-personal submit-button mt-2")
                                .setElementButtonType("submit")
                                .setElementContent("Submit report"));
                        jsonResponse.add(form);

                        Gson gson = new Gson();
                        writer.write(gson.toJson(jsonResponse));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
                case "setReport": {
                    Integer visitID;
                    String reportText = request.getParameter("reportText");

                    try {
                        visitID = Integer.valueOf(request.getParameter("examID"));
                    } catch (NumberFormatException | NullPointerException e) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    if (reportText == null) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    try {
                        Visit visit = visitDAO.getByPrimaryKey(visitID);
                        visit.setReport(reportText);
                        visitDAO.update(visit);

                        Patient patient = patientDAO.getByPrimaryKey(visit.getPatientID());

                        String recipient = patient.getID();
                        String message = "Dear " + patient.toString() + ",\n\n" +
                                "a visit with your General Practitioner has had its report updated.\n\n" +
                                "Here are the visit details:\n\n" +
                                "Practitioner: " + user.toString() + "\n" +
                                "Date: " + CustomDTFormatter.formatDate(visit.getDate()) +
                                "\n\nYours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - Visit report update notification";

                        // Avviso il paziente dell'aggiornamento del report
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
    private static class VisitListElement implements Serializable {
        private String name;
        private String ssn;
        private String avt;
        private String date;
        private Action action;
        private String ID;

        /**
         * Instantiates a new Visit list element.
         *
         * @param name   the name
         * @param ssn    the ssn
         * @param avt    the avt
         * @param date   the date
         * @param action the action
         * @param ID     the id
         */
        VisitListElement(String name, String ssn, String avt, String date, Action action, String ID) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.date = date;
            this.action = action;
            this.ID = ID;
        }
    }
}
