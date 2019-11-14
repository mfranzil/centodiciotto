package it.unitn.web.centodiciotto.servlets.doctor;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.CustomDTFormatter;
import it.unitn.web.centodiciotto.utils.JsonUtils;
import it.unitn.web.centodiciotto.utils.entities.HtmlElement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/specialized_doctor/exam_history")
public class ExamHistoryServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private ExamDAO examDAO;

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
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor) {
            request.getRequestDispatcher("/jsp/specialized_doctor/exam_history-sd.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String ajax_type = request.getParameter("requestType");

        switch (ajax_type) {
            case "examList": {
                if (user instanceof SpecializedDoctor) {
                    try {
                        PhotoService photoService = PhotoService.getInstance();

                        List<Exam> examList = examDAO.getDoneByDoctor(user.getID());
                        List<ExamListElement> examListElements = new ArrayList<>();

                        for (Exam exam : examList) {
                            Patient patient = patientDAO.getByPrimaryKey(exam.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            JsonUtils.Action action = ((exam.getResult() == null)
                                    ? new JsonUtils.Action("Insert result", true)
                                    : new JsonUtils.Action("Edit result", true));
                            examListElements.add(new ExamListElement(
                                    patient.toString(), exam.getType().getDescription(),
                                    photoPath, CustomDTFormatter.formatDateTime(exam.getDate()),
                                    action, exam.getID().toString()));
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(examListElements));

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in Photo path retrieval: ", e);
                    }
                }
                break;
            }
            case "detailedInfo": {
                try {
                    String examID = request.getParameter("item");
                    List<Object> jsonResponse = new ArrayList<>();
                    String contextPath = getServletContext().getContextPath();

                    Exam currentExam = examDAO.getByPrimaryKey(Integer.valueOf(examID));

                    jsonResponse.add(new HtmlElement()
                            .setElementType("form")
                            .setElementFormAction(contextPath + "/restricted/specialized_doctor/exam_history")
                            .setElementFormMethod("POST"));

                    List<HtmlElement> form = new ArrayList<>();

                    form.add(new HtmlElement()
                            .setElementType("h5")
                            .setElementContent("Please enter the result in the form below, " +
                                    "then click on submit to set it."));

                    if (currentExam.getResult() != null) {
                        form.add(new HtmlElement().setElementType("h7").setElementContent("Old result:"));
                        form.add(new HtmlElement().setElementType("p").setElementContent(currentExam.getResult()));
                        form.add(new HtmlElement().setElementType("br"));
                    }
                    form.add(new HtmlElement().setElementType("input")
                            .setElementInputType("hidden")
                            .setElementInputValue(examID)
                            .setElementInputName("examID"));
                    form.add(new HtmlElement().setElementType("input")
                            .setElementInputType("hidden")
                            .setElementInputValue("setResult")
                            .setElementInputName("requestType"));
                    form.add(new HtmlElement().setElementType("textarea")
                            .setElementTextAreaPlaceholder("Click to start typing...")
                            .setElementTextAreaName("resultText"));
                    form.add(new HtmlElement().setElementType("button")
                            .setElementClass("btn btn-lg btn-block btn-personal")
                            .setElementButtonType("submit")
                            .setElementContent("Submit result"));
                    jsonResponse.add(form);
                    jsonResponse.add(new HtmlElement().setElementType("br"));

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(jsonResponse));
                } catch (DAOException e) {
                    e.printStackTrace();
                }
                break;
            }
            case "setResult": {
                if (user instanceof SpecializedDoctor) {
                    Integer examID = Integer.valueOf(request.getParameter("examID"));
                    String resultText = request.getParameter("resultText");

                    try {
                        Exam tmp = examDAO.getByPrimaryKey(examID);
                        tmp.setResult(resultText);
                        examDAO.update(tmp);
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    request.getRequestDispatcher("/jsp/specialized_doctor/exam_history-gp.jsp").forward(request, response);
                }
            }
        }
    }

    private static class ExamListElement {
        private String name;
        private String exam;
        private String avt;
        private String date;
        private JsonUtils.Action action;
        private String ID;

        public ExamListElement(String name, String exam, String avt, String date, JsonUtils.Action action, String ID) {
            this.name = name;
            this.exam = exam;
            this.avt = avt;
            this.date = date;
            this.action = action;
            this.ID = ID;
        }
    }
}
