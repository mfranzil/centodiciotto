package it.unitn.web.centodiciotto.servlets.practitioner;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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

@WebServlet("/restricted/general_practitioner/visits")
public class VisitRequestServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for visit request storage system");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user instanceof GeneralPractitioner) {
            String practitionerID = user.getID();
            try {
                List<Patient> pendingPatients = new ArrayList<>();

                // List<PendingVisit> pendingVisits = pendingVisitDAO.getByPractitioner(practitionerID);
                List<Visit> pendingVisits = visitDAO.getPendingVisitsByPractitioner(practitionerID);

                for (Visit pendingVisit : pendingVisits) {
                    pendingPatients.add(patientDAO.getByPrimaryKey(pendingVisit.getPatientID()));
                }

                request.setAttribute("pending_patients", pendingPatients);
            } catch (DAOException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("/jsp/general_practitioner/visits-gp.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        String practitionerID = user.getID();
        String patientID = request.getParameter("patientID");
        String visit_timestamp = request.getParameter("visitDate");

        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
        try {
            Date date = formatter.parse(visit_timestamp);

            Visit toBook = null;

            List<Visit> pendingVisits = visitDAO.getPendingVisitsByPractitioner(practitionerID);

            for (Visit visit: pendingVisits){
                if (visit.getPatientID().equals(patientID)){ // only one pending visit should exist
                    toBook = visit;
                }
            }
            toBook.setDate(new Timestamp(date.getTime()));
            toBook.setBooked(true);

            visitDAO.update(toBook);


        } catch (ParseException | DAOException e) {
            e.printStackTrace();
        }

        doGet(request, response);
    }
}
