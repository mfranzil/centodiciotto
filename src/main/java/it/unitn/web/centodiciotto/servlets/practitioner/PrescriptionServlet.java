package it.unitn.web.centodiciotto.servlets.practitioner;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.EmailService;
import it.unitn.web.centodiciotto.services.PhotoService;
import it.unitn.web.centodiciotto.services.ServiceException;
import it.unitn.web.centodiciotto.utils.json.ExamSearchResult;
import it.unitn.web.centodiciotto.utils.json.HTMLAction;
import it.unitn.web.centodiciotto.utils.json.HTMLElement;
import it.unitn.web.centodiciotto.utils.json.JSONResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * PrescriptionServlet for handling requests to /restricted/general_practitioner/prescriptions.
 * <p>
 * GET requests pass through.
 * <p>
 * POST requests are filtered depending on the {@code requestType} parameter:
 * <ul>
 *     <li> examList: select2 AJAX response generator for returning a list of available {@link Patient}s
 *     <li> detailedInfo: select2 AJAX response generator for building out a popup to let the user choose
 *                        from a new {@link DrugPrescription} or a new {@link Exam}, with relative dropdowns
 *     <li> examSearch: select2 AJAX response generator for returing a list of {@link Exam} for the
 *                      user to choose from, with a word query
 *     <li> examAdd: instantiates a new {@link Exam} from the {@link ExamType} and the {@link Patient}
 *     <li> drugSearch: select2 AJAX response generator for returing a list of {@link DrugPrescription} for the
 *                      user to choose from, with a word query
 *     <li> drugAdd: instantiates a new {@link DrugPrescription} from the {@link DrugType} and the {@link Patient}
 * </ul>
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/general_practitioner/prescriptions")
public class PrescriptionServlet extends HttpServlet {
    private static final List<ExamSearchResult> ALL_INTERNAL_EXAMS = new ArrayList<>();
    private static final List<DrugSearchResult> ALL_INTERNAL_DRUGS = new ArrayList<>();

    private DrugPrescriptionDAO drugPrescriptionDAO;
    private DrugTypeDAO drugTypeDAO;
    private ExamTypeDAO examTypeDAO;
    private ExamDAO examDAO;
    private PatientDAO patientDAO;

    private PhotoService photoService;
    private EmailService emailService;

    private String contextPath;

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

            List<ExamType> allExams = examTypeDAO.getAll();
            for (ExamType exam : allExams) {
                ALL_INTERNAL_EXAMS.add(new ExamSearchResult(exam.getID(), exam.getDescription()));
            }

            drugTypeDAO = daoFactory.getDAO(DrugTypeDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);

