package it.unitn.web.centodiciotto.servlets.shared;

import com.google.gson.Gson;
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
import java.util.List;

@WebServlet(urlPatterns = {"/restricted/general_practitioner/patients",
        "/restricted/health_service/patients",
        "/restricted/specialized_doctor/patients"})
public class PatientsServlet extends HttpServlet {

    private PatientDAO patientDAO;
    private GeneralPractitionerDAO practitionerDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner || user instanceof HealthService || user instanceof Chemist) {
            request.getRequestDispatcher("/jsp/shared/patients-gp-hs-sd.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        String ajax_type = (String) request.getParameter("request_type");

        switch (ajax_type) {
            case "patient_list": {
                if (user instanceof GeneralPractitioner) {
                    try {

                        List<Patient> patientList = patientDAO.getPatientsByPractitionerID(user.getID());

                        List<PatientListElement> patientListElements = new ArrayList<>();
                        for (Patient patient : patientList) {
                            String photoPath = PhotoService.getLastPhoto(patient.getID());

                            patientListElements.add(new PatientListElement(patient.getFirstName() + " " + patient.getLastName(), patient.getSSN(), photoPath, patient.getID(), "Patient Data"));
                        }

                        Gson gson = new Gson();

                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(patientListElements));

                    } catch (DAOException ex) {
                        throw new ServletException("Error while getting patients by practitionerID in PatientListServlet", ex);
                    }
                }
                break;
            }
            case "detailed_info": {
                String patientID = (String) request.getParameter("patient");

                try {
                    Patient patient = patientDAO.getByPrimaryKey(patientID);
                    GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(patient.getPractitionerID());

                    System.out.println(patientID + " " + practitioner.getID());
                    Gson gson = new Gson();

                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new PatientDetails(patient.getFirstName(), patient.getLastName(), patient.getSSN(), patient.getBirthDate().toString(), patient.getGender().toString(), patient.getLivingProvince().getName(), practitioner.getFirstName() + " " + practitioner.getLastName())));
                } catch (DAOException e) {
                    throw new ServletException("Error while getting patient detail in PatientListServlet", e);
                }
                break;
            }
            default: {
            }
            ;
        }

    }

    private static class PatientListElement {
        private String name;
        private String ssn;
        private String avt;
        private String action;
        private String ID;

        public PatientListElement(String name, String ssn, String avt, String ID, String action) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.ID = ID;
            this.action = action;
        }
    }

    private static class PatientDetails {
        private String firstName;
        private String lastName;
        private String ssn;
        private String birthDate;
        private String gender;
        private String province;
        private String practitionerName;

        public PatientDetails(String firstName, String lastName, String ssn, String birthDate, String gender, String province, String practitionerName) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.ssn = ssn;
            this.birthDate = birthDate;
            this.gender = gender;
            this.province = province;
            this.practitionerName = practitionerName;
        }
    }

    public static class PatientSearchResult implements Serializable {

        private Integer id;
        private String text;

        public PatientSearchResult(Integer id, String text) {
            this.id = id;
            this.text = text;
        }

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }
    }

    public static class Results implements Serializable {

        private PatientSearchResult[] results;

        public Results(PatientSearchResult[] results) {
            this.results = results;
        }

        public PatientSearchResult[] getResults() {
            return results;
        }

        public void setResults(PatientSearchResult[] results) {
            this.results = results;
        }
    }
}
