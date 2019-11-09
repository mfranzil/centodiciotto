package it.unitn.web.centodiciotto.servlets.practitioner;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/general_practitioner/visit_calendar")
public class VisitCalendarServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            String practitionerID = user.getID();

            try {
                List<Pair<Patient, Visit>> patientVisits = new ArrayList<>();
                List<Visit> visits = visitDAO.getByPractitioner(practitionerID);

                for (Visit visit : visits) {
                    if (!visit.getReportAvailable()) {
                        patientVisits.add(new Pair<>(patientDAO.getByPrimaryKey(visit.getPatientID()), visit));
                    }
                }
                request.setAttribute("patient_visits", patientVisits);
                request.getRequestDispatcher("/jsp/general_practitioner/visit_calendar-gp.jsp").forward(request, response);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            Integer visit_id = Integer.valueOf(request.getParameter("visitID"));

            try {
                Visit tmp = visitDAO.getByPrimaryKey(visit_id);
                tmp.setReportAvailable(true);
                visitDAO.update(tmp);

                doGet(request, response); // TODO use json / reload
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }
}
