package it.unitn.web.centodiciotto.servlets.healthservice;

import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.ExcelService;
import it.unitn.web.centodiciotto.services.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import java.util.logging.Logger;

/**
 * ReportServlet for handling requests to /restricted/health_service/reports.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests receive five booleans (which are compared in a null-safe way with {@link Object#equals(Object)}),
 * a date and pass this information to an {@link ExcelService} for generating the report.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused"})
@WebServlet("/restricted/health_service/reports")
public class ReportServlet extends HttpServlet {

    private ExcelService excelService;

    @Override
    public void init() throws ServletException {
        try {
            excelService = ExcelService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
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
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (user instanceof HealthService) {
            try {
                boolean includeVisits = Objects.equals(request.getParameter("includeVisits"), "on");
                boolean includeRecalls = Objects.equals(request.getParameter("includeRecalls"), "on");
                boolean includeDoctorExams = Objects.equals(request.getParameter("includeDoctorExams"), "on");
                boolean includeHealthServiceExams = Objects.equals(request.getParameter("includeHealthServiceExams"), "on");
                boolean includePrescriptions = Objects.equals(request.getParameter("includePrescriptions"), "on");

                Date date = new Date(new SimpleDateFormat("dd/MM/yyyy").parse(
                        request.getParameter("date")
                ).getTime());

                if (date.getTime() >= new Date(System.currentTimeMillis()).getTime()) {
                    response.setStatus(400);
                    String json = "{\"error\": \"Please select a date in the past starting from today.\"}";
                    writer.write(json);
                    Logger.getLogger("C18").severe(json);
                    return;
                }

                String reportPath = excelService.createReport(user.getID(), date,
                        (String) getServletContext().getAttribute("xAuthToken"),
                        includeVisits, includeRecalls,
                        includeDoctorExams, includeHealthServiceExams,
                        includePrescriptions);

                writer.write("{\"path\": \"" + reportPath.replace("\\", "\\\\") + "\"}");
            } catch (ParseException e) {
                throw new ServletException("Failed to parse date parameter: ", e);
            } catch (ServiceException e) {
                throw new ServletException("Failed to generate Excel report: ", e);
            }
        }
    }
}
