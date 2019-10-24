package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.PDFCreator;
import org.apache.pdfbox.pdmodel.PDDocument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/restricted/patient/prescriptions")
public class DrugPrescriptionServlet extends HttpServlet {


    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
                request.getRequestDispatcher("/jsp/patient/prescriptions-p.jsp").forward(request, response);
        }
    }


    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String practitionerID = request.getParameter("practitionerID");
        String patientSSN = request.getParameter("patientSSN");
        String prescriptionDate = request.getParameter("prescriptionDate");
        String prescriptionID = request.getParameter("prescriptionID");
        String prescriptionDescription = request.getParameter("prescriptionDescription");

        PDDocument prescriptionDoc = PDFCreator.createDrugPrescription(practitionerID, patientSSN,
                prescriptionDate, prescriptionID, prescriptionDescription);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename='prescription.pdf'");
        prescriptionDoc.save(response.getOutputStream());
    }
}
