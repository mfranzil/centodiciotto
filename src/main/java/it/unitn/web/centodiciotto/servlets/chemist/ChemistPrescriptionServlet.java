package it.unitn.web.centodiciotto.servlets.chemist;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.HtmlElement;
import it.unitn.web.utils.JsonUtils;
import it.unitn.web.utils.PhotoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/restricted/chemist/prescriptions")
public class ChemistPrescriptionServlet extends HttpServlet {

    private DrugPrescriptionDAO drugPrescriptionDAO;
    private PatientDAO patientDAO;
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
            if (action != null && action.equals("qr")) {
                String practitionerID = request.getParameter("practitionerID");
                int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
                String patientID = request.getParameter("patientID");

                try {
                    DrugPrescription drugPrescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                    if (drugPrescription.getChemistID() == null
                            && drugPrescription.getDateSold() == null
                            && !drugPrescription.getTicketPaid()) {
                        System.out.println("prescrizione ancora valida, carico ");
                    }

                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
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

        switch (ajax_type) {
            case "serve": {
                System.out.println("WOW ce l'hai fatta");
            }
            case "patientSearch": {
                if (user instanceof Chemist) {
                    try {
                        String userInput = request.getParameter("term");

                        List<Patient> query = patientDAO.getPatientsBySSNOrPartialName(userInput);
                        List<PatientSearchResult> results = new ArrayList<>();

                        int id = 0;
                        for (Patient patient : query) {
                            if (patient.getLivingProvince().getID().equals(((Chemist) user).getProvince().getID())) {
                                results.add(new PatientSearchResult(
                                        id++,
                                        patient.getFirstName() + " " + patient.getLastName() + " - " + patient.getSSN(),
                                        patient.getID(),
                                        patient.getFirstName() + " " + patient.getLastName(),
                                        patient.getSSN(),
                                        PhotoService.getLastPhoto(patient.getID())));
                            }
                        }
                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(
                                new Results(results.toArray(new PatientSearchResult[0]))));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                }
            }
            break;
            case "prescriptions": {
                try {
                    String patientID = request.getParameter("patientID");

                    List<DrugPrescription> prescriptionList = drugPrescriptionDAO.getValidByPatient(patientID);

                    List<PrescriptionListElement> patientListElements = new ArrayList<>();
                    for (DrugPrescription prescription : prescriptionList) {
                        GeneralPractitioner generalPractitioner =
                                generalPractitionerDAO.getByPrimaryKey(prescription.getPractitionerID());
                        patientListElements.add(new PrescriptionListElement(
                                generalPractitioner.getFirstName() + " " + generalPractitioner.getLastName(),
                                prescription.getDrugType().getDescription(),
                                new Date(prescription.getDatePrescripted().getTime()),
                                prescription.getID(),
                                "Serve prescription"));
                    }

                    Gson gson = new Gson();

                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(patientListElements));

                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
            }
            break;
            case "detailedInfo": {
                Integer prescriptionID = Integer.valueOf(request.getParameter("item"));

                List<Object> jsonResponse = new ArrayList<>();

                try {
                    DrugPrescription drugPrescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                    Patient patient = patientDAO.getByPrimaryKey(drugPrescription.getPatientID());
                    GeneralPractitioner practitioner = generalPractitionerDAO.getByPrimaryKey(drugPrescription.getPractitionerID());

                    jsonResponse.add(new HtmlElement().setElementType("h4").setElementClass("").setElementContent("Serve this prescription"));

                    jsonResponse.add(new HtmlElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));
                    jsonResponse.add(JsonUtils.createTableEntry("Patient name", patient.getFirstName() + " " + patient.getLastName()));
                    jsonResponse.add(JsonUtils.createTableEntry("Patient SSN", patient.getSSN()));
                    jsonResponse.add(JsonUtils.createTableEntry("Practitioner name", practitioner.getFirstName() + " " + practitioner.getLastName()));
                    jsonResponse.add(JsonUtils.createTableEntry("Province", patient.getLivingProvince().getName()));
                    jsonResponse.add(JsonUtils.createTableEntry("Prescription ID", drugPrescription.getID().toString()));
                    jsonResponse.add(JsonUtils.createTableEntry("Prescription drug", drugPrescription.getDrugType().getDescription()));
                    jsonResponse.add(JsonUtils.createTableEntry("Description",
                            drugPrescription.getDescription() == null ? "" : drugPrescription.getDescription()));

                    jsonResponse.add(new HtmlElement().setElementType("form")
                            .setElementFormAction(contextPath + "restricted/chemist/prescriptions")
                            .setElementID("serve-prescription")
                            .setElementFormMethod("POST"));

                    List<HtmlElement> form = new ArrayList<>();
                    form.add(new HtmlElement().setElementType("input")
                            .setElementInputType("hidden")
                            .setElementInputName("requestType")
                            .setElementInputValue("serve"));
                    form.add(new HtmlElement().setElementType("input")
                            .setElementInputType("hidden")
                            .setElementInputName("prescriptionID")
                            .setElementInputValue(prescriptionID.toString()));
                    form.add(new HtmlElement().setElementType("button")
                            .setElementClass("btn btn-lg btn-block btn-personal")
                            .setElementContent("Serve")
                            .setElementButtonType("submit"));
                    jsonResponse.add(form);

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(jsonResponse));
                } catch (DAOException e) {
                    throw new ServletException("Error while getting patient detail in PatientListServlet", e);
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

        public PatientSearchResult(Integer id, String text, String patientID,
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
        private Date date;
        private String action;
        private Integer ID;

        public PrescriptionListElement(String pract, String drug, Date date, Integer ID, String action) {
            this.pract = pract;
            this.drug = drug;
            this.date = date;
            this.ID = ID;
            this.action = action;
        }
    }

    private static class Results implements Serializable {
        private PatientSearchResult[] results;

        public Results(PatientSearchResult[] results) {
            this.results = results;
        }
    }
}


