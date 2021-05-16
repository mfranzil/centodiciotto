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
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Logger;

/**
 * VisitRequestServlet for handling requests to /restricted/general_practitioner/visit_requests.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests retrieve {@code patientID}, date and time from the request, validate them and try to update the
 * date of the {@link Visit}.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/general_practitioner/visit_requests")
public class VisitRequestServlet extends HttpServlet {

    private VisitDAO visitDAO;
    private PatientDAO patientDAO;

    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }

        try {
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
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
            request.getRequestDispatcher("/jsp/general_practitioner/visit-requests-gp.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof GeneralPractitioner) {
            String practitionerID = user.getID();
            String patientID = request.getParameter("patientID");
            String visitDate = request.getParameter("visitDate");
            String visitTime = request.getParameter("visitTime");
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm");

            if (visitDate == null || visitTime == null || patientID == null
                    || visitTime.equals("") || visitDate.equals("")) {
                response.setStatus(400);
                String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            try {
                Date date = formatter.parse(visitDate + " " + visitTime);
                Visit pendingVisit = visitDAO.getPendingByPractitionerAndPatient(practitionerID, patientID);

                if (pendingVisit != null) {
                    pendingVisit.setDate(new Timestamp(date.getTime()));
                    pendingVisit.setBooked(true);

                    visitDAO.update(pendingVisit);

                    Patient patient = patientDAO.getByPrimaryKey(pendingVisit.getPatientID());

                    String recipient = patient.getID();
                    String message = "Dear " + patient.toString() + ",\n\n" +
                            "a visit with your General Practitioner was just appointed.\n\n" +
                            "Here are the visit details:\n\n" +
                            "Practitioner: " + user.toString() + "\n" +
                            "Date: " + CustomDTFormatter.formatDate(pendingVisit.getDate()) +
                            "\n\nYours,\nThe CentoDiciotto team.\n";
                    String subject = "CentoDiciotto - Visit appointment notification";

                    // Notifying patient of the date-time change
                    emailService.sendEmail(recipient, message, subject);

                    writer.write("{}");
                } else {
                    response.setStatus(400);
                    String json = "{\"error\": \"Requested visit is not pending. Cannot assign a date and time.\"}";
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
}
