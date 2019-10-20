package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Pair;
import it.unitn.web.utils.PhotoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/restricted/general_practitioner/patients",
        "/restricted/health_service/patients",
        "/restricted/specialized_doctor/patients"})
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

                    // TODO Inizio codice temporaneo da sostituire con beans
                    try {
                        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
                        var province = daoFactory.getDAO(ProvinceDAO.class).getByAbbreviation(patient.getLivingProvince());
                        var generalPractitioner = daoFactory.getDAO(GeneralPractitionerDAO.class).getByPrimaryKey(patient.getPractitionerID());
                        var visit = daoFactory.getDAO(VisitDAO.class).getLastVisitByPatient(patient);
                        String visitPrString = "";

                        if (visit != null) {
                            GeneralPractitioner visitPr = daoFactory.getDAO(GeneralPractitionerDAO.class).getByPrimaryKey(visit.getPractitionerID());
                            visitPrString = visitPr.getFirstName() + " " + visitPr.getLastName();
                        }

                        var exams = daoFactory.getDAO(ExamDAO.class).getByPatient(patient.getID());
                        ExamListDAO exd = daoFactory.getDAO(ExamListDAO.class);
                        List<Pair<Exam, String>> examList = new ArrayList<>();

                        if (exams != null && exams.size() > 0) {
                            for (Exam exam : exams) {
                                examList.add(Pair.makePair(exam, exd.getByPrimaryKey(exam.getType()).getDescription()));
                            }
                        }

                        listItem.add(patient);
                        listItem.add(province.getName() + " (" + province.getAbbreviation() + ")");
                        listItem.add(generalPractitioner.getFirstName() + " " + generalPractitioner.getLastName());
                        listItem.add(PhotoService.getLastPhoto(patient));
                        listItem.add(visit);
                        listItem.add(visitPrString);
                        listItem.add(examList);

                        list.add(listItem);
                    } catch (DAOFactoryException e) {
                        e.printStackTrace();
                    }
                    // Fine codice da modificare
                }

            } catch (DAOException ex) {
                throw new ServletException("Impossible to retrieve the patient.", ex);
            }
            request.setAttribute("list", list);
            request.getRequestDispatcher("/jsp/shared/patients-gp-hs-sd.jsp").forward(request, response);
        }
    }
}
