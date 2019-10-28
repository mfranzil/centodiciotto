package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.SendEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/restricted/patient/change_practitioner")
public class ChangePractitionerServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            try {
                String newPractitionerID = request.getParameter("practitionerID");

                GeneralPractitioner oldPract = practitionerDAO.getByPrimaryKey(((Patient) user).getPractitionerID());
                GeneralPractitioner newPract = practitionerDAO.getByPrimaryKey(newPractitionerID);

                ((Patient) user).setPractitionerID(newPractitionerID);
                patientDAO.updatePractitioner((Patient) user);

                Visit pendingVisit = visitDAO.getPendingVisitByPractitionerAndPatient(oldPract.getID(), user.getID());
                if (pendingVisit != null) {
                    visitDAO.delete(pendingVisit);
                }

                String recipient = oldPract.getID();
                String message = "Dear " + oldPract.getFirstName() + " " + oldPract.getLastName() + ",\n\n" +
                        "one of your patients just asked for a change of practitioner " +
                        "and will be no longer on your patient list.\n" +
                        "Here are the patient details:\n\n" +
                        ((Patient) user).getFirstName() + " " + ((Patient) user).getLastName() + "\n" +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                String subject = "CentoDiciotto - Patient change notification";

                // Avviso il vecchio practitioner
                SendEmail.send(recipient, message, subject);

                recipient = newPract.getID();
                message = "Dear " + newPract.getFirstName() + " " + newPract.getLastName() + ",\n\n" +
                        "we are glad to tell you that you have a new patient on your patient list.\n" +
                        "Here are the patient details:\n\n" +
                        ((Patient) user).getFirstName() + " " + ((Patient) user).getLastName() + "\n" +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                subject = "CentoDiciotto - New patient notification";

                // Avviso il nuovo practitioner
                SendEmail.send(recipient, message, subject);

                recipient = user.getID();
                message = "Dear " + ((Patient) user).getFirstName() + " " + ((Patient) user).getLastName() + ",\n\n" +
                        "we inform you that your general practitioner has been successfully changed.\n" +
                        "Here are the practitioner details:\n\n" +
                        oldPract.getFirstName() + " " + oldPract.getLastName() + "\n" +
                        "\n\nYours,\nThe CentoDiciotto team.\n";
                subject = "CentoDiciotto - Practitioner change notification";

                // Avviso il paziente
                SendEmail.send(recipient, message, subject);

                response.setStatus(200);
            } catch (DAOException e) {
                response.setStatus(400);
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            try {
                List<GeneralPractitioner> availablePractitioners =
                        practitionerDAO.getByProvince(((Patient) user).getLivingProvince().getAbbreviation());
                GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(((Patient) user).getPractitionerID());

                request.setAttribute("practitioner", practitioner);
                request.setAttribute("availablePractitioners", availablePractitioners);
                request.getRequestDispatcher("/jsp/patient/change_practitioner-p.jsp").forward(request, response);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }
}
