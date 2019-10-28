package it.unitn.web.centodiciotto.servlets.shared;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
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

@WebServlet(urlPatterns = {"/restricted/general_practitioner/patient_list"})
public class PatientListServlet extends HttpServlet {
    private PatientDAO patientDAO = null;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) { // TODO........
            try {
                List<Patient> patientList = patientDAO.getPatientsByPractitionerID(user.getID());
                List<WholePatient> wholePatients = new ArrayList<>();

                for (Patient patient : patientList) {
                    wholePatients.add(new WholePatient(patient.getFirstName() + " " + patient.getLastName(),
                            patient.getSSN(), PhotoService.getLastPhoto(patient.getID()),
                            patient.getID(), "Patient Data"));
                }

                Gson gson = new Gson();

                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(wholePatients));
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }

    private static class WholePatient {
        private String name;
        private String ssn;
        private String avt;
        private String action;
        private String ID;

        public WholePatient(String name, String ssn, String avt, String ID, String action) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.ID = ID;
            this.action = action;
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
