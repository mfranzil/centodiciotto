package it.unitn.web.centodiciotto.servlets.practitioner;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * The type Prescription servlet.
 */
@WebServlet("/restricted/general_practitioner/prescriptions")
public class PrescriptionServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static final List<DrugSearchResult> ALL_INTERNAL_DRUGS = new ArrayList<>();
    private static List<ExamType> ALL_EXAMS = new ArrayList<>();
    private static List<DrugType> ALL_DRUGS = new ArrayList<>();

    private DrugPrescriptionDAO drugPrescriptionDAO;
    private DrugTypeDAO drugTypeDAO;
    private ExamTypeDAO examTypeDAO;
    private ExamDAO examDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            patientDAO = daoFactory.getDAO(PatientDAO.class);
            examTypeDAO = daoFactory.getDAO(ExamTypeDAO.class);
            examDAO = daoFactory.getDAO(ExamDAO.class);

            ALL_EXAMS = examTypeDAO.getAll();
            for (ExamType exam : ALL_EXAMS) {
                ALL_INTERNAL_EXAMS.add(new ExamSearchResult(exam.getID(), exam.getDescription()));
            }

            drugTypeDAO = daoFactory.getDAO(DrugTypeDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);

            ALL_DRUGS = drugTypeDAO.getAll();
            for (DrugType drugType : ALL_DRUGS) {
                ALL_INTERNAL_DRUGS.add(new DrugSearchResult(drugType.getID(), drugType.getDescription()));
            }
        } catch (DAOFactoryException | DAOException e) {
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
                                        new Action("Prescribe Exam or Drug", true),
                                        patient.getID()));
                            }
                        } else {
                            Patient patient = patientDAO.getByPrimaryKey(patientID);
                            if (patient.getPractitionerID().equals(user.getID())) {
                                String photoPath = PhotoService.getInstance().getLastPhoto(patient.getID());
                                patientListElements.add(new PatientListElement(patient.toString(),
                                        patient.getSSN(),
                                        photoPath,
                                        new Action("Prescribe Exam or Drug", true),
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

                jsonResponse.add(new HTMLElement().setElementType("form").
                        setElementClass("exam-form")
                        .setElementFormAction(contextPath + "/restricted/general_practitioner/prescriptions")
                        .setElementFormMethod("POST"));

                List<HTMLElement> examForm = new ArrayList<>();
                examForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden")
                        .setElementInputName("patientID").setElementInputValue(patientID));
                examForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden")
                        .setElementInputName("requestType").setElementInputValue("examAdd"));
                examForm.add(new HTMLElement().setElementType("h5")
                        .setElementContent("Select an exam from the menu below"));
                examForm.add(new HTMLElement().setElementType("select")
                        .setElementClass("select2-allow-clear form-control exam-search width-100")
                        .setElementSelectName("examID"));
                examForm.add(new HTMLElement().setElementType("button")
                        .setElementClass("btn btn-lg btn-block btn-personal prescribe-exam mt-2")
                        .setElementButtonType("submit").setElementContent("Prescribe exam"));
                examForm.add(new HTMLElement().setElementType("small").
                        setElementClass("exam-prescribe-label"));

                jsonResponse.add(examForm);

                jsonResponse.add(new HTMLElement().setElementType("form")
                        .setElementClass("drug-form")
                        .setElementFormAction(contextPath + "/restricted/general_practitioner/prescriptions")
                        .setElementFormMethod("POST"));

                List<HTMLElement> drugForm = new ArrayList<>();

                drugForm.add(new HTMLElement().setElementType("br"));
                drugForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden")
                        .setElementInputName("patientID").setElementInputValue(patientID));
                drugForm.add(new HTMLElement().setElementType("input").setElementInputType("hidden")
                        .setElementInputName("requestType").setElementInputValue("drugAdd"));
                drugForm.add(new HTMLElement().setElementType("h5")
                        .setElementContent("Select a drug from the menu below"));
                drugForm.add(new HTMLElement().setElementType("select")
                        .setElementClass("select2-allow-clear form-control drug-search width-100")
                        .setElementSelectName("drugID"));
                drugForm.add(new HTMLElement().setElementType("button")
                        .setElementClass("btn btn-lg btn-block btn-personal prescribe-drug mt-2")
                        .setElementButtonType("submit").setElementContent("Prescribe drug"));
                drugForm.add(new HTMLElement().setElementType("small")
                        .setElementClass("drug-prescribe-label"));

                jsonResponse.add(drugForm);

                jsonResponse.add(new HTMLElement().setElementType("script")
                        .setElementScriptType("text/javascript")
                        .setElementScriptSrc(contextPath + "/js/details/prescription.js"));

                Gson gson = new Gson();
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(jsonResponse));

                break;
            }
            case "examSearch": {
                if (user instanceof GeneralPractitioner) {
                    String userInput = request.getParameter("term");

                    List<ExamSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_EXAMS;
                    } else {
                        List<ExamSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_EXAMS.stream().filter(examSearchResult
                                -> (examSearchResult.getText().toLowerCase()
                                .contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new JSONResults<>(results.toArray(new ExamSearchResult[0]))));
                }
                break;
            }
            case "examAdd": {
                try {
                    if (user instanceof GeneralPractitioner) {
                        String examID = request.getParameter("examID");
                        String patientID = request.getParameter("patientID");

                        ExamType examType = examTypeDAO.getByPrimaryKey(Integer.valueOf(examID));

                        Exam newExam = new Exam();
                        newExam.setPatientID(patientID);
                        newExam.setPractitionerID(user.getID());
                        newExam.setBooked(false);
                        newExam.setType(examType);
                        newExam.setDone(false);
                        newExam.setTicket(-1);

                        examDAO.insert(newExam);
                    }
                } catch (DAOException e) {
                    throw new ServletException("Error with DAOs in :", e);
                } catch (NumberFormatException e) {
                    throw new ServletException("Error ExamID is null", e);
                }
                break;
            }

            case "drugSearch": {
                if (user instanceof GeneralPractitioner) {
                    String userInput = request.getParameter("term");

                    List<DrugSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_DRUGS;
                    } else {
                        List<DrugSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_DRUGS.stream().filter(drugSearchResult
                                -> (drugSearchResult.getText().toLowerCase()
                                .contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new JSONResults<>(results.toArray(new DrugSearchResult[0]))));
                }
                break;
            }
            case "drugAdd": {
                try {
                    if (user instanceof GeneralPractitioner) {
                        String drugID = request.getParameter("drugID");
                        String patientID = request.getParameter("patientID");

                        DrugType drugType = drugTypeDAO.getByPrimaryKey(Integer.valueOf(drugID));

                        DrugPrescription newPrescription = new DrugPrescription();

                        newPrescription.setPractitionerID(user.getID());
                        newPrescription.setPatientID(patientID);
                        newPrescription.setDrugType(drugType);
                        newPrescription.setDatePrescribed(new Timestamp(System.currentTimeMillis()));
                        newPrescription.setTicket(3);
                        newPrescription.setTicketPaid(false);
                        newPrescription.setDescription(" ");
                        /* ????????
                        private Timestamp dateSold;
                        private String chemistID;
                        private String description;
                         */

                        drugPrescriptionDAO.insert(newPrescription);
                    }

                } catch (DAOException e) {
                    throw new ServletException("Error with DAOs in ", e);
                } catch (NumberFormatException e) {
                    throw new ServletException("Error DrugID is null", e);
                }
                break;
            }
        }
    }

    private static class PatientListElement implements Serializable {
        private String name;
        private String ssn;
        private String avt;
        private Action action;
        private String ID;

        /**
         * Instantiates a new Patient list element.
         *
         * @param name   the name
         * @param ssn    the ssn
         * @param avt    the avt
         * @param action the action
         * @param ID     the id
         */
        public PatientListElement(String name, String ssn, String avt, Action action, String ID) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.action = action;
            this.ID = ID;
        }
    }

    private static class DrugSearchResult implements Serializable {
        private Integer id;
        private String text;

        /**
         * Instantiates a new Drug search result.
         *
         * @param id   the id
         * @param text the text
         */
        DrugSearchResult(Integer id, String text) {
            this.id = id;
            this.text = text;
        }

        /**
         * Gets text.
         *
         * @return the text
         */
        public String getText() {
            return text;
        }

    }

}