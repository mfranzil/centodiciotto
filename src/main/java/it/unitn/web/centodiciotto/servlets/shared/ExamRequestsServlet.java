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
import it.unitn.web.centodiciotto.utils.entities.jsonelements.Action;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * The type Exam requests servlet.
 */
@WebServlet(urlPatterns = {"/restricted/specialized_doctor/exam_requests", "/restricted/health_service/exam_requests"})
public class ExamRequestsServlet extends HttpServlet {
    private ExamDAO examDAO;
    private PatientDAO patientDAO;

    private PhotoService photoService;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            patientDAO = daoFactory.getDAO(PatientDAO.class);

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
            request.getRequestDispatcher("/jsp/shared/exam_requests-hs-sd.jsp").forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");

        switch (requestType) {
            case "requestBook": {
                if (user instanceof SpecializedDoctor || user instanceof HealthService) {
                    String examHandlerID = user.getID(); // Può essere doctor o HS
                    String patientID = request.getParameter("patientID");
                    String examID = request.getParameter("examID");
                    String examDate = request.getParameter("examDate");
                    String examTime = request.getParameter("examTime");
                    DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm");

                    if (examDate == null || examTime == null || patientID == null
                            || examTime.equals("") || examDate.equals("") || examID == null) {
                        throw new ServletException("Malformed input.");
                    }

                    try {
                        Date date = formatter.parse(examDate + " " + examTime);

                        Exam pendingExam;

                        if (user instanceof SpecializedDoctor) {
                            pendingExam = examDAO.getPendingByDoctorPatientType(examHandlerID, patientID, Integer.valueOf(examID));
                        } else {
                            pendingExam = examDAO.getPendingByHSPatientType(examHandlerID, patientID, Integer.valueOf(examID));
                        }

                        if (pendingExam != null) {
                            pendingExam.setDate(new Timestamp(date.getTime()));
                            pendingExam.setBooked(true);
                            examDAO.update(pendingExam);
                        } else {
                            throw new ServletException("Failed to find pending exam with this parameters.");
                        }
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ParseException e) {
                        throw new ServletException("Error in Date parsing: ", e);
                    }
                }
                break;
            }
            case "requestList": {
                if (user instanceof SpecializedDoctor || user instanceof HealthService) {
                    try {
                        List<ExamRequestListElement> examRequestListElements = new ArrayList<>();
                        List<Exam> examList;

                        if (user instanceof SpecializedDoctor) {
                            examList = examDAO.getPendingByDoctor(user.getID());
                        } else {
                            examList = examDAO.getPendingByHS(user.getID());
                        }

                        for (Exam exam : examList) {
                            Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            //TODO find better way to send both IDs
                            examRequestListElements.add(new ExamRequestListElement(photoPath, patient.toString(), exam.getType().getDescription(), new Action("Choose date and time", true), patient.getID() + ";" + exam.getType().getID()));
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(examRequestListElements));

                    } catch (ServiceException e) {
                        throw new ServletException("Error in getting PhotoService Instance: ", e);
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage in requestList: ", e);
                    }
                }
                break;
            }
            case "detailedInfo": {
                String patientIDExamID = request.getParameter("item");
                List<Object> jsonResponse = new ArrayList<>();

                try {
                    String patientID = patientIDExamID.split(";")[0];
                    String examID = patientIDExamID.split(";")[1];

                    Patient patient = patientDAO.getByPrimaryKey(patientID);
                    String contextPath = getServletContext().getContextPath();

                    jsonResponse.add(new HTMLElement().setElementType("form").
                            setElementClass("set-exam")
                            .setElementFormMethod("POST"));

                    List<Object> setExamForm = new ArrayList<>();
                    setExamForm.add(new HTMLElement().setElementType("p").setElementContent("Insert a date and time for the appointment, then confirm."));
                    setExamForm.add(new HTMLElement().setElementType("div").setElementStyle("display: flex; width: 100%;"));

                    List<Object> div = new ArrayList<>();

                    div.add(new HTMLElement().setElementType("label").setElementStyle("flex: 50%").setElementClass("my-2 mr-1"));
                    List<HTMLElement> firstLabel = new ArrayList<>();
                    firstLabel.add(new HTMLElement().setElementType("input").setElementInputName("examDate").setElementInputType("text").setElementInputAutocomplete("off").setElementClass("form-control datepicker exam-date"));
                    div.add(firstLabel);

                    div.add(new HTMLElement().setElementType("label").setElementStyle("flex: 50%").setElementClass("my-2 ml-1"));
                    List<HTMLElement> secondLabel = new ArrayList<>();
                    secondLabel.add(new HTMLElement().setElementType("input").setElementInputName("examTime").setElementInputType("text").setElementInputAutocomplete("off").setElementClass("form-control timepicker exam-time"));
                    div.add(secondLabel);

                    setExamForm.add(div);
                    setExamForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden").setElementInputValue(patientID).setElementInputName("patientID"));
                    setExamForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden").setElementInputValue(examID).setElementInputName("examID"));
                    setExamForm.add(new HTMLElement().setElementType("button")
                            .setElementClass("btn btn-lg btn-block btn-personal submit")
                            .setElementButtonType("submit")
                            .setElementContent("Confirm the appointment"));

                    jsonResponse.add(setExamForm);

                    jsonResponse.add(new HTMLElement().setElementType("script")
                            .setElementScriptType("text/javascript")
                            .setElementScriptSrc(contextPath + "/js/details/examRequests.js"));

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(jsonResponse));

                } catch (DAOException e) {
                    throw new ServletException("Error while getting patient detail in ExamRequestsServlet", e);
                }

                break;
            }
        }
    }

    private static class ExamRequestListElement implements Serializable {
        private String avt;
        private String patient;
        private String exam;
        private Action action;
        private String ID;

        public ExamRequestListElement(String avt, String patient, String exam, Action action, String ID) {
            this.avt = avt;
            this.patient = patient;
            this.exam = exam;
            this.action = action;
            this.ID = ID;
        }
    }
}
