package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
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
import java.util.logging.Logger;

/**
 * ExamCalendarServlet for handling requests to /restricted/role/visit_calendar,
 * where role can be health_service or specialized_doctor.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests get a {@code examID} and set its result to available, therefore ending its pending status.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet(urlPatterns = {"/restricted/specialized_doctor/exam_calendar", "/restricted/health_service/exam_calendar"})
public class ExamCalendarServlet extends HttpServlet {

    private PatientDAO patientDAO;
    private ExamDAO examDAO;

    private EmailService emailService;

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
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            request.getRequestDispatcher("/jsp/shared/exam_calendar-hs-sd.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            int examID;

            try {
                examID = Integer.parseInt(request.getParameter("examID"));
            } catch (NumberFormatException e) {
                response.setStatus(400);
                String json = "{\"error\": \"Malformed input. Please try again.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            try {
                Exam exam = examDAO.getByPrimaryKey(examID);
                exam.setDone(true);
                examDAO.update(exam);

                Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                String handler = user instanceof SpecializedDoctor ? "Specialized Doctor" : "Local Health Service";

                String recipient = patient.getID();
                String message = "Dear " + patient + ",\n\n" +
                        "your exam with your " + handler + " was just completed.\n\n" +
                        "Here are the exam details:\n\n" +
                        "Exam: " + exam.getType().getDescription() + "\n" +
                        "Exam handler: " + user + "\n" +
                        "Date: " + CustomDTFormatter.formatDate(exam.getDate()) +
                        "\n\nYou will receieve an additional notification once" +
                        " your " + handler + " inserts a result." +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - Exam completion notification";

                // Notifies the patient about the exam completion
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
