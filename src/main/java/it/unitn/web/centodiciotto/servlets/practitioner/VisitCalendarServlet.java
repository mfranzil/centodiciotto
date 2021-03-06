package it.unitn.web.centodiciotto.servlets.practitioner;

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
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.logging.Logger;

/**
 * VisitCalendarServlet for handling requests to /restricted/general_practitioner/visit_calendar
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests get a {@code visitID} and set its report to available, therefore ending its pending status.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/general_practitioner/visit_calendar")
public class VisitCalendarServlet extends HttpServlet {

    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    private EmailService emailService;

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
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            request.getRequestDispatcher("/jsp/general_practitioner/visit_calendar-gp.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof GeneralPractitioner) {
            int visitID;

            try {
                visitID = Integer.parseInt(request.getParameter("visitID"));
            } catch (NumberFormatException | NullPointerException e) {
                response.setStatus(400);
                String json = "{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            try {
                Visit visit = visitDAO.getByPrimaryKey(visitID);

                if (visit.getDate().getTime() >= new Date(System.currentTimeMillis()).getTime()) {
                    response.setStatus(400);
                    String json = "{\"error\": \"Cannot set a visit happening in the future as completed.\"}";
                    writer.write(json);
                    Logger.getLogger("C18").severe(json);
                    return;
                }

                visit.setCompleted(true);
                visitDAO.update(visit);

                Patient patient = patientDAO.getByPrimaryKey(visit.getPatientID());

                String recipient = patient.getID();
                String message = "Dear " + patient + ",\n\n" +
                        "your visit with your General Practitioner was just completed.\n\n" +
                        "Here are the visit details:\n\n" +
                        "Practitioner: " + user + "\n" +
                        "Date: " + CustomDTFormatter.formatDate(visit.getDate()) +
                        "\n\nYou will receieve an additional notification once" +
                        " your General Practitioner inserts a report." +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - Visit completion notification";

                // Notifies the patient about the visit completion
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
