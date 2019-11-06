package it.unitn.web.centodiciotto.servlets.practitioner;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.PatientDAO;
import it.unitn.web.centodiciotto.persistence.dao.VisitDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.HtmlElement;
import it.unitn.web.utils.JsonUtils;
import it.unitn.web.utils.PhotoService;

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

                        List<Patient> patientList = patientDAO.getPatientsByPractitioner(user.getID());

                        List<PatientListElement> patientListElements = new ArrayList<>();

                        for (Patient patient : patientList) {
                            String photoPath = PhotoService.getLastPhoto(patient.getID());
                            patientListElements.add(new PatientListElement(patient.toString(), patient.getSSN(), photoPath, new JsonUtils.Action("Patient Data", true), patient.getID()));
                        }

                        Gson gson = new Gson();

                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(patientListElements));

                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                    break;
                }
            }
            case "detailedInfo": {

                String patientID = request.getParameter("item");
                System.out.println(patientID);

                List<Object> jsonResponse = new ArrayList<>();
                String contextPath = getServletContext().getContextPath();

                String code = "            const url = getContextPath() + \"/restricted/general_practitioner/exams\";\n" +
                        "            $(function () {\n" +
                        "                $(\"#exam-search\")\n" +
                        "                    .select2({\n" +
                        "                        placeholder: \"Select an exam\",\n" +
                        "                        allowClear: true,\n" +
                        "                        closeOnSelect: true,\n" +
                        "                        ajax: {\n" +
                        "                            type: \"POST\",\n" +
                        "                            data: function (params) {\n" +
                        "                                return {\n" +
                        "                                    term: params.term,\n" +
                        "                                    requestType: 'examSearch'\n" +
                        "                                }\n" +
                        "                            },\n" +
                        "                            url: url,\n" +
                        "                            dataType: \"json\",\n" +
                        "                        }\n" +
                        "                    })\n" +
                        "                    .val(null)\n" +
                        "                    });";

                jsonResponse.add(new HtmlElement().setElementType("h5").setElementContent("Select an exam from the menu below"));
                jsonResponse.add(new HtmlElement().setElementType("select").setElementID("exam-search").setElementClass("select2-allow-clear form-control"));
                jsonResponse.add(new HtmlElement().setElementType("br"));

                jsonResponse.add(new HtmlElement().setElementType("link").setElementLinkRel("stylesheet").setElementLinkHref("https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.7/css/select2.min.css"));
                jsonResponse.add(new HtmlElement().setElementType("script").setElementScriptSrc("https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js").setElementScriptType("text/javascript").setElementContent(code));

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