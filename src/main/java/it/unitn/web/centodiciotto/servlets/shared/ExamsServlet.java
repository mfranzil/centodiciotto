package it.unitn.web.centodiciotto.servlets.shared;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.DoctorExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.utils.JsonUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = {"/restricted/general_practitioner/exams",
        "/restricted/patient/exams"})
public class ExamsServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static List<ExamList> ALL_EXAMS = new ArrayList<>();
    private ExamListDAO examListDAO;
    private ExamDAO examDAO;
    private DoctorExamDAO doctorExamDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);
            doctorExamDAO = daoFactory.getDAO(DoctorExamDAO.class);

            ALL_EXAMS = examListDAO.getAll();
            for (ExamList exam : ALL_EXAMS) {
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
            doPost(request, response);
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

                        List<Exam> patientExamList = examDAO.getByPatientNotBooked(user.getID());

                        if (examID == null) {
                            if (onlyAvailable) {
                                for (Exam exam : patientExamList) {
                                    examListElements.add(new ExamListElement(exam.getType().getDescription(), new JsonUtils.Action("Book Now", true), exam.getType().getID()));
                                }
                            } else {
                                List<Integer> examListIDs = new ArrayList<>();

                                for (Exam exam : patientExamList) {
                                    examListIDs.add(exam.getType().getID());
                                }

                                for (ExamList examList : ALL_EXAMS) {
                                    examListElements.add(new ExamListElement(examList.getDescription(), new JsonUtils.Action("Book Now", examListIDs.contains(examList.getID())), examList.getID()));
                                }
                            }
                        } else {
                            Integer integerExamID = Integer.valueOf(examID);
                            boolean found = false;

                            for (Exam exam : patientExamList) {
                                if (exam.getType().getID().equals(integerExamID)) {
                                    found = true;
                                }
                            }
                            ExamList examList = examListDAO.getByPrimaryKey(integerExamID);
                            examListElements.add(new ExamListElement(examList.getDescription(),
                                    new JsonUtils.Action("Book Now", found), examList.getID()));
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
                if (user instanceof Patient || user instanceof GeneralPractitioner) {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        results = ALL_INTERNAL_EXAMS.stream().filter(exam_SearchResult_
                                -> (exam_SearchResult_.getText().toLowerCase().contains(userInput.toLowerCase())))
                                .collect(Collectors.toList());
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new Results(results.toArray(new ExamSearchResult[0]))));
                }
                break;
            }
            case "examAdd": {
                try {
                    if (user instanceof GeneralPractitioner) {
                        String examID = request.getParameter("examID");
                        String patientID = request.getParameter("patientID");

                        ExamList examList = examListDAO.getByPrimaryKey(Integer.valueOf(examID));

                        Exam newExam = new Exam();
                        newExam.setPatientID(patientID);
                        newExam.setPractitionerID(user.getID());
                        newExam.setBooked(false);
                        newExam.setType(examList);
                        newExam.setDone(false);
                        newExam.setTicket(-1);

                        examDAO.insert(newExam);
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error with DAOs in ExamsServlet", e);
                } catch (NumberFormatException e) {
                    throw new ServletException("Error ExamID is null", e);
                }
                break;
            }
            case "detailedInfo": {
                if (user instanceof Patient) {
                    String examID = request.getParameter("item");
                    if (examID != null) {
                        ExamList examList = new ExamList();
                        examList.setID(Integer.valueOf(examID));

                        try {
                            System.out.println(examID + doctorExamDAO.getByExamList(examList).get(0).getDoctorID());
                        } catch (DAOException e) {
                            e.printStackTrace();
                        }
                    }

                }
                break;
            }
        }
    }


    private static class ExamListElement {
        private String exam;
        private JsonUtils.Action action;
        private Integer ID;

        public ExamListElement(String exam, JsonUtils.Action action, Integer ID) {
            this.exam = exam;
            this.action = action;
            this.ID = ID;
        }
    }

    private static class ExamSearchResult implements Serializable {
        private Integer id;
        private String text;

        ExamSearchResult(Integer id, String text) {
            this.id = id;
            this.text = text;
        }

        public String getText() {
            return text;
        }

    }

    private static class Results implements Serializable {
        private ExamSearchResult[] results;

        Results(ExamSearchResult[] results) {
            this.results = results;
        }
    }
}