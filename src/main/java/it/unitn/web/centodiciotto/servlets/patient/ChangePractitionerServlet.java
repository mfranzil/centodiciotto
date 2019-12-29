package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

/**
 * ChangePractitionerServlet for handling requests to /restricted/patient/change_practitioner.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests get a {@code practitionerID} and change a {@link Patient}'s {@link GeneralPractitioner},
 * alerting the old practitioner, the new practitioner and the patient itself via the {@link EmailService}.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused"})
@WebServlet("/restricted/patient/change_practitioner")
public class ChangePractitionerServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;
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
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
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

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/change_practitioner-p.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof Patient) {
            try {
                String newPractitionerID = request.getParameter("practitionerID");

                if (newPractitionerID == null) {
                    response.setStatus(400);
                    String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                    writer.write(json);
                    Logger.getLogger("C18").severe(json);
                    return;
                }

                GeneralPractitioner oldPract = practitionerDAO.getByPrimaryKey(((Patient) user).getPractitionerID());
                GeneralPractitioner newPract = practitionerDAO.getByPrimaryKey(newPractitionerID);

                ((Patient) user).setPractitionerID(newPractitionerID);
                patientDAO.update((Patient) user);

                Visit pendingVisit = visitDAO.getPendingByPractitionerAndPatient(oldPract.getID(), user.getID());
                if (pendingVisit != null) {
                    visitDAO.delete(pendingVisit);
                }

                String recipient = oldPract.getID();
                String message = "Dear " + oldPract.toString() + ",\n\n" +
                        "one of your patients just asked for a change of practitioner " +
                        "and will be no longer on your patient list.\n\n" +
                        "Here are the patient details:\n\n" +
                        user.toString() + "\n" +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - Patient change notification";

                // Notifies the old practitioner
                emailService.sendEmail(recipient, message, subject);

                recipient = newPract.getID();
                message = "Dear " + newPract.toString() + ",\n\n" +
                        "we are glad to tell you that you have a new patient on your patient list.\n\n" +
                        "Here are the patient details:\n\n" +
                        user.toString() + "\n" +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                subject = "CentoDiciotto - New patient notification";

                // Notifies the new practitioner
                emailService.sendEmail(recipient, message, subject);

                recipient = user.getID();
                message = "Dear " + user.toString() + ",\n\n" +
                        "we inform you that your general practitioner has been successfully changed.\n\n" +
                        "Here are the practitioner details:\n\n" +
                        oldPract.toString() + "\n" +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                subject = "CentoDiciotto - Practitioner change notification";

                // Notifies the patient
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
