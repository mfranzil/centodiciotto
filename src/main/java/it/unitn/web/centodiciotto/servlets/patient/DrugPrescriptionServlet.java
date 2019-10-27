package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.PDFCreator;
import org.apache.pdfbox.pdmodel.PDDocument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/restricted/patient/prescriptions")
public class DrugPrescriptionServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;
    private DrugPrescriptionDAO drugPrescriptionDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/prescriptions-p.jsp").forward(request, response);
        }
    }


    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String practitionerID = request.getParameter("practitionerID");
        int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
        String patientID = request.getParameter("patientID");

        try {
            GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(practitionerID);
            DrugPrescription drugPrescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
            Patient patient = patientDAO.getByPrimaryKey(patientID);

            drugPrescription.setDateSold(new Timestamp(System.currentTimeMillis()));

            PDDocument prescriptionDoc = PDFCreator.createDrugPrescription(drugPrescription, patient, practitioner);

            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "inline; filename='prescription.pdf'");
            prescriptionDoc.save(response.getOutputStream());

        } catch (DAOException e) {
            throw new ServletException("Failure in PDF composition,", e);
        }
    }
}
