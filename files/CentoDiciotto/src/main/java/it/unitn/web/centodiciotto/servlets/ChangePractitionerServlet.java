package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ChangePractitionerServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDao;
    private PatientDAO patientDao;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            practitionerDao = daoFactory.getDAO(GeneralPractitionerDAO.class);
            patientDao = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String pract_email = request.getParameter("practitioner_email");

        if (user instanceof Patient) {
            try {
                GeneralPractitioner pract = practitionerDao.getByPrimaryKey(pract_email);
                ((Patient) user).setGeneralPractitionerEmail(pract_email);
                request.getSession().setAttribute("practitioner", pract);
                patientDao.updatePractitioner((Patient) user);
                response.setStatus(200);
            } catch (NullPointerException | ClassCastException | DAOException ex) {
                response.setStatus(400);
                request.getServletContext().log("Impossible to retrieve the patient.", ex);
            }
        } else {
            response.setStatus(400);
        }


    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            if (user instanceof Patient) {
                List<GeneralPractitioner> available_practitioners =
                        practitionerDao.getByProvince(((Patient) user).getLivingProvince());
                request.setAttribute("available_practitioners", available_practitioners);

            }
        }
        request.getRequestDispatcher("/jsp/patient/unhappy_practitioner.jsp").forward(request, response);
    }
}
