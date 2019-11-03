package it.unitn.web.centodiciotto.servlets.chemist;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
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
        String ajax_type = request.getParameter("request_type");

        switch (ajax_type) {
            case "patient_search": {
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

                    List<DrugPrescription> prescriptionList = drugPrescriptionDAO.getByPatient(patientID);

                    List<PrescriptionListElement> patientListElements = new ArrayList<>();
                    for (DrugPrescription prescription : prescriptionList) {
                        GeneralPractitioner generalPractitioner = generalPractitionerDAO.getByPrimaryKey(prescription.getPractitionerID());
                        patientListElements.add(new PrescriptionListElement(
                                generalPractitioner.getFirstName() + " " + generalPractitioner.getLastName(),
                                new Date(prescription.getDatePrescripted().getTime()),
                                "Serve prescription"));
                    }

                    Gson gson = new Gson();

                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(patientListElements));

                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage", e);
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
        private Date date;
        private String action;

        public PrescriptionListElement(String pract, Date date, String action) {
            this.pract = pract;
            this.date = date;
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


