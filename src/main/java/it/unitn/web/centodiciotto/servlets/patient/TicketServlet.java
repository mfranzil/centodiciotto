package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.HealthServiceDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.servlets.shared.PatientListServlet;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;

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
    private HealthServiceDAO healthServiceDAO;
    private SpecializedDoctorDAO specializedDoctorDAO;
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
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
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
        String requestType = request.getParameter("requestType");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        switch (requestType) {
            case "ticketPay": {
                if (user instanceof Patient) {
                    String type = request.getParameter("type");
                    Integer ID = Integer.valueOf(request.getParameter("ID"));
                    if (type.equals("exam")) {
                        try {
                            Exam selectedExam = examDAO.getByPrimaryKey(ID);

                            if (selectedExam.getTicketPaid()) {
                                response.setStatus(400);
                                String json = "{\"error\": \"Selected exam has already been paid.\"}";
                                writer.write(json);
                                Logger.getLogger("C18").severe(json);
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

                                // Notifies the patient of the successful payment
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
                                String json = "{\"error\": \"Selected prescription has already been paid.\"}";
                                writer.write(json);
                                Logger.getLogger("C18").severe(json);

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

                                // Notifies the patient of the successful payment
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
                        String json = "{\"error\": \"Malformed input. Only drug prescriptions and exams can be paid.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                    }

                }
                break;
            }
            case "examTicketList": {
                System.out.println("Im here");
                if (user instanceof Patient) {
                    try {
                        List<ExamTicketListElement> examTicketListElements = new ArrayList<>();

                        List<Exam> examList = examDAO.getNotPendingByPatient(user.getID());
                        for (Exam exam : examList) {
                            if (exam.getHealthServiceID() != null) {
                                HTMLAction button;
                                if (exam.getTicketPaid()) {
                                    button = new HTMLAction("Paid", false);
                                } else {
                                    button = new HTMLAction("Pay", true);
                                }
                                examTicketListElements.add(new ExamTicketListElement(healthServiceDAO.getByPrimaryKey(exam.getHealthServiceID()).toString(), exam.getType().getDescription(), exam.getDate().toString(), "$" + exam.getTicket(), button, "e"+ exam.getID()));
                            } else {
                                HTMLAction button;
                                if (exam.getTicketPaid()) {
                                    button = new HTMLAction("Paid", false);
                                } else {
                                    button = new HTMLAction("Pay", true);
                                }
                                examTicketListElements.add(new ExamTicketListElement(specializedDoctorDAO.getByPrimaryKey(exam.getDoctorID()).toString(), exam.getType().getDescription(), exam.getDate().toString(), "$" + exam.getTicket(), button, "e"+ exam.getID()));
                            }
                        }
                        Gson gson = new Gson();
                        writer.write(gson.toJson(examTicketListElements));
                    } catch(DAOException e){
                        e.printStackTrace();
                    }


            }
            break;
        }
    }
}

/**
 * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
 */
private static class ExamTicketListElement implements Serializable {
    private String doctor;
    private String exam;
    private String date;
    private String amount;
    private HTMLAction action;
    private String ID;

    /**
     * Instantiates a new Exam list element.
     *
     * @param doctor the doctor
     * @param exam   the exam
     * @param date   the date
     * @param amount the amount
     * @param ID     the id
     * @param action the action
     */
    public ExamTicketListElement(String doctor, String exam, String date, String amount, HTMLAction action, String ID) {
        this.doctor = doctor;
        this.exam = exam;
        this.date = date;
        this.amount = amount;
        this.action = action;
        this.ID = ID;
    }
}
}
