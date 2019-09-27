package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.PrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Prescription;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.PDFCreator;
import org.apache.pdfbox.pdmodel.PDDocument;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class PrescriptionServlet extends HttpServlet {

    private PrescriptionDAO prescriptionDAO;
   // private GeneralPractitionerDAO generalPractitionerDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            prescriptionDAO = daoFactory.getDAO(PrescriptionDAO.class);
            //generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);

        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            if (user instanceof Patient) {
                List<Prescription> prescriptions =
                        prescriptionDAO.getByPatient(((Patient) user).getEmail());
                request.setAttribute("prescriptions", prescriptions);

            }
        }
        request.getRequestDispatcher("/jsp/patient/prescriptions-p.jsp").forward(request, response);
    }


    @Override
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws IOException {

        String practitioner_id = request.getParameter("practitioner_id");
        String patient_ssn = request.getParameter("patient_ssn");
        String prescription_date = request.getParameter("prescription_date");
        String prescription_id = request.getParameter("prescription_id");
        String prescription_description = request.getParameter("prescription_description");

        PDDocument prescription_doc = PDFCreator.createPrescription(prescription_id, patient_ssn, prescription_date, prescription_id, prescription_description);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename='prescription.pdf'");
        prescription_doc.save(response.getOutputStream());
    }
}
