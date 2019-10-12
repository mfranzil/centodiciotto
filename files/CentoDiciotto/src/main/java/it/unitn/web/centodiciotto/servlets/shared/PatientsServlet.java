package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PatientsServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<List<Object>> list = new ArrayList<>();
        List<Patient> available_patients = null;

        if (user != null) {
            try {
                if (user instanceof GeneralPractitioner) {
                    available_patients = practitionerDAO.getPatientsByPractitionerId(user.getEmail());
                } else if (user instanceof SpecializedDoctor) {
                    available_patients = patientDAO.getAll();
                } else if (user instanceof HealthService) {
                    // TODO: Mettere ricerca per provincia
                    available_patients = new ArrayList<>();
                } else {
                    available_patients = new ArrayList<>();
                }
/* Da finire...mega listone con paziente, foto, visita, esame e prescrizione
                for (Patient patient : available_patients) {
                    List<Object> insertingList = new ArrayList<>();
                    insertingList.add(patient);
                    insertingList.add(PhotoService.getLastPhoto(patient));
                    insertingList.add()
                }*/
            } catch (DAOException ex) {
                throw new ServletException("Impossible to retrieve the patient.", ex);
            }
            request.setAttribute("available_patients", available_patients);
        }
        request.getRequestDispatcher("/jsp/general_practitioner/patients-gp-hs-sd.jsp").forward(request, response);
    }
}
