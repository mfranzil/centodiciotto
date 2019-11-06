package it.unitn.web.centodiciotto.servlets.healthservice;

import it.unitn.web.centodiciotto.persistence.dao.ChemistDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.ExcelService;
import it.unitn.web.utils.exceptions.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/restricted/health_service/reports")
public class HealthServiceReportServlet extends HttpServlet {

    private DrugPrescriptionDAO drugPrescriptionDAO;
    private PatientDAO patientDAO;
    private ChemistDAO chemistDAO;
    private GeneralPractitionerDAO generalPractitionerDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            generalPractitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof HealthService) {
            request.getRequestDispatcher("/jsp/health_service/reports-hs.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof HealthService) {
            try {
                ExcelService excelService = ExcelService.getInstance();

                boolean includeVisits = request.getParameter("includeVisits").equals("on");
                boolean includeRecalls = request.getParameter("includeRecalls").equals("on");
                boolean includeSpecialistExams = request.getParameter("includeSpecialistExams").equals("on");
                boolean includeHealthServiceExams = request.getParameter("includeHealthServiceExams").equals("on");
                boolean includePrescriptions = request.getParameter("includePrescriptions").equals("on");

                Date date = new Date(new SimpleDateFormat("dd/MM/yyyy").parse(
                        request.getParameter("date")
                ).getTime());


                String reportPath = excelService.createReport(user.getID(), date, includeVisits, includeRecalls,
                        includeSpecialistExams, includeHealthServiceExams, includePrescriptions);

                String json = "{\"path\": \"" + reportPath.replace("\\", "\\\\") + "\"}";
                response.getWriter().write(json);
            } catch (ParseException e) {
                throw new ServletException("Failed to parse date parameter: ", e);
            } catch (ServiceException e) {
                throw new ServletException("Failed to generate Excel report: ", e);
            }
        }
    }
}
