package it.unitn.web.centodiciotto.servlets.chemist;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ChemistDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;
import it.unitn.web.centodiciotto.utils.json.HTMLElement;
import it.unitn.web.centodiciotto.utils.json.JSONResult;
import it.unitn.web.centodiciotto.utils.json.JSONUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

/**
 * ChemistPrescriptionServlet for handling requests to /restricted/chemist/prescriptions.
 * <p>
 * GET requests are filtered if an action=qr parameter is passed to it, along with a practitionerID,
 * patientID and prescriptionID. If these three parameters match a valid prescription on the system,
 * they will be passed as request {@code Attribute}s to be handled by the JSP (by prompting the user
 * immediately with a pop-up).
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> serve: activates a prescription, setting it as sold (by setting the chemistID and dateSold flags)
 *     <li> patientSearch: select2 AJAX response generator for searching {@link Patient}s by name or SSN
 *     <li> prescriptions: select2 AJAX response generator for returing a list of {@link DrugPrescription}s from a {@link Patient}
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup showing {@link DrugPrescription} information
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/chemist/prescriptions")
public class ChemistPrescriptionServlet extends HttpServlet {

    private DrugPrescriptionDAO drugPrescriptionDAO;
    private PatientDAO patientDAO;
    private ChemistDAO chemistDAO;
    private GeneralPractitionerDAO generalPractitionerDAO;

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
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            emailService = EmailService.getInstance();
            photoService = PhotoService.getInstance();
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
        PrintWriter writer = response.getWriter();

        if (user instanceof Chemist) {
            String action = request.getParameter("action");
            request.setAttribute("action", "none");

            if (action != null && action.equals("qr")) {
                String practitionerID = null;
                String patientID = null;
                Integer prescriptionID = null;

                try {
                    practitionerID = request.getParameter("practitionerID");
                    patientID = request.getParameter("patientID");
                    prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
                } catch (NumberFormatException | NullPointerException e) {
                    response.setStatus(400);
                    String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                    writer.write(json);
                    Logger.getLogger("C18").severe(json);
                    return;
                }

                if (practitionerID != null && patientID != null) {
                    try {
                        DrugPrescription prescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                        Patient patient = patientDAO.getByPrimaryKey(patientID);
                        GeneralPractitioner practitioner = generalPractitionerDAO.getByPrimaryKey(practitionerID);

                        if (practitioner != null && patient != null && prescription != null) {
                            if (prescription.getChemistID() == null && prescription.getDateSold() == null
                                    && !prescription.getTicketPaid()) {
                                request.setAttribute("action", "qr");
                                request.setAttribute("patient", patient);
                                request.setAttribute("patientPhoto", photoService.getLastPhoto(patientID));
                                request.setAttribute("practitioner", practitioner);
                                request.setAttribute("prescription", prescription);
                            }
                        }
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                }

            }
            request.getRequestDispatcher("/jsp/chemist/prescriptions-c.jsp").forward(request, response);
        } else {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (requestType == null) {
            response.setStatus(400);
            String json = "{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
            writer.write(json);
            Logger.getLogger("C18").severe(json);
            return;
        }

        if (user instanceof Chemist) {
            switch (requestType) {
                case "serve": {
                    Integer prescriptionID;

                    try {
                        prescriptionID = Integer.valueOf(request.getParameter("prescriptionID"));
                    } catch (NumberFormatException | NullPointerException e) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    try {
                        DrugPrescription dp = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);

                        if (!dp.getTicketPaid() && dp.getChemistID() == null && dp.getDateSold() == null) {
                            dp.setDateSold(new Timestamp(System.currentTimeMillis()));
                            dp.setChemistID(user.getID());
                            drugPrescriptionDAO.update(dp);

                            Logger.getLogger("C18").info(
                                    "Succesfully activated prescription with ID " + prescriptionID);

                            Patient patient = patientDAO.getByPrimaryKey(dp.getPatientID());
                            Chemist chemist = chemistDAO.getByPrimaryKey(dp.getChemistID());
                            GeneralPractitioner practitioner =
                                    generalPractitionerDAO.getByPrimaryKey(dp.getPractitionerID());

                            String recipient = patient.getID();
                            String message = "Dear " + patient.toString() + ",\n\n" +
                                    "a drug prescription was just dispatched to you. Here are the details:\n\n" +
                                    "Drug: " + dp.getType().getDescription() + "\n" +
                                    "Prescription: " + dp.getDescription() + "\n\n" +
                                    "General practitioner: " + practitioner.toString() + "\n" +
                                    "Chemist's: " + chemist.toString() + "\n\n" +
                                    "Prescription date: " + dp.getDatePrescribed() + "\n" +
                                    "Dispatch date: " + dp.getDateSold() + "\n\n" +
                                    "\n\nYours,\nThe CentoDiciotto team.\n";
                            String subject = "CentoDiciotto - Drug disptach notification";

                            // Notifies the patient of the successful drug dispatch
                            emailService.sendEmail(recipient, message, subject);

                            writer.write("{\"patientID\": \"" + dp.getPatientID() + "\"}");
                        } else {
                            response.setStatus(400);
                            String json = "{\"error\": \"Prescription is invalid " +
                                    "or has already been activated.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                        }
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Email sending: ", e);
                    }
                    break;
                }
                case "patientSearch": {
                    try {
                        String userInput = request.getParameter("term");
                        Province province = ((Chemist) user).getProvince();

                        List<PatientSearchResult> results = new ArrayList<>();
                        List<Patient> allPatients = patientDAO.getByProvince(province.getID());
                        List<Patient> selectedPatients = new ArrayList<>();

                        if (userInput != null) {
                            allPatients.stream().filter(patient
                                    -> (patient.toString() + " " + patient.getSSN()).toLowerCase()
                                    .contains(userInput.toLowerCase()))
                                    .forEach(selectedPatients::add);
                        }

                        int id = 0;
                        for (Patient patient : selectedPatients) {
                            results.add(new PatientSearchResult(
                                    id++, patient.toString() + " - " + patient.getSSN(),
                                    patient.getID(),
                                    patient.toString(),
                                    patient.getSSN(),
                                    photoService.getLastPhoto(patient.getID())));
                        }
                        Gson gson = new Gson();
                        writer.write(gson.toJson(
                                new JSONResult<>(results.toArray(new PatientSearchResult[0]))));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                    break;
                }
                case "prescriptions": {
                    try {
                        String patientID = request.getParameter("patientID");

                        if (patientID == null) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                            return;
                        }

                        List<DrugPrescription> prescriptionList = drugPrescriptionDAO.getValidByPatient(patientID);

                        List<PrescriptionListElement> patientListElements = new ArrayList<>();
                        for (DrugPrescription prescription : prescriptionList) {
                            GeneralPractitioner practitioner =
                                    generalPractitionerDAO.getByPrimaryKey(prescription.getPractitionerID());
                            patientListElements.add(new PrescriptionListElement(
                                    practitioner.toString(),
                                    prescription.getType().getDescription(),
                                    CustomDTFormatter.formatDate(new Date(prescription.getDatePrescribed().getTime())),
                                    prescription.getID(),
                                    "Dispatch prescription"));
                        }
                        Gson gson = new Gson();
                        writer.write(gson.toJson(patientListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
                case "detailedInfo": {
                    try {
                        Integer prescriptionID = Integer.valueOf(request.getParameter("item"));

                        List<Object> jsonResponse = new ArrayList<>();

                        DrugPrescription prescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                        Patient patient = patientDAO.getByPrimaryKey(prescription.getPatientID());
                        GeneralPractitioner practitioner = generalPractitionerDAO.getByPrimaryKey(prescription.getPractitionerID());

                        jsonResponse.add(new HTMLElement().setElementType("h4").setElementClass("").setElementContent("Dispatch this prescription"));

                        jsonResponse.add(new HTMLElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));
                        jsonResponse.add(JSONUtils.createTableEntry("Patient name", patient.toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Patient SSN", patient.getSSN()));
                        jsonResponse.add(JSONUtils.createTableEntry("Practitioner name", practitioner.toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Province", patient.getLivingProvince().toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Prescription ID", prescription.getID().toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Prescription drug", prescription.getType().getDescription()));
                        jsonResponse.add(JSONUtils.createTableEntry("Description",
                                prescription.getDescription() == null ? "" : prescription.getDescription()));

                        jsonResponse.add(new HTMLElement().setElementType("form")
                                .setElementClass("serve-prescription")
                                .setElementFormAction(contextPath + "restricted/chemist/prescriptions")
                                .setElementFormMethod("POST"));

                        List<HTMLElement> form = new ArrayList<>();
                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputName("requestType")
                                .setElementInputValue("serve"));
                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputName("prescriptionID")
                                .setElementInputValue(prescriptionID.toString()));
                        form.add(new HTMLElement().setElementType("button")
                                .setElementClass("btn btn-lg btn-block btn-personal mt-2 submit-serve")
                                .setElementContent("Dispatch")
                                .setElementButtonType("submit"));
                        jsonResponse.add(form);

                        Gson gson = new Gson();

                        writer.write(gson.toJson(jsonResponse));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (NumberFormatException e) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please select a valid prescription.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }
                    break;
                }
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class PatientSearchResult implements Serializable {
        private Integer id;
        private String text;
        private String patientID;
        private String fullName;
        private String SSN;
        private String photoPath;

        /**
         * Instantiates a new Patient search result.
         *
         * @param id        the id
         * @param text      the text
         * @param patientID the patient id
         * @param fullName  the full name
         * @param SSN       the ssn
         * @param photoPath the photo path
         */
        PatientSearchResult(Integer id, String text, String patientID,
                            String fullName, String SSN, String photoPath) {
            this.id = id;
            this.text = text;
            this.patientID = patientID;
            this.fullName = fullName;
            this.SSN = SSN;
            this.photoPath = photoPath;
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class PrescriptionListElement implements Serializable {
        private String pract;
        private String drug;
        private String date;
        private HTMLAction action;
        private Integer ID;

        /**
         * Instantiates a new Prescription list element.
         *
         * @param pract  the pract
         * @param drug   the drug
         * @param date   the date
         * @param ID     the id
         * @param action the action
         */
        PrescriptionListElement(String pract, String drug, String date, Integer ID, String action) {
            this.pract = pract;
            this.drug = drug;
            this.date = date;
            this.ID = ID;
            this.action = new HTMLAction(action, true);
        }
    }
}