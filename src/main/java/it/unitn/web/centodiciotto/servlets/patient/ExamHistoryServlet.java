package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.HealthServiceDAO;
import it.unitn.web.centodiciotto.persistence.dao.SpecializedDoctorDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;
import it.unitn.web.centodiciotto.utils.json.HTMLElement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * ExamHistoryServlet for handling requests to /restricted/patient/exam_history.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> historyList: select2 AJAX response generator for returning a list of past {@link Exam}s done by the Patient
 *     <li> examSearch: select2 AJAX response generator for returing detailed information about a particular {@link Exam}
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/patient/exam_history")
public class ExamHistoryServlet extends HttpServlet {

    private ExamDAO examDAO;
    private HealthServiceDAO healthServiceDAO;
    private SpecializedDoctorDAO specializedDoctorDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/exam_history-p.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (requestType == null) {
            response.setStatus(400);
            String json = "{\"error\": \"Malformed input. Please insert a valid requestType.\"}";
            writer.write(json);
            Logger.getLogger("C18").severe(json);
            return;
        }

        switch (requestType) {
            case "historyList" -> {
                try {
                    if (user instanceof Patient) {
                        List<ExamHistoryElement> examHistoryElements = new ArrayList<>();

                        List<Exam> patientExamList = examDAO.getNotPendingByPatient(user.getID());

                        for (Exam exam : patientExamList) {
                            examHistoryElements.add(new ExamHistoryElement(
                                    exam.getType().getDescription(),
                                    CustomDTFormatter.formatDateTime(exam.getDate()),
                                    exam.getResult() != null,
                                    new HTMLAction("See report", exam.getResult() != null),
                                    exam.getID()));
                        }

                        Gson gson = new Gson();
                        writer.write(gson.toJson(examHistoryElements));
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
                break;
            }
            case "detailedInfo" -> {
                try {
                    if (user instanceof Patient) {
                        String examID = request.getParameter("item");

                        if (examID == null) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. Please choose a valid exam.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                            return;
                        }

                        List<Object> jsonResponse = new ArrayList<>();
                        Exam currentExam = examDAO.getByPrimaryKey(Integer.valueOf(examID));


                        User performer;
                        String performerType;

                        if (currentExam.getHealthServiceID() != null) {
                            performer = healthServiceDAO.getByPrimaryKey(currentExam.getHealthServiceID());
                            performerType = "Local Health Service";
                        } else {
                            performer = specializedDoctorDAO.getByPrimaryKey(currentExam.getDoctorID());
                            performerType = "Specialized Doctor";
                        }

                        jsonResponse.add(new HTMLElement().setElementType("h5").setElementContent(performerType + ":"));
                        jsonResponse.add(new HTMLElement().setElementType("p").setElementContent(performer.toString()));
                        jsonResponse.add(new HTMLElement().setElementType("h5").setElementContent("Exam result:"));
                        jsonResponse.add(new HTMLElement().setElementType("p").setElementContent(currentExam.getResult()));

                        Gson gson = new Gson();
                        writer.write(gson.toJson(jsonResponse));
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
                break;
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class ExamHistoryElement implements Serializable {
        private final String exam;
        private final String date;
        private final Boolean reportstate;
        private final HTMLAction action;
        private final Integer ID;

        /**
         * Instantiates a new Exam history element.
         *
         * @param exam        the exam
         * @param date        the date
         * @param reportstate the report state
         * @param action      the action
         * @param ID          the id
         */
        ExamHistoryElement(String exam, String date, Boolean reportstate, HTMLAction action, Integer ID) {
            this.exam = exam;
            this.date = date;
            this.reportstate = reportstate;
            this.action = action;
            this.ID = ID;
        }
    }
}