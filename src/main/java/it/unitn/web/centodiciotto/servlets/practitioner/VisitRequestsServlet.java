package it.unitn.web.centodiciotto.servlets.practitioner;

import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Visit;

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
import java.util.Date;

/**
 * VisitRequestsServlet for handling requests to /restricted/general_practitioner/visit_requests.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests retrieve {@code patientID}, date and time from the request, validate them and try to update the
 * date of the {@link Visit}.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/general_practitioner/visit_requests")
public class VisitRequestsServlet extends HttpServlet {
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            request.getRequestDispatcher("/jsp/general_practitioner/visit-requests-gp.jsp").forward(request, response);
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

            if (visitDate == null || visitTime == null || patientID == null
                    || visitTime.equals("") || visitDate.equals("")) {
                throw new ServletException("Malformed input.");
            }

            try {
                Date date = formatter.parse(visitDate + " " + visitTime);

                Visit pendingVisit = visitDAO.getPendingByPractitionerAndPatient(practitionerID, patientID);

                if (pendingVisit != null) {
                    pendingVisit.setDate(new Timestamp(date.getTime()));
                    pendingVisit.setBooked(true);

                    visitDAO.update(pendingVisit);
                }
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ParseException e) {
                throw new ServletException("Error in Date parsing: ", e);
            }
        }
    }
}
