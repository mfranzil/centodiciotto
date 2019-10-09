package it.unitn.web.centodiciotto.servlets.practitioner;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.PendingVisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Pair;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class VisitCalendarServlet extends HttpServlet {
    private PendingVisitDAO pendingVisitDAO;
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for visit request storage system");
        }
        try {
            pendingVisitDAO = daoFactory.getDAO(PendingVisitDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user instanceof GeneralPractitioner) {
            String practitioner_email = user.getEmail();

            try {
                List<Pair<Patient, Visit>> patient_visits = new ArrayList<>();

                List<Visit> visits = visitDAO.getByPractitioner(practitioner_email);

                for (Visit visit : visits) {
                    if(!visit.getReportAvailable()) {
                        patient_visits.add(new Pair<>(patientDAO.getByPrimaryKey(visit.getPatientEmail()), visit));
                    }
                }
                request.setAttribute("patient_visits", patient_visits);

            } catch (DAOException e) {
                e.printStackTrace();
            }
        }
            request.getRequestDispatcher("/jsp/general_practitioner/visit_calendar-gp.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer visit_id = Integer.valueOf(request.getParameter("visit_id"));

        System.out.println(visit_id);

        try {
            Visit tmp = visitDAO.getByPrimaryKey(visit_id);

            tmp.setReportAvailable(true);

            visitDAO.update(tmp);

        } catch (DAOException e) {
            e.printStackTrace();
        }
        doGet(request, response);
    }
}
