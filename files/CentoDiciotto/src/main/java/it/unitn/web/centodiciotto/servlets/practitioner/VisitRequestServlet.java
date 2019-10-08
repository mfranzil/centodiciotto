package it.unitn.web.centodiciotto.servlets.practitioner;

import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
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
import java.util.ArrayList;
import java.util.List;

public class VisitRequestServlet extends HttpServlet {
    private PendingVisitDAO pendingVisitDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for visit request storage system");
        }
        try {
            pendingVisitDAO = daoFactory.getDAO(PendingVisitDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user instanceof GeneralPractitioner) {
            String practitioner_email = ((GeneralPractitioner) user).getEmail();
            try {
                List<Patient> pendingPatients = new ArrayList<>();

                List<PendingVisit> pendingVisits = pendingVisitDAO.getByPractitioner(practitioner_email);

                for( PendingVisit pendingVisit : pendingVisits){
                    pendingPatients.add(patientDAO.getByPrimaryKey(pendingVisit.getPatientEmail()));
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
        doGet(request, response);
    }
}
