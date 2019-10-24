package it.unitn.web.centodiciotto.servlets.patient;

import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.entities.ExamList;
import it.unitn.web.centodiciotto.persistence.entities.ExamPrescription;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

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
public class ExamPrescriptionServlet extends HttpServlet {
    /*
    It's still testing time, please do not pay attention
     */
    private ExamListDAO examListDAO;
    private ExamPrescriptionDAO examPrescriptionDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for exam_list storage system");
        }

        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
            examPrescriptionDAO = daoFactory.getDAO(ExamPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            List<ExamPrescription> examPrescription = null;
            try {
                examPrescription = examPrescriptionDAO.getByPatient(user.getID());
            } catch (DAOException e) {
                e.printStackTrace();
            }
            request.setAttribute("examPrescriptions", examPrescription);
        }

        List<ExamList> examLists = new ArrayList<>();
        if (request.getParameter("examSearch") == null) {
            try {
                examLists = examListDAO.getAll();
            } catch (DAOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                ExamList examList = examListDAO.getByPrimaryKey(Integer.parseInt(request.getParameter("exam-search")));
                examLists.add(examList);
            } catch (DAOException e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("examLists", examLists);
        request.getRequestDispatcher("/jsp/patient/exam_booking-p.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer selectedExam = Integer.valueOf(request.getParameter("selectedExam"));
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            try {
                boolean bookable = false;
                List<Exam_> results = new ArrayList<>();
                List<ExamPrescription> examPrescriptions = examPrescriptionDAO.getByPatient(user.getID());

                ExamList exam = examListDAO.getByPrimaryKey(selectedExam);

                for (ExamPrescription examPrescription : examPrescriptions) {
                    if (examPrescription.getExamType().getID().equals(selectedExam)
                            && !examPrescription.getBooked()) {
                        bookable = true;
                        break;
                    }
                }
                results.add(new Exam_(exam.getID(), exam.getDescription(), bookable));

                Gson gson = new Gson();
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(new Results(results.toArray(new Exam_[0]))));

            } catch (DAOException e) {
                e.printStackTrace();
            }
        }
    }

    //TODO warning duplicate code
    public static class Exam_ implements Serializable {

        private Integer id;
        private String text;
        private Boolean valid;

        public Exam_(Integer id, String text, Boolean valid) {
            this.id = id;
            this.text = text;
            this.valid = valid;
        }

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public Boolean getValid() {
            return valid;
        }

        public void setValid(Boolean valid) {
            this.valid = valid;
        }
    }

    public static class Results implements Serializable {

        private Exam_[] results;

        public Results(Exam_[] results) {
            this.results = results;
        }

        public Exam_[] getResults() {
            return results;
        }

        public void setResults(Exam_[] results) {
            this.results = results;
        }
    }
}