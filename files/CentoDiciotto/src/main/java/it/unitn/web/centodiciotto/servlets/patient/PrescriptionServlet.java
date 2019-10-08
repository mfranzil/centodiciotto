package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.PrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Prescription;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.PDFCreator;
import it.unitn.web.utils.Pair;
import org.apache.pdfbox.pdmodel.PDDocument;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class PrescriptionServlet extends HttpServlet {

    private PrescriptionDAO prescriptionDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            prescriptionDAO = daoFactory.getDAO(PrescriptionDAO.class);

        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            if (user instanceof Patient) {
                Calendar now = Calendar.getInstance();

                List<Prescription> prescriptions;
                List<Pair<Prescription, Boolean>> prescription_list = new ArrayList<>();

                try {
                    prescriptions = prescriptionDAO.getByPatient(user.getEmail());

                    for (Prescription prescription : prescriptions) {
                        Calendar prescriptionDate = Calendar.getInstance();
                        prescriptionDate.setTime(prescription.getPrescriptionDate());
                        prescriptionDate.add(Calendar.MONTH, 1);

                        Boolean available = prescriptionDate.getTime().after(now.getTime());
                        prescription_list.add(Pair.makePair(prescription, available));
                    }
                    request.setAttribute("prescriptions", prescription_list);
                } catch (DAOException e) {
                    throw new ServletException("Error in Prescription retrieval.", e);
                }

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

        PDDocument prescription_doc = PDFCreator.createPrescription(practitioner_id, patient_ssn, prescription_date, prescription_id, prescription_description);

        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename='prescription.pdf'");
        prescription_doc.save(response.getOutputStream());
    }
}
