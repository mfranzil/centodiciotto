package it.unitn.web.centodiciotto.servlets.patient;

import com.google.common.collect.Lists;
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
            throw new ServletException("DAOFactory is null.");
        }

        try {
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
            examPrescriptionDAO = daoFactory.getDAO(ExamPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            try {
                List<ExamPrescription> examPrescription = examPrescriptionDAO.getByPatient(user.getID());
                request.setAttribute("examPrescriptions", examPrescription);

                List<ExamList> examLists;
                if (request.getParameter("examSearch") == null) {
                    examLists = examListDAO.getAll();
                } else {
                    examLists = Lists.newArrayList(
                            examListDAO.getByPrimaryKey(Integer.parseInt(request.getParameter("exam-search"))));
                }

                request.setAttribute("examLists", examLists);
                request.getRequestDispatcher("/jsp/patient/exam_booking-p.jsp").forward(request, response);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage:", e);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer selectedExam = Integer.valueOf(request.getParameter("selectedExam"));
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            try {
                boolean bookable = false;
                List<Exam_> results = new ArrayList<>();
                List<ExamPrescription> examPrescriptions = examPrescriptionDAO.getByPatient(user.getID());

                ExamList exam = examListDAO.getByPrimaryKey(selectedExam);

                for (ExamPrescription examPrescription : examPrescriptions) {
                    if (examPrescription.getExamType().getID().equals(selectedExam) && !examPrescription.getBooked()) {
                        bookable = true;
                        break;
                    }
                }
                results.add(new Exam_(exam.getID(), exam.getDescription(), bookable));

                Gson gson = new Gson();
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(new Results(results.toArray(new Exam_[0]))));
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }

    //TODO warning duplicate code
    private static class Exam_ implements Serializable {

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

    private static class Results implements Serializable {

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