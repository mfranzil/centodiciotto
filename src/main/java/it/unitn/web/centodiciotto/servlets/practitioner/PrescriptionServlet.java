package it.unitn.web.centodiciotto.servlets.practitioner;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
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

@WebServlet("/restricted/general_practitioner/prescriptions")
public class PrescriptionServlet extends HttpServlet {
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            request.getRequestDispatcher("/jsp/general_practitioner/prescriptions-gp.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String ajax_type = request.getParameter("requestType");

        switch (ajax_type) {
            case "patientList": {
                if (user instanceof GeneralPractitioner) {
                    try {
                        String patientID = request.getParameter("patientID");

                        List<PatientListElement> patientListElements = new ArrayList<>();

                        if (patientID == null) {
                            List<Patient> patientList = patientDAO.getByPractitioner(user.getID());

                            for (Patient patient : patientList) {
                                String photoPath = PhotoService.getInstance().getLastPhoto(patient.getID());
                                patientListElements.add(new PatientListElement(patient.toString(),
                                        patient.getSSN(),
                                        photoPath,
                                        new JsonUtils.Action("Prescribe Exam or Drug", true),
                                        patient.getID()));
                            }
                        } else {
                            Patient patient = patientDAO.getByPrimaryKey(patientID);
                            if (patient.getPractitionerID().equals(user.getID())) {
                                String photoPath = PhotoService.getInstance().getLastPhoto(patient.getID());
                                patientListElements.add(new PatientListElement(patient.toString(),
                                        patient.getSSN(),
                                        photoPath,
                                        new JsonUtils.Action("Prescribe Exam or Drug", true),
                                        patient.getID()));
                            }
                        }
                        Gson gson = new Gson();

                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(patientListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in PhotoService usage: ", e);
                    }
                    break;
                }
            }
            case "detailedInfo": {
                String patientID = request.getParameter("item");

                List<Object> jsonResponse = new ArrayList<>();
                String contextPath = getServletContext().getContextPath();

                jsonResponse.add(new HtmlElement().setElementType("form").setElementClass("exam-form").setElementFormAction(contextPath + "/restricted/general_practitioner/exams").setElementFormMethod("POST"));

                List<HtmlElement> examForm = new ArrayList<>();
                examForm.add(new HtmlElement().setElementType("input").setElementInputType("hidden").setElementInputName("patientID").setElementInputValue(patientID));
                examForm.add(new HtmlElement().setElementType("input").setElementInputType("hidden").setElementInputName("requestType").setElementInputValue("examAdd"));
                examForm.add(new HtmlElement().setElementType("h5").setElementContent("Select an exam from the menu below"));
                examForm.add(new HtmlElement().setElementType("select").setElementClass("select2-allow-clear form-control exam-search").setElementSelectName("examID"));
                examForm.add(new HtmlElement().setElementType("br"));
                examForm.add(new HtmlElement().setElementType("button").setElementClass("btn btn-lg btn-block btn-personal prescribe-exam").setElementButtonType("submit").setElementContent("Prescribe exam"));
                examForm.add(new HtmlElement().setElementType("small").setElementClass("exam-prescribe-label"));
                examForm.add(new HtmlElement().setElementType("br"));

                jsonResponse.add(examForm);

                jsonResponse.add(new HtmlElement().setElementType("form").setElementClass("drug-form").setElementFormAction(contextPath + "/restricted/general_practitioner/drugs").setElementFormMethod("POST"));

                List<HtmlElement> drugForm = new ArrayList<>();

                drugForm.add(new HtmlElement().setElementType("input").setElementInputType("hidden").setElementInputName("patientID").setElementInputValue(patientID));
                drugForm.add(new HtmlElement().setElementType("input").setElementInputType("hidden").setElementInputName("requestType").setElementInputValue("drugAdd"));
                drugForm.add(new HtmlElement().setElementType("br"));
                drugForm.add(new HtmlElement().setElementType("h5").setElementContent("Select a drug from the menu below"));
                drugForm.add(new HtmlElement().setElementType("select").setElementClass("select2-allow-clear form-control drug-search").setElementSelectName("drugID"));
                drugForm.add(new HtmlElement().setElementType("br"));
                drugForm.add(new HtmlElement().setElementType("button").setElementClass("btn btn-lg btn-block btn-personal prescribe-drug").setElementButtonType("submit").setElementContent("Prescribe drug"));
                drugForm.add(new HtmlElement().setElementType("small").setElementClass("drug-prescribe-label"));
                drugForm.add(new HtmlElement().setElementType("br"));

                jsonResponse.add(drugForm);
                jsonResponse.add(new HtmlElement().setElementType("br"));

                jsonResponse.add(new HtmlElement().setElementType("script").setElementScriptType("text/javascript").setElementScriptSrc(contextPath + "/js/details/prescription.js"));

                Gson gson = new Gson();
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(jsonResponse));

                break;
            }
        }
    }

    private static class PatientListElement {
        private String name;
        private String ssn;
        private String avt;
        private JsonUtils.Action action;
        private String ID;

        public PatientListElement(String name, String ssn, String avt, JsonUtils.Action action, String ID) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.action = action;
            this.ID = ID;
        }
    }
}