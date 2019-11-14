package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.Action;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.ExamSearchResult;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.HTMLElement;
import it.unitn.web.centodiciotto.utils.entities.jsonelements.JSONResults;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/patient/exam_booking")
public class ExamBookingServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static List<ExamType> ALL_EXAMS = new ArrayList<>();

    private ExamTypeDAO examTypeDAO;
    private ExamDAO examDAO;
    private DoctorExamDAO doctorExamDAO;
    private HealthServiceDAO healthServiceDAO;
    private SpecializedDoctorDAO specializedDoctorDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examTypeDAO = daoFactory.getDAO(ExamTypeDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            doctorExamDAO = daoFactory.getDAO(DoctorExamDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);

            ALL_EXAMS = examTypeDAO.getAll();
            for (ExamType exam : ALL_EXAMS) {
                ALL_INTERNAL_EXAMS.add(new ExamSearchResult(exam.getID(), exam.getDescription()));
            }
        } catch (DAOFactoryException | DAOException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/exam_booking-p.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");

        switch (requestType) {
            case "examList": {
                try {
                    if (user instanceof Patient) {
                        Boolean onlyAvailable = Boolean.valueOf(request.getParameter("onlyAvailable"));
                        String examID = request.getParameter("examID");

                        List<ExamListElement> examListElements = new ArrayList<>();

                        List<Exam> patientExamList = examDAO.getPendingByPatientDoctorHealthServiceNotSelected(user.getID());

                        if (examID == null) {
                            if (onlyAvailable) {
                                for (Exam exam : patientExamList) {
                                    examListElements.add(new ExamListElement(exam.getType().getDescription(), new Action("Book Now", true), exam.getType().getID()));
                                }
                            } else {
                                List<Integer> examListIDs = new ArrayList<>();

                                for (Exam exam : patientExamList) {
                                    examListIDs.add(exam.getType().getID());
                                }

                                for (ExamType examType : ALL_EXAMS) {
                                    examListElements.add(new ExamListElement(examType.getDescription(), new Action("Book Now", examListIDs.contains(examType.getID())), examType.getID()));
                                }
                            }
                        } else {
                            Integer integerExamID = Integer.valueOf(examID);
                            boolean found = false;

                            for (Exam exam : patientExamList) {
                                if (exam.getType().getID().equals(integerExamID)) {
                                    found = true;
                                    break;
                                }
                            }
                            ExamType examType = examTypeDAO.getByPrimaryKey(integerExamID);
                            examListElements.add(new ExamListElement(examType.getDescription(), new Action("Book Now", found), examType.getID()));
                        }

                        Gson gson = new Gson();
                        response.setContentType("application/json");
                        response.getWriter().write(gson.toJson(examListElements));
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error in DAO usage: ", e);
                }
                break;
            }
            case "examSearch": {
                if (user instanceof Patient) {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        List<ExamSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_EXAMS.stream().filter(exam_SearchResult_
                                -> (exam_SearchResult_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new JSONResults<>(results.toArray(new ExamSearchResult[0]))));
                }
                break;
            }
            case "doctorSearch": {
                if (user instanceof Patient) {
                    String userInput = request.getParameter("term");
                    String examID = request.getParameter("examID");

                    if (examID != null) {
                        ExamType examType = new ExamType();
                        examType.setID(Integer.valueOf(examID));

                        try {
                            List<DoctorSearchResult> results = new ArrayList<>();
                            List<DoctorExam> doctorExamList = doctorExamDAO.getByExamType(examType);

                            for (DoctorExam doctorExam : doctorExamList) {
                                SpecializedDoctor specializedDoctor = specializedDoctorDAO.getByPrimaryKey(doctorExam.getDoctorID());
                                results.add(new DoctorSearchResult(doctorExam.getDoctorID(), specializedDoctor.toString(), false));
                            }
                            HealthService livingHealthService = healthServiceDAO.getByProvince(((Patient) user).getLivingProvince().getAbbreviation());
                            results.add(new DoctorSearchResult(livingHealthService.getID(), "Servizio Sanitario Provinciale di " + ((Patient) user).getLivingProvince().getName(), true));

                            if (userInput != null) {
                                List<DoctorSearchResult> tmpResults = new ArrayList<>();
                                results.stream().filter(exam_SearchResult_
                                        -> (exam_SearchResult_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                                results = tmpResults;
                            }

                            Gson gson = new Gson();
                            response.setContentType("application/json");
                            response.getWriter().write(gson.toJson(new JSONResults<>(results.toArray(new DoctorSearchResult[0]))));
                        } catch (DAOException e) {
                            e.printStackTrace();
                        }
                    }
                }
                break;
            }
            case "doctorExamBook": {
                try {
                    if (user instanceof Patient) {
                        String examID = request.getParameter("examID");
                        String doctorID = request.getParameter("doctorID");
                        String isHealthService = request.getParameter("isHealthService");

                        if (examID != null && doctorID != null && isHealthService != null) {
                            ExamType examType = examTypeDAO.getByPrimaryKey(Integer.valueOf(examID));

                            Exam toUpdate = examDAO.getPendingByPatientAndExamType(user.getID(), examType.getID());

                            if (Boolean.parseBoolean(isHealthService)) {
                                toUpdate.setHealthServiceID(doctorID);
                                toUpdate.setTicket(11);
                            } else {
                                toUpdate.setDoctorID(doctorID);
                                toUpdate.setTicket(50);
                            }
                            toUpdate.setBooked(false);
                            toUpdate.setType(examType);
                            toUpdate.setDone(false);

                            examDAO.update(toUpdate);
                        }
                    }
                } catch (NumberFormatException e) {
                    throw new ServletException("Error ExamID is null", e);
                } catch (DAOException e) {
                    throw new ServletException("DAOException while inserting doctorExam", e);
                }
                break;
            }
            case "detailedInfo": {
                if (user instanceof Patient) {
                    String examID = request.getParameter("item");

                    List<Object> jsonResponse = new ArrayList<>();
                    String contextPath = getServletContext().getContextPath();

                    jsonResponse.add(new HTMLElement().setElementType("form").setElementClass("doctor-form").setElementFormAction(contextPath + "/restricted/patient/exam_booking").setElementFormMethod("POST"));

                    List<HTMLElement> examForm = new ArrayList<>();
                    examForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden").setElementInputName("examID").setElementInputValue(examID));
                    examForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden").setElementInputName("requestType").setElementInputValue("doctorExamBook"));
                    examForm.add(new HTMLElement().setElementType("h5").setElementContent("Select a Specialized Doctor from the menu below"));
                    examForm.add(new HTMLElement().setElementType("select").setElementClass("select2-allow-clear form-control doctor-search mt-2").setElementSelectName("doctorID"));
                    examForm.add(new HTMLElement().setElementType("button").setElementClass("btn btn-lg btn-block btn-personal prescribe-exam mt-2").setElementButtonType("submit").setElementContent("Book exam"));
                    examForm.add(new HTMLElement().setElementType("small").setElementClass("doctor-label"));

                    jsonResponse.add(examForm);

                    jsonResponse.add(new HTMLElement().setElementType("script").setElementScriptType("text/javascript").setElementScriptSrc(contextPath + "/js/details/doctorExam.js"));

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(jsonResponse));
                }
                break;
            }

        }
    }


    private static class ExamListElement implements Serializable {
        private String exam;
        private Action action;
        private Integer ID;

        public ExamListElement(String exam, Action action, Integer ID) {
            this.exam = exam;
            this.action = action;
            this.ID = ID;
        }
    }


    private static class DoctorSearchResult implements Serializable {
        private String id;
        private String text;
        private Boolean healthService;

        public DoctorSearchResult(String id, String text, Boolean healthService) {
            this.id = id;
            this.text = text;
            this.healthService = healthService;
        }

        public String getText() {
            return text;
        }

    }
}