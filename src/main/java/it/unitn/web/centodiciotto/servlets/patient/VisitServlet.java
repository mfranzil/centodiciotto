package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
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

@WebServlet("/restricted/patient/visits")
public class VisitServlet extends HttpServlet {
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
        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/visits-p.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");

        if (user instanceof Patient) {
            String patientID = user.getID();
            String practitionerID = ((Patient) user).getPractitionerID();

            Visit pendingVisit = new Visit();
            pendingVisit.setPatientID(patientID);
            pendingVisit.setPractitionerID(practitionerID);
            pendingVisit.setReportAvailable(false);
            pendingVisit.setBooked(false);

            try {
                visitDAO.insert(pendingVisit);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
        doGet(request, response); // TODO Usare JSON
    }
}