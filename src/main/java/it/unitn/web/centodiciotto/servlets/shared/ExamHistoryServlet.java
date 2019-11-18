package it.unitn.web.centodiciotto.servlets.shared;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.Action;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * ExamHistoryServlet for handling requests to /restricted/role/exam_history,
 * where role can be health_service or specialized_doctor.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> examList: select2 AJAX response generator for returning a list of available {@link Exam}s
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup to
 *                        let the user update a {@link Exam}'s report.
 *     <li> setResult: updates a {@link Exam}'s report.
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet(urlPatterns = {"/restricted/specialized_doctor/exam_history", "/restricted/health_service/exam_history"})
public class ExamHistoryServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private ExamDAO examDAO;

    private PhotoService photoService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            photoService = PhotoService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            request.getRequestDispatcher("/jsp/shared/exam_history-hs-sd.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor || user instanceof HealthService) {
            String ajax_type = request.getParameter("requestType");

            switch (ajax_type) {
                case "examList": {
                    try {
                        List<Exam> examList;

                        if (user instanceof SpecializedDoctor) {
                            examList = examDAO.getDoneByDoctor(user.getID());
                        } else {
                            examList = examDAO.getDoneByHS(user.getID());
                        }

                        List<ExamListElement> examListElements = new ArrayList<>();

                        for (Exam exam : examList) {
                            Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            Action action = ((exam.getResult() == null)
                                    ? new Action("Insert result", true)
                                    : new Action("Edit result", true));
                            examListElements.add(new ExamListElement(
                                    exam.getID().toString(),
                                    patient.toString(),
                                    exam.getType().getDescription(),
                                    photoPath,
                                    CustomDTFormatter.formatDateTime(exam.getDate()),
                                    action));
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(examListElements));

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                    break;
                }
                case "detailedInfo": {
                    try {
                        String examID = request.getParameter("item");
                        List<Object> jsonResponse = new ArrayList<>();

                        Exam currentExam = examDAO.getByPrimaryKey(Integer.valueOf(examID));

                        jsonResponse.add(new HTMLElement()
                                .setElementType("form")
                                .setElementClass("submit-result")
                                .setElementFormMethod("POST"));

                        List<HTMLElement> form = new ArrayList<>();

                        if (currentExam.getResult() != null) {
                            form.add(new HTMLElement().setElementType("h5").setElementContent("Old result:"));
                            form.add(new HTMLElement().setElementType("p").setElementContent(currentExam.getResult()));
                        }

                        form.add(new HTMLElement().setElementType("h5").setElementContent("Please enter the result in the form below, " +
                                "then click on submit to set it."));

                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputValue(examID)
                                .setElementInputName("examID"));
                        form.add(new HTMLElement().setElementType("input")
                                .setElementInputType("hidden")
                                .setElementInputValue("setResult")
                                .setElementInputName("requestType"));
                        form.add(new HTMLElement().setElementType("textarea")
                                .setElementTextAreaPlaceholder("Click to start typing...")
                                .setElementTextAreaName("resultText"));
                        form.add(new HTMLElement().setElementType("button")
                                .setElementClass("btn btn-lg btn-block btn-personal mt-2 submit-button")
                                .setElementButtonType("submit")
                                .setElementContent("Submit result"));
                        jsonResponse.add(form);

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(jsonResponse));
                    } catch (DAOException e) {
                        e.printStackTrace();
                    }
                    break;
                }
                case "setResult": {
                    Integer examID = Integer.valueOf(request.getParameter("examID"));
                    String resultText = request.getParameter("resultText");

                    try {
                        Exam tmp = examDAO.getByPrimaryKey(examID);
                        tmp.setResult(resultText);
                        examDAO.update(tmp);
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class ExamListElement implements Serializable {
        private String name;
        private String exam;
        private String avt;
        private String date;
        private Action action;
        private String ID;

        ExamListElement(String ID, String name, String exam, String avt, String date, Action action) {
            this.ID = ID;
            this.name = name;
            this.exam = exam;
            this.avt = avt;
            this.date = date;
            this.action = action;
        }
    }
}
