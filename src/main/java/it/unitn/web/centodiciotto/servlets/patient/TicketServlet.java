package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.*;
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
import it.unitn.web.centodiciotto.utils.DrugPrescriptionState;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> ticketPay: sets a ticket as paid and are filtered depending on the {@code type} parameter,
 *     as the ticket may be from an {@link Exam} or from a {@link DrugPrescription}.
 *     <li> examTicketList: AJAX response generator for returning a list of {@link Exam}s
 *     <li> prescriptionTicketList: AJAX response generator for returning a list of {@link DrugPrescription}s
 * </ul>
 * POST requests
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/patient/tickets")
public class TicketServlet extends HttpServlet {

    private ExamDAO examDAO;
    private HealthServiceDAO healthServiceDAO;
    private SpecializedDoctorDAO specializedDoctorDAO;
    private DrugPrescriptionDAO drugPrescriptionDAO;
    private ChemistDAO chemistDAO;

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
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
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

        if (user instanceof Patient) {
            switch (requestType) {
                case "ticketPay" -> {
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
                                String message = "Dear " + user + ",\n\n" +
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
                                String message = "Dear " + user + ",\n\n" +
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

                    break;
                }
                case "examTicketList" -> {
                    try {
                        List<ExamTicketListElement> examTicketListElements = new ArrayList<>();

                        List<Exam> examList = examDAO.getDoneByPatient(user.getID());
                        for (Exam exam : examList) {
                            if (exam.getHealthServiceID() != null) {

                                HTMLAction button;
                                if (exam.getTicketPaid()) {
                                    button = new HTMLAction("Paid", false);
                                } else if (exam.getTicket() == 0) {
                                    button = new HTMLAction("Free", false);
                                } else {
                                    button = new HTMLAction("Pay", true);
                                }
                                examTicketListElements.add(new ExamTicketListElement(
                                        healthServiceDAO.getByPrimaryKey(exam.getHealthServiceID()).toString(),
                                        exam.getType().getDescription(),
                                        CustomDTFormatter.formatDate(exam.getDate()),
                                        "$" + exam.getTicket(),
                                        button,
                                        "e" + exam.getID()));
                            } else {
                                HTMLAction button;
                                if (exam.getTicketPaid()) {
                                    button = new HTMLAction("Paid", false);
                                } else if (exam.getTicket() == 0) {
                                    button = new HTMLAction("Free", false);
                                } else {
                                    button = new HTMLAction("Pay", true);
                                }
                                examTicketListElements.add(new ExamTicketListElement(
                                        specializedDoctorDAO.getByPrimaryKey(exam.getDoctorID()).toString(),
                                        exam.getType().getDescription(),
                                        CustomDTFormatter.formatDate(exam.getDate()),
                                        "$" + exam.getTicket(),
                                        button,
                                        "e" + exam.getID()));
                            }
                        }
                        Gson gson = new Gson();
                        writer.write(gson.toJson(examTicketListElements));
                    } catch (DAOException e) {
                        e.printStackTrace();
                    }
                    break;
                }
                case "prescriptionTicketList" -> {
                    try {
                        List<PrescriptionTicketListElement> prescriptionTicketListElements = new ArrayList<>();

                        List<DrugPrescription> drugPrescriptionList = drugPrescriptionDAO.getByPatient(user.getID());
                        for (DrugPrescription drugPrescription : drugPrescriptionList) {
                            DrugPrescriptionState state = DrugPrescriptionState.getState(drugPrescription);
                            if (state == DrugPrescriptionState.UNPAID || state == DrugPrescriptionState.PAID) {
                                HTMLAction button;
                                if (drugPrescription.getTicketPaid()) {
                                    button = new HTMLAction("Paid", false);
                                } else {
                                    button = new HTMLAction("Pay", true);
                                }

                                prescriptionTicketListElements.add(new PrescriptionTicketListElement(
                                        chemistDAO.getByPrimaryKey(drugPrescription.getChemistID()).toString(),
                                        drugPrescription.getType().getDescription(),
                                        CustomDTFormatter.formatDate(drugPrescription.getDatePrescribed()),
                                        CustomDTFormatter.formatDate(drugPrescription.getDateSold()),
                                        "$" + drugPrescription.getTicket(),
                                        button,
                                        "p" + drugPrescription.getID()));
                            }
                        }
                        Gson gson = new Gson();
                        writer.write(gson.toJson(prescriptionTicketListElements));
                    } catch (DAOException e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class ExamTicketListElement implements Serializable {
        private final String doctor;
        private final String exam;
        private final String date;
        private final String amount;
        private final HTMLAction action;
        private final String ID;

        /**
         * Instantiates a new Exam ticket list element.
         *
         * @param doctor the doctor
         * @param exam   the exam
         * @param date   the date
         * @param amount the amount
         * @param action the action
         * @param ID     the id
         */
        public ExamTicketListElement(String doctor, String exam, String date, String amount,
                                     HTMLAction action, String ID) {
            this.doctor = doctor;
            this.exam = exam;
            this.date = date;
            this.amount = amount;
            this.action = action;
            this.ID = ID;
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class PrescriptionTicketListElement implements Serializable {
        private final String chemist;
        private final String drug;
        private final String prescription;
        private final String sale;
        private final String amount;
        private final HTMLAction action;
        private final String ID;

        /**
         * Instantiates a new Prescription ticket list element.
         *
         * @param chemist      the chemist
         * @param drug         the drug
         * @param prescription the prescription
         * @param sale         the sale
         * @param amount       the amount
         * @param action       the action
         * @param ID           the id
         */
        public PrescriptionTicketListElement(String chemist, String drug, String prescription,
                                             String sale, String amount, HTMLAction action, String ID) {
            this.chemist = chemist;
            this.drug = drug;
            this.prescription = prescription;
            this.sale = sale;
            this.amount = amount;
            this.action = action;
            this.ID = ID;
        }
    }

}
