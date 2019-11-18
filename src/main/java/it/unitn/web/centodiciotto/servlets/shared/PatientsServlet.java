package it.unitn.web.centodiciotto.servlets.shared;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
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
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * PatientsServlet for handling requests to /restricted/role/patients,
 * where role can be health_service, specialized_doctor, or general_practitioner.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> patientList: select2 AJAX response generator for returning a list of available {@link Patient}s
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup to show detailed information
 *                        about a Patient, such as personal information, {@link Visit}s, {@link Exam}s and
 *                        {@link DrugPrescription}s
 *     <li> patientSearch: select2 AJAX response generator for returning a list of available {@link Patient}s
 *                         to choose from a dropdown, from a query
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet(urlPatterns = {"/restricted/general_practitioner/patients",
        "/restricted/health_service/patients",
        "/restricted/specialized_doctor/patients"})
public class PatientsServlet extends HttpServlet {

    private PatientDAO patientDAO;
    private GeneralPractitionerDAO practitionerDAO;
    private VisitDAO visitDAO;
    private ExamDAO examDAO;
    private DrugPrescriptionDAO drugPrescriptionDAO;

    private PhotoService photoService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            photoService = PhotoService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner || user instanceof HealthService || user instanceof SpecializedDoctor) {
            request.getRequestDispatcher("/jsp/shared/patients-gp-hs-sd.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");

        if (user instanceof GeneralPractitioner || user instanceof HealthService || user instanceof SpecializedDoctor) {
            switch (requestType) {
                case "patientList": {
                    try {
                        String patientID = request.getParameter("patientID");

                        List<Patient> patientList = new ArrayList<>();

                        if (patientID == null) {
                            if (user instanceof GeneralPractitioner) {
                                patientList = patientDAO.getByPractitioner(user.getID());
                            } else if (user instanceof HealthService) {
                                patientList = patientDAO.getByProvince(((HealthService) user).getOperatingProvince().getAbbreviation());
                            } else { // SpecializedDoctor
                                patientList = patientDAO.getAll();
                            }
                        } else {
                            patientList.add(patientDAO.getByPrimaryKey(patientID));
                        }

                        List<PatientListElement> patientListElements = new ArrayList<>();
                        for (Patient patient : patientList) {
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            patientListElements.add(new PatientListElement(patient.toString(), patient.getSSN(), photoPath, patient.getID(), new Action("Patient Data", true)));
                        }

                        Gson gson = new Gson();

                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(patientListElements));

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                    break;
                }
                case "detailedInfo": {
                    String patientID = request.getParameter("item");

                    List<Object> jsonResponse = new ArrayList<>();

                    try {
                        Patient patient = patientDAO.getByPrimaryKey(patientID);
                        GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(patient.getPractitionerID());

                        // Patient data
                        jsonResponse.add(new HTMLElement().setElementType("h4").setElementClass("").setElementContent("Patient data"));
                        jsonResponse.add(new HTMLElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));

                        jsonResponse.add(JSONUtils.createTableEntry("Name", patient.getFirstName()));
                        jsonResponse.add(JSONUtils.createTableEntry("Surname", patient.getLastName()));
                        jsonResponse.add(JSONUtils.createTableEntry("SSN", patient.getSSN()));
                        jsonResponse.add(JSONUtils.createTableEntry("Birthdate", patient.getBirthDate().toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Gender", patient.getGender().toString()));
                        jsonResponse.add(JSONUtils.createTableEntry("Province", patient.getLivingProvince().getName()));
                        jsonResponse.add(JSONUtils.createTableEntry("Practitioner", practitioner.toString()));

                        // Last visit
                        Visit lastVisit = visitDAO.getLastByPatient(patientID);
                        if (lastVisit != null) {
                            GeneralPractitioner visitPractitioner = practitionerDAO.getByPrimaryKey(lastVisit.getPractitionerID());

                            jsonResponse.add(new HTMLElement().setElementType("h4").setElementClass("").setElementContent("Last visit"));
                            jsonResponse.add(new HTMLElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));

                            jsonResponse.add(JSONUtils.createTableEntry("Date", lastVisit.getDate().toString()));
                            jsonResponse.add(JSONUtils.createTableEntry("Practitioner", visitPractitioner.toString()));
                            jsonResponse.add(JSONUtils.createTableEntry("Report", lastVisit.getReport()));
                        }
                        // Last exam
                        List<Exam> examPatientList = examDAO.getByPatientLastYear(patientID);
                        if (!examPatientList.isEmpty()) {
                            jsonResponse.add(new HTMLElement().setElementType("h4").setElementClass("").setElementContent("Last exams"));
                            jsonResponse.add(new HTMLElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));

                            for (Exam exam : examPatientList) {
                                jsonResponse.add(JSONUtils.createTableEntry("Date", exam.getDate().toString()));
                                jsonResponse.add(JSONUtils.createTableEntry("Description", exam.getType().getDescription()));
                                if (exam.getResult() != null) {
                                    jsonResponse.add(JSONUtils.createTableEntry("Result", exam.getResult()));
                                }
                                jsonResponse.add(JSONUtils.createTableEntry("", ""));
                            }
                        }

                        // Medicinali
                        List<DrugPrescription> prescriptions = drugPrescriptionDAO.getValidByPatient(patientID);
                        if (!examPatientList.isEmpty()) {
                            jsonResponse.add(new HTMLElement().setElementType("h4").setElementClass("").setElementContent("Last prescriptions"));
                            jsonResponse.add(new HTMLElement().setElementType("table").setElementClass("table table-unresponsive").setElementContent(""));

                            for (DrugPrescription prescription : prescriptions) {
                                jsonResponse.add(JSONUtils.createTableEntry("Prescription date",
                                        prescription.getDatePrescribed().toString()));
                                jsonResponse.add(JSONUtils.createTableEntry("Drug description",
                                        prescription.getDrugType().getDescription()));
                                if (prescription.getDescription() != null) {
                                    jsonResponse.add(JSONUtils.createTableEntry("Description",
                                            prescription.getDescription()));
                                }
                                jsonResponse.add(JSONUtils.createTableEntry("", ""));
                            }
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(jsonResponse));
                    } catch (DAOException e) {
                        throw new ServletException("Error while getting patient detail in PatientListServlet", e);
                    }
                    break;
                }
                case "patientSearch": {
                    try {
                        String userInput = request.getParameter("term");

                        List<Patient> allPatients;
                        if (user instanceof GeneralPractitioner) {
                            allPatients = patientDAO.getByPractitioner(user.getID());
                        } else if (user instanceof HealthService) {
                            allPatients = patientDAO.getByProvince(((HealthService) user).getOperatingProvince().getAbbreviation());
                        } else { // SpecializedDoctor
                            allPatients = patientDAO.getAll();
                        }

                        List<PatientSearchResult> results = new ArrayList<>();

                        int id = 0;
                        for (Patient patient : allPatients) {
                            results.add(new PatientSearchResult(
                                    id++,
                                    patient.toString(),
                                    patient.getID()));
                        }

                        if (userInput != null) {
                            results = results.stream().filter(patientSearchResult
                                    -> (patientSearchResult.getText().toLowerCase().contains(
                                    userInput.toLowerCase()))).collect(Collectors.toList());
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(
                                new JSONResults<>(results.toArray(new PatientSearchResult[0]))));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class PatientListElement implements Serializable {
        private String name;
        private String ssn;
        private String avt;
        private Action action;
        private String ID;

        /**
         * Instantiates a new Patient list element.
         *
         * @param name   the name
         * @param ssn    the ssn
         * @param avt    the avt
         * @param ID     the id
         * @param action the action
         */
        public PatientListElement(String name, String ssn, String avt, String ID, Action action) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.ID = ID;
            this.action = action;
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class PatientSearchResult implements Serializable {
        private Integer id;
        private String text;
        private String patientID;

        /**
         * Instantiates a new Patient search result.
         *
         * @param id        the id
         * @param text      the text
         * @param patientID the patient id
         */
        public PatientSearchResult(Integer id, String text, String patientID) {
            this.id = id;
            this.text = text;
            this.patientID = patientID;
        }

        /**
         * Gets text.
         *
         * @return the text
         */
        public String getText() {
            return text;
        }
    }
}
