package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * TicketServlet for handling requests to /restricted/patient/tickets.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests set a ticket as paid and are filtered depending on the {@code type} parameter, as the ticket may
 * be from an {@link Exam} or from a {@link DrugPrescription}.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/patient/tickets")
public class TicketServlet extends HttpServlet {

    private ExamDAO examDAO;
    private DrugPrescriptionDAO drugPrescriptionDAO;

    private EmailService emailService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }

        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
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
            request.getRequestDispatcher("/jsp/patient/tickets-p.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof Patient) {
            String type = request.getParameter("type");
            Integer ID = Integer.valueOf(request.getParameter("ID"));
            if (type.equals("exam")) {
                try {
                    Exam selectedExam = examDAO.getByPrimaryKey(ID);

                    if (selectedExam.getTicketPaid()) {
                        response.setStatus(400);
                        writer.write("{\"error\": \"Selected exam has already been paid.\"}");
                    } else {
                        selectedExam.setTicketPaid(true);
                        examDAO.update(selectedExam);

                        String recipient = user.getID();
                        String message = "Dear " + user.toString() + ",\n\n" +
                                "we are glad to inform your that the ticket payment for the " +
                                "following exam has been accepted:\n\n" +
                                "Exam: " + selectedExam.getType().getDescription() +
                                "Date: " + CustomDTFormatter.formatDate(selectedExam.getDate()) +
                                "\n\nYours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - Ticket payment notification";

                        // Avviso il paziente dell'avvenuto pagamento
                        emailService.sendEmail(recipient, message, subject);

                        writer.write("{}");
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                } catch (ServiceException e) {
                    throw new ServletException("Error in email sending: ", e);
                }
            } else if (type.equals("drug")) {
                try {
                    DrugPrescription selectedPrescription = drugPrescriptionDAO.getByPrimaryKey(ID);

                    if (selectedPrescription.getTicketPaid()) {
                        response.setStatus(400);
                        writer.write("{\"error\": \"Selected prescription has already been paid.\"}");
                    } else {
                        selectedPrescription.setTicketPaid(true);
                        drugPrescriptionDAO.update(selectedPrescription);

                        String recipient = user.getID();
                        String message = "Dear " + user.toString() + ",\n\n" +
                                "we are glad to inform your that the ticket payment for the " +
                                "following drug prescription has been accepted:\n\n" +
                                "Drug: " + selectedPrescription.getType().getDescription() +
                                "Date: " + CustomDTFormatter.formatDate(selectedPrescription.getDateSold()) +
                                "\n\nYours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - Ticket payment notification";

                        // Avviso il paziente dell'avvenuto pagamento
                        emailService.sendEmail(recipient, message, subject);

                        writer.write("{}");
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                } catch (ServiceException e) {
                    throw new ServletException("Error in email sending: ", e);
                }
            } else {
                response.setStatus(400);
                writer.write("{\"error\": \"Malformed input. Only drug prescriptions and exams can be paid.\"}");
            }
        }
    }
}
