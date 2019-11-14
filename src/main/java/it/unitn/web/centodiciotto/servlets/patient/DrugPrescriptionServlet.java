package it.unitn.web.centodiciotto.servlets.patient;


import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.PDFService;
import it.unitn.web.centodiciotto.services.ServiceException;
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
            throw new ServletException("DAOFactory is null.");
        }
        try {
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/prescriptions-p.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            String practitionerID = request.getParameter("practitionerID");
            int prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
            String patientID = request.getParameter("patientID");

            try {
                GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(practitionerID);
                DrugPrescription prescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                Patient patient = patientDAO.getByPrimaryKey(patientID);

                prescription.setDateSold(new Timestamp(System.currentTimeMillis()));

                // Inserisco l'indirizzo corrente, possibile soltanto a livello di richiesta
                // in modo da aggiungerlo al codice QR
                String qrCodeURL = request.getScheme() + "://" +
                        request.getServerName() + (
                        "http".equals(request.getScheme()) && request.getServerPort() == 80 ||
                                "https".equals(request.getScheme()) && request.getServerPort() == 443
                                ? "" : ":" + request.getServerPort());

                PDDocument prescriptionDoc = PDFService.getInstance().createDrugPrescription(
                        prescription, patient, practitioner, qrCodeURL);

                response.setContentType("application/pdf");
                response.setHeader("Content-disposition", "inline; filename='prescription.pdf'");
                prescriptionDoc.save(response.getOutputStream());
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ServiceException e) {
                throw new ServletException("Error in PDF generation: ", e);
            }
        }

    }
}
