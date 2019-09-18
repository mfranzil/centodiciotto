package it.unitn.web.centodiciotto.servlets.patient;

import be.quodlibet.boxable.utils.PDStreamUtils;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Prescription;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.util.List;

public class PrescriptionServlet extends HttpServlet {

    private PrescriptionDAO prescriptionDAO;
    private GeneralPractitionerDAO generalPractitionerDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            prescriptionDAO = daoFactory.getDAO(PrescriptionDAO.class);
            generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            
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
        request.getRequestDispatcher("/jsp/patient/prescriptions-gp.jsp").forward(request, response);
    }


    @Override
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws IOException {

        String practitioner_id = request.getParameter("practitioner_id");
        String patient_ssn = request.getParameter("patient_ssn");
        String prescription_date = request.getParameter("prescription_date");
        String prescription_id = request.getParameter("prescription_id");
        String prescription_description = request.getParameter("prescription_description");

        System.out.println(practitioner_id);
        System.out.println(patient_ssn);
        System.out.println(prescription_date);
        System.out.println(prescription_id);
        System.out.println(prescription_description);


        try (PDDocument doc = new PDDocument()) {
            PDPage page =  new PDPage(PDRectangle.A4);
            doc.addPage(page);

            try (PDPageContentStream contents = new PDPageContentStream(doc, page)) {
                PDStreamUtils.write(
                        contents,
                        "SERVIZIO SANITARIO NAZIONALE",
                        PDType1Font.HELVETICA,
                        14,
                        50,
                        800,
                        Color.BLACK);
                PDStreamUtils.write(
                        contents,
                        "RICETTA MEDICA",
                        PDType1Font.HELVETICA_BOLD,
                        14,
                        420,
                        800,
                        Color.BLACK);

                //Practioner ID
                PDStreamUtils.write(
                        contents,
                        "Medico di base ",
                        PDType1Font.HELVETICA_BOLD,
                        12,
                        50,
                        720,
                        Color.BLACK);
                PDStreamUtils.write(
                        contents,
                        practitioner_id,
                        PDType1Font.HELVETICA,
                        12,
                        50,
                        700,
                        Color.BLACK);
                //Patient SSN
                PDStreamUtils.write(
                        contents,
                        "Codice fiscale paziente ",
                        PDType1Font.HELVETICA_BOLD,
                        12,
                        400,
                        720,
                        Color.BLACK);
                PDStreamUtils.write(
                        contents,
                        patient_ssn,
                        PDType1Font.HELVETICA,
                        12,
                        400,
                        700,
                        Color.BLACK);
                //Prescription Date
                PDStreamUtils.write(
                        contents,
                        "Data emissione ",
                        PDType1Font.HELVETICA_BOLD,
                        12,
                        50,
                        650,
                        Color.BLACK);
                PDStreamUtils.write(
                        contents,
                        prescription_date,
                        PDType1Font.HELVETICA,
                        12,
                        50,
                        630,
                        Color.BLACK);
                //Prescription Number
                PDStreamUtils.write(
                        contents,
                        "Numero ricetta ",
                        PDType1Font.HELVETICA_BOLD,
                        12,
                        400,
                        650,
                        Color.BLACK);
                PDStreamUtils.write(
                        contents,
                        prescription_id,
                        PDType1Font.HELVETICA,
                        12,
                        400,
                        630,
                        Color.BLACK);
                //Prescription description
                PDStreamUtils.write(
                        contents,
                        "Descrizione",
                        PDType1Font.HELVETICA_BOLD,
                        12,
                        50,
                        580,
                        Color.BLACK);
                PDStreamUtils.write(
                        contents,
                        prescription_description,
                        PDType1Font.HELVETICA,
                        12,
                        50,
                        560,
                        Color.BLACK);
            } catch (IOException e) {
                e.printStackTrace();
            }

            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "inline; filename='prescription.pdf'");
            ////response.setHeader("Content-disposition", "attachment; filename='shopping-lists.pdf'");
            doc.save(response.getOutputStream());
        }
    }
}
