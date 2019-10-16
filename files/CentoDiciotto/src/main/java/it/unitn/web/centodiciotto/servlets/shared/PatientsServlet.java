package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.UserService;
import it.unitn.web.utils.VEPService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PatientsServlet extends HttpServlet {

    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            List<List<Object>> list = new ArrayList<>();
            List<Patient> available_patients = null;

            try {
                if (user instanceof GeneralPractitioner) {
                    available_patients = patientDAO.getPatientsByPractitionerId(user.getID());
                } else if (user instanceof SpecializedDoctor) {
                    available_patients = patientDAO.getAll();
                } else if (user instanceof HealthService) {
                    // TODO: Mettere ricerca per provincia
                    available_patients = new ArrayList<>();
                } else {
                    available_patients = new ArrayList<>();
                }

                for (Patient patient : available_patients) {
                    List<Object> listItem = new ArrayList<>();

                    UserService.powerUpPatient(patient);
                    listItem.add(patient);

                    Visit visit = VEPService.getLastDoneVisit(patient);
                    listItem.add(visit);

                    List<Exam> examList = VEPService.getLastDoneExams(patient);
                    listItem.add(examList);

                    list.add(listItem);
                }
            } catch (DAOException ex) {
                throw new ServletException("Impossible to retrieve the patient.", ex);
            }
            request.setAttribute("list", list);
            request.getRequestDispatcher("/jsp/shared/patients-gp-hs-sd.jsp").forward(request, response);
        }
    }
}
