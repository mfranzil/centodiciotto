package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.PendingVisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Pair;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class VisitServlet extends HttpServlet {
    private VisitDAO visitDAO;
    private PendingVisitDAO pendingVisitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for visit storage system");
        }
        try {
            visitDAO = daoFactory.getDAO(VisitDAO.class);
            pendingVisitDAO = daoFactory.getDAO(PendingVisitDAO.class);
        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        GeneralPractitioner practitioner = (GeneralPractitioner) request.getSession().getAttribute("practitioner");
        if (user instanceof Patient) {
            List<Visit> visits = null;
            Boolean already_booked = false;
            try {
                visits = visitDAO.getByPatient(((Patient) user).getID());

                Pair<String, String> key = new Pair<>(((Patient) user).getID(), practitioner.getID());
                already_booked = (pendingVisitDAO.getByPrimaryKey(key) != null);

                request.setAttribute("visits", visits);
                request.setAttribute("already_booked", already_booked);
                //TODO cosa succede se ho un practitioner e lo cambio? gli appuntamenti rimangono?
            } catch (DAOException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("/jsp/patient/visits-p.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession(false).getAttribute("user");
        GeneralPractitioner practitioner = (GeneralPractitioner) request.getSession(false).getAttribute("practitioner");
        if (user instanceof Patient) {
            String patientEmail = user.getID();
            String practitionerEmail = practitioner.getID();

            PendingVisit pendingVisit = new PendingVisit();
            pendingVisit.setPatientID(patientEmail);
            pendingVisit.setPractitionerID(practitionerEmail);

            try {
                pendingVisitDAO.insert(pendingVisit);
            } catch (DAOException e) {
                e.printStackTrace();
            }
        }
        doGet(request, response);
    }
}
