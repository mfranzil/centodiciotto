package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
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

/**
 * VisitServlet for handling requests to /restricted/patient/visits.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests instantiate a new pending {@link Visit} between the {@link Patient} and his/her
 * {@link it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner} with the date initially set to {@code null}.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/patient/visits")
public class VisitServlet extends HttpServlet {

    private VisitDAO visitDAO;
    private GeneralPractitionerDAO practitionerDAO;

    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
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
            request.getRequestDispatcher("/jsp/patient/visits-p.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof Patient) {
            String patientID = user.getID();
            String practitionerID = ((Patient) user).getPractitionerID();

            Visit pendingVisit = new Visit();
            pendingVisit.setPatientID(patientID);
            pendingVisit.setPractitionerID(practitionerID);
            pendingVisit.setReportAvailable(false);
            pendingVisit.setBooked(false);

            try {
                visitDAO.insert(pendingVisit);

                GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(practitionerID);

                String message = "Dear " + practitioner.toString() + ",\n\n" +
                        "one of your patients just asked for a visit. Here are the details:\n\n" +
                        "Patient: " + user.toString() +
                        "\n\nPlease visit CentoDiciotto to set a date and time for this visit." +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - Visit request notification";

                // Avviso il medico della richiesta di visita
                emailService.sendEmail(practitionerID, message, subject);

                writer.write("{}");
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ServiceException e) {
                throw new ServletException("Error in email sending: ", e);
            }
        }
    }
}
