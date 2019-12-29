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
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

/**
 * DrugPrescriptionServlet for handling requests to /restricted/patient/prescriptions.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests get a {@code prescriptionID}, a {@code patientID}, and a {@code practitionerID} and pass
 * them to a {@link PDFService} instance for the generation of a PDF prescription, which is
 * then shown to the user.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused"})
@WebServlet("/restricted/patient/prescriptions")
public class DrugPrescriptionServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;
    private DrugPrescriptionDAO drugPrescriptionDAO;
    private PatientDAO patientDAO;

    private PDFService pdfService;

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

        try {
            pdfService = PDFService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
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
            String patientID = request.getParameter("patientID");
            Integer prescriptionID;

            try {
                prescriptionID = Integer.parseInt(request.getParameter("prescriptionID"));
            } catch (NumberFormatException | NullPointerException e) {
                response.setStatus(400);

                PrintWriter writer = response.getWriter();
                response.setContentType("application/json");

                String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            if (practitionerID == null || patientID == null) {
                response.setStatus(400);

                PrintWriter writer = response.getWriter();
                response.setContentType("application/json");

                String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                writer.write(json);
                Logger.getLogger("C18").severe(json);
                return;
            }

            try {
                GeneralPractitioner practitioner = practitionerDAO.getByPrimaryKey(practitionerID);
                DrugPrescription prescription = drugPrescriptionDAO.getByPrimaryKey(prescriptionID);
                Patient patient = patientDAO.getByPrimaryKey(patientID);

                String filePath = getServletContext().getRealPath("/") +
                        getServletContext().getInitParameter("pdf-folder");
                String fileName = prescription.getDatePrescribed().getTime() + "-" + prescription.getID() + ".pdf";

                if (new File(filePath + File.separator + fileName).exists()) {
                    PDDocument.load(new File(filePath + File.separator + fileName)).save(response.getOutputStream());
                    Logger.getLogger("C18").info("Supplying already-generated PDF prescription " + filePath + File.separator + fileName);
                    return;
                }

                // Saves the current URL, which is possible only at request level,
                // in order to let the service generate the QR code properly
                String qrCodeURL = getCurrentURL(request);

                PDDocument prescriptionDoc = pdfService.createDrugPrescription(
                        prescription, patient, practitioner, qrCodeURL);

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename='prescription.pdf'");

                Logger.getLogger("C18").info("Supplying new PDF prescription " + filePath + File.separator + fileName);

                prescriptionDoc.save(filePath + File.separator + fileName);
                prescriptionDoc.save(response.getOutputStream());
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ServiceException e) {
                throw new ServletException("Error in PDF generation: ", e);
            }
        }
    }

    private String getCurrentURL(HttpServletRequest request) {
        return request.getScheme() + "://" + request.getServerName() + (
                "http".equals(request.getScheme()) && request.getServerPort() == 80 ||
                        "https".equals(request.getScheme()) && request.getServerPort() == 443
                        ? "" : ":" + request.getServerPort());
    }
}
