package it.unitn.web.centodiciotto.servlets.practitioner;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
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
                List<Patient> pendingPatients = new ArrayList<>();

                List<Visit> pendingVisits = visitDAO.getPendingVisitsByPractitioner(practitionerID);

                for (Visit pendingVisit : pendingVisits) {
                    pendingPatients.add(patientDAO.getByPrimaryKey(pendingVisit.getPatientID()));
                }

                request.setAttribute("pending_patients", pendingPatients);
                request.getRequestDispatcher("/jsp/general_practitioner/visits-gp.jsp").forward(request, response);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            String practitionerID = user.getID();
            String patientID = request.getParameter("patientID");
            String visitDate = request.getParameter("visitDate");
            String visitTime = request.getParameter("visitTime");
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm");

            try {
                Date date = formatter.parse(visitDate + " " + visitTime);

                Visit toBook = null;

                List<Visit> pendingVisits = visitDAO.getPendingVisitsByPractitioner(practitionerID);

                for (Visit visit : pendingVisits) {
                    if (visit.getPatientID().equals(patientID)) {
                        toBook = visit;
                    }
                }

                if (toBook != null) {
                    toBook.setDate(new Timestamp(date.getTime()));
                    toBook.setBooked(true);

                    visitDAO.update(toBook);

                    doGet(request, response); // TODO usare json / reload
                }
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ParseException e) {
                throw new ServletException("Error in Date parsing: ", e);
            }
        }
    }
}
