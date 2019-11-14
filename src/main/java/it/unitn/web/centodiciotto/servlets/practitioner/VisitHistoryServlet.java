package it.unitn.web.centodiciotto.servlets.practitioner;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.persistence.entities.Visit;
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

@WebServlet("/restricted/general_practitioner/visit_history")
public class VisitHistoryServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            visitDAO = daoFactory.getDAO(VisitDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof GeneralPractitioner) {
            request.getRequestDispatcher("/jsp/general_practitioner/visit_history-gp.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String ajax_type = request.getParameter("requestType");

        switch (ajax_type) {
            case "visitList": {
                if (user instanceof GeneralPractitioner) {
                    try {
                        PhotoService photoService = PhotoService.getInstance();

                        List<Visit> visitList = visitDAO.getDoneByPractitioner(user.getID());
                        List<VisitListElement> visitListElements = new ArrayList<>();

                        for (Visit visit : visitList) {
                            Patient patient = patientDAO.getByPrimaryKey(visit.getPatientID());
                            String photoPath = photoService.getLastPhoto(patient.getID());
                            Action action = ((visit.getReport() == null)
                                    ? new Action("Insert report", true)
                                    : new Action("Edit report", true));
                            visitListElements.add(new VisitListElement(
                                    patient.toString(), patient.getSSN(),
                                    photoPath, CustomDTFormatter.formatDateTime(visit.getDate()),
                                    action, visit.getID().toString()));
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(visitListElements));

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
                    String visitID = request.getParameter("item");
                    List<Object> jsonResponse = new ArrayList<>();
                    String contextPath = getServletContext().getContextPath();

                    Visit currentVisit = visitDAO.getByPrimaryKey(Integer.valueOf(visitID));

                    jsonResponse.add(new HTMLElement()
                            .setElementType("form")
                            .setElementClass("submit-report")
                            .setElementFormAction(contextPath + "/restricted/general_practitioner/visit_history")
                            .setElementFormMethod("POST"));

                    List<HTMLElement> form = new ArrayList<>();

                    if (currentVisit.getReport() != null) {
                        form.add(new HTMLElement().setElementType("h5").setElementContent("Old report:"));
                        form.add(new HTMLElement().setElementType("p").setElementContent(currentVisit.getReport()));
                    }

                    form.add(new HTMLElement().setElementType("h5").setElementContent("Please enter the report in the form below, " +
                            "then click on submit to set it."));

                    form.add(new HTMLElement().setElementType("input")
                            .setElementInputType("hidden")
                            .setElementInputValue(visitID)
                            .setElementInputName("visitID"));
                    form.add(new HTMLElement().setElementType("input")
                            .setElementInputType("hidden")
                            .setElementInputValue("setReport")
                            .setElementInputName("requestType"));
                    form.add(new HTMLElement().setElementType("textarea")
                            .setElementTextAreaPlaceholder("Click to start typing...")
                            .setElementTextAreaName("reportText"));
                    form.add(new HTMLElement().setElementType("button")
                            .setElementClass("btn btn-lg btn-block btn-personal submit-button mt-2")
                            .setElementButtonType("submit")
                            .setElementContent("Submit report"));
                    jsonResponse.add(form);

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(jsonResponse));
                } catch (DAOException e) {
                    e.printStackTrace();
                }
                break;
            }
            case "setReport": {
                if (user instanceof GeneralPractitioner) {
                    Integer visitID = Integer.valueOf(request.getParameter("visitID"));
                    String reportText = request.getParameter("reportText");

                    try {
                        Visit tmp = visitDAO.getByPrimaryKey(visitID);
                        tmp.setReport(reportText);
                        visitDAO.update(tmp);
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    request.getRequestDispatcher("/jsp/general_practitioner/visit_history-gp.jsp").forward(request, response);
                }
            }
        }
    }

    private static class VisitListElement implements Serializable {
        private String name;
        private String ssn;
        private String avt;
        private String date;
        private Action action;
        private String ID;

        public VisitListElement(String name, String ssn, String avt, String date, Action action, String ID) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.date = date;
            this.action = action;
            this.ID = ID;
        }
    }
}