            List<DrugType> allDrugs = drugTypeDAO.getAll();
            for (DrugType drugType : allDrugs) {
                ALL_INTERNAL_DRUGS.add(new DrugSearchResult(drugType.getID(), drugType.getDescription()));
            }
        } catch (DAOFactoryException | DAOException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }

        try {
            photoService = PhotoService.getInstance();
            emailService = EmailService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }

        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
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

        if (user instanceof GeneralPractitioner) {
            switch (requestType) {
                case "patientList" -> {
                    try {
                        String patientID = request.getParameter("patientID");

                        List<PatientListElement> patientListElements = new ArrayList<>();

                        if (patientID == null) {
                            List<Patient> patientList = patientDAO.getByPractitioner(user.getID());

                            for (Patient patient : patientList) {
                                String photoPath = photoService.getLastPhoto(patient.getID());
                                patientListElements.add(new PatientListElement(patient.toString(),
                                        patient.getSSN(),
                                        photoPath,
                                        new HTMLAction("Prescribe Exam or Drug", true),
                                        patient.getID()));
                            }
                        } else {
                            Patient patient = patientDAO.getByPrimaryKey(patientID);
                            if (patient.getPractitionerID().equals(user.getID())) {
                                String photoPath = photoService.getLastPhoto(patient.getID());
                                patientListElements.add(new PatientListElement(patient.toString(),
                                        patient.getSSN(),
                                        photoPath,
                                        new HTMLAction("Prescribe Exam or Drug", true),
                                        patient.getID()));
                            }
                        }
                        Gson gson = new Gson();
                        writer.write(gson.toJson(patientListElements));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in PhotoService usage: ", e);
                    }
                    break;
                }
                case "detailedInfo" -> {
                    String patientID = request.getParameter("item");

                    if (patientID == null) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please choose a valid patient.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    List<Object> jsonResponse = new ArrayList<>();

                    jsonResponse.add(new HTMLElement().setElementType("form")
                            .setElementClass("exam-form")
                            .setElementFormAction(contextPath + "restricted/general_practitioner/prescriptions")
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
                            .setElementFormAction(contextPath + "restricted/general_practitioner/prescriptions")
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
                            .setElementScriptSrc(contextPath + "js/details/prescription.js"));

                    Gson gson = new Gson();
                    writer.write(gson.toJson(jsonResponse));

                    break;
                }
                case "examSearch" -> {
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
                    writer.write(gson.toJson(new JSONResult<>(results.toArray(new ExamSearchResult[0]))));
                    break;
                }
                case "examAdd" -> {
                    Integer examID;
                    String patientID = request.getParameter("patientID");

                    try {
                        examID = Integer.valueOf(request.getParameter("examID"));
                    } catch (NumberFormatException | NullPointerException e) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    if (patientID == null) {
                        response.setStatus(400);
                        String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                        return;
                    }

                    try {
                        ExamType examType = examTypeDAO.getByPrimaryKey(examID);

                        Exam possiblePendingExam = examDAO.getPendingByPatientAndExamType(
                                patientID, examType.getID());
                        if (possiblePendingExam == null) {
                            Exam newExam = new Exam();
                            newExam.setPatientID(patientID);
                            newExam.setPractitionerID(user.getID());
                            newExam.setBooked(false);
                            newExam.setType(examType);
                            newExam.setDone(false);
                            newExam.setTicket(-1);
                            examDAO.insert(newExam);
                        } else {
                            possiblePendingExam.setPractitionerID(user.getID());
                            examDAO.update(possiblePendingExam);
                        }
                        Patient patient = patientDAO.getByPrimaryKey(patientID);

                        String message = "Dear " + patient.toString() + ",\n\n" +
                                "your General Practitioner just prescribed you an exam:\n\n" +
                                examType.getDescription() +
                                "\n\nPlease visit CentoDiciotto to book this exam as soon as possible." +
                                "\n\nYours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - Exam prescription notification";

                        // Notifies the patient about the exam prescription
                        emailService.sendEmail(patientID, message, subject);

                        writer.write("{}");
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage:", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in email sending: ", e);
                    }
                    break;
                }
                case "drugSearch" -> {
                    String userInput = request.getParameter("term");

                    List<DrugSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_DRUGS;
                    } else {
                        List<DrugSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_DRUGS.stream().filter(drugSearchResult
                                -> drugSearchResult.getText().toLowerCase()
                                .contains(userInput.toLowerCase())).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    writer.write(gson.toJson(new JSONResult<>(results.toArray(new DrugSearchResult[0]))));

                    break;
                }
                case "drugAdd" -> {
                    try {
                        Integer drugID;
                        String patientID = request.getParameter("patientID");

                        try {
                            drugID = Integer.valueOf(request.getParameter("drugID"));
                        } catch (NumberFormatException | NullPointerException e) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                            return;
                        }

                        if (patientID == null) {
                            response.setStatus(400);
                            String json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                            writer.write(json);
                            Logger.getLogger("C18").severe(json);
                        }

                        DrugType drugType = drugTypeDAO.getByPrimaryKey(drugID);

                        DrugPrescription newPrescription = new DrugPrescription();

                        newPrescription.setPractitionerID(user.getID());
                        newPrescription.setPatientID(patientID);
                        newPrescription.setType(drugType);
                        newPrescription.setDatePrescribed(new Timestamp(System.currentTimeMillis()));
                        newPrescription.setTicket(3);
                        newPrescription.setTicketPaid(false);
                        newPrescription.setDescription(" ");

                        drugPrescriptionDAO.insert(newPrescription);

                        Patient patient = patientDAO.getByPrimaryKey(patientID);

                        String message = "Dear " + patient.toString() + ",\n\n" +
                                "your General Practitioner just prescribed you an drug:\n\n" +
                                drugType.getDescription() +
                                "\n\nPlease visit CentoDiciotto to retrieve your prescription as soon as possible." +
                                "\n\nYours,\nThe CentoDiciotto team.\n";
                        String subject = "CentoDiciotto - Drug prescription notification";

                        // Avviso il paziente dell'abilitazione della precrizione
                        emailService.sendEmail(patientID, message, subject);

                        writer.write("{}");
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    } catch (ServiceException e) {
                        throw new ServletException("Error in email sending: ", e);
                    }
                    break;
                }
                default -> throw new IllegalStateException("Unexpected value: " + requestType);
            }
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class PatientListElement implements Serializable {
        private final String name;
        private final String ssn;
        private final String avt;
        private final HTMLAction action;
        private final String ID;

        /**
         * Instantiates a new Patient list element.
         *
         * @param name   the name
         * @param ssn    the ssn
         * @param avt    the avt
         * @param action the action
         * @param ID     the id
         */
        PatientListElement(String name, String ssn, String avt, HTMLAction action, String ID) {
            this.name = name;
            this.ssn = ssn;
            this.avt = avt;
            this.action = action;
            this.ID = ID;
        }
    }

    /**
     * Static serializable class used by {@link Gson} and sent back in JSON form to the JSP.
     */
    private static class DrugSearchResult implements Serializable {
        private final Integer id;
        private final String text;

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