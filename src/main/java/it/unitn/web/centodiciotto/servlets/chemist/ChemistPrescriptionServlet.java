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
import it.unitn.web.centodiciotto.utils.JSONUtils;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.Action;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.JSONResults;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;


/**
 * The type Chemist prescription servlet.
 */
@WebServlet("/restricted/chemist/prescriptions")
public class ChemistPrescriptionServlet extends HttpServlet {

    private DrugPrescriptionDAO drugPrescriptionDAO;
    private PatientDAO patientDAO;
    private ChemistDAO chemistDAO;
    private GeneralPractitionerDAO generalPractitionerDAO;

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
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Chemist) {
            String action = request.getParameter("action");
            request.setAttribute("action", "none");

            if (action != null && action.equals("qr")) {
                try {
                    String practitionerID = request.getParameter("practitionerID");
                    String patientID = request.getParameter("patientID");
                    Integer prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));

                    DrugPrescription prescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                    Patient patient = patientDAO.getByPrimaryKey(patientID);
                    GeneralPractitioner practitioner = generalPractitionerDAO.getByPrimaryKey(practitionerID);

                    PhotoService photoService = PhotoService.getInstance();

                    if (practitioner != null && patient != null && prescription != null) {
                        if (prescription.getChemistID() == null
                                && prescription.getDateSold() == null
                                && !prescription.getTicketPaid()) {

                            request.setAttribute("action", "qr");
                            request.setAttribute("patient", patient);
                            request.setAttribute("patientPhoto", photoService.getLastPhoto(patientID));
                            request.setAttribute("practitioner", practitioner);
                            request.setAttribute("prescription", prescription);
                        }
                    }
                } catch (DAOException | NullPointerException | NumberFormatException e) {
                    throw new ServletException("Malformed request (error in DAO or parameters): ", e);
                } catch (ServiceException e) {
                    throw new ServletException("Error in Photo path retrieval: ", e);
                }
            }
            request.getRequestDispatcher("/jsp/chemist/prescriptions-c.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String ajax_type = request.getParameter("requestType");

        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        PhotoService photoService;
        EmailService emailService;

        try {
            photoService = PhotoService.getInstance();
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in EmailService or PhotoService retrieval: ", e);
        }

        switch (ajax_type) {
            case "serve": {
                if (user instanceof Chemist) {
                    Integer prescriptionID = Integer.valueOf(request.getParameter("prescriptionID"));

                    try {
                        DrugPrescription dp = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);

                        if (!dp.getTicketPaid() && dp.getChemistID() == null && dp.getDateSold() == null) {
                            dp.setDateSold(new Timestamp(System.currentTimeMillis()));
                            dp.setChemistID(user.getID());
                            drugPrescriptionDAO.update(dp);

                            Logger.getGlobal().log(Level.INFO,
                                    "Succesfully activated prescription with ID " + prescriptionID);

                            Patient patient = patientDAO.getByPrimaryKey(dp.getPatientID());
                            Chemist chemist = chemistDAO.getByPrimaryKey(dp.getChemistID());
                            GeneralPractitioner practitioner =
                                    generalPractitionerDAO.getByPrimaryKey(dp.getPractitionerID());

                            String recipient = patient.getID();
                            String message = "Dear " + patient.toString() + ",\n\n" +
                                    "a drug prescription was just dispatched to you. Here are the details:\n" +
                                    "\n" +
                                    "Drug: " + dp.getDrugType().getDescription() + "\n" +
                                    "Prescription: " + dp.getDescription() + "\n" +
                                    "\n" +
                                    "General practitioner: " + practitioner.toString() + "\n" +
                                    "Chemist's: " + chemist.toString() + "\n" +
                                    "\n" +
                                    "Prescription date: " + dp.getDatePrescribed() + "\n" +
                                    "Dispatch date: " + dp.getDateSold() + "\n\n" +
                                    "\n\nYours,\nThe CentoDiciotto team.\n";
                            String subject = "CentoDiciotto - Patient change notification";

                            // Avviso il paziente dell'avvenuta ricezione del farmaco
                            emailService.sendEmail(recipient, message, subject);

                            response.setStatus(200);
                            response.getWriter().write("{\"patientID\": \"" + dp.getPatientID() + "\"}");
                        } else {
                            response.setStatus(400);
                            response.getWriter().write("{\"patientID\": \"\"}");
                        }

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Email sending: ", e);
                    }
                }
            }
            break;
            case "patientSearch": {
                if (user instanceof Chemist) {
                    try {
                        String userInput = request.getParameter("term");
                        Province province = ((Chemist) user).getProvince();

                        List<PatientSearchResult> results = new ArrayList<>();
                        List<Patient> allPatients = patientDAO.getByProvince(province.getAbbreviation());

                        if (userInput != null) {
                            allPatients = allPatients.stream().filter(patient
                                    -> (patient.toString() + patient.getSSN()).toLowerCase()
                                    .contains(userInput.toLowerCase()))
                                    .collect(Collectors.toList());
                        }

                        int id = 0;
                        for (Patient patient : allPatients) {
                            results.add(new PatientSearchResult(
                                    id++, patient.toString() + " - " + patient.getSSN(),
                                    patient.getID(),
                                    patient.toString(),
                                    patient.getSSN(),
                                    photoService.getLastPhoto(patient.getID())));
                        }
                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(
                                new JSONResults<>(results.toArray(new PatientSearchResult[0]))));

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                }
            }
            break;
            case "prescriptions": {
                if (user instanceof Chemist) {
                    try {
                        String patientID = request.getParameter("patientID");

                        List<DrugPrescription> prescriptionList = drugPrescriptionDAO.getValidByPatient(patientID);

                        List<PrescriptionListElement> patientListElements = new ArrayList<>();
                        for (DrugPrescription prescription : prescriptionList) {
                            GeneralPractitioner practitioner =
                                    generalPractitionerDAO.getByPrimaryKey(prescription.getPractitionerID());
                            patientListElements.add(new PrescriptionListElement(
                                    practitioner.toString(),
                                    prescription.getDrugType().getDescription(),
                                    CustomDTFormatter.formatDate(new Date(prescription.getDatePrescribed().getTime())),
                                    prescription.getID(),
                                    "Dispatch prescription"));
                        }
                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(patientListElements));

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                }
            }
            break;
            case "detailedInfo": {
                if (user instanceof Chemist) {
                    Integer prescriptionID = Integer.valueOf(request.getParameter("item"));
                    List<Object> jsonResponse = new ArrayList<>();

                    try {
                        DrugPrescription prescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                        Patient patient = patientDAO.getByPrimaryKey(prescription.getPatientID());
                        GeneralPractitioner practitioner = generalPractitionerDAO.getByPrimaryKey(prescription.getPractitionerID());

                        jsonResponse.add(new HTMLElement().setElementType("h4").setElementClass("").setElementContent("Dispatch this prescription"));

                        jsonResponse.add(new HTMLElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));
                        jsonResponse.add(JSONUtils.createTableEntry("Patient name", patient.toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Patient SSN", patient.getSSN()));
                        jsonResponse.add(JSONUtils.createTableEntry("Practitioner name", practitioner.toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Province", patient.getLivingProvince().getName()));
                        jsonResponse.add(JSONUtils.createTableEntry("Prescription ID", prescription.getID().toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Prescription drug", prescription.getDrugType().getDescription()));
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
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(jsonResponse));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                }
            }
            break;
        }
    }

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

    private static class PrescriptionListElement implements Serializable {
        private String pract;
        private String drug;
        private String date;
        private Action action;
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
            this.action = new Action(action, true);
        }
    }
}


