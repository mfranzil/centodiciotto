package it.unitn.web.centodiciotto.servlets.patient;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamListDAO;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ExamHistoryServlet extends HttpServlet {

    private ExamDAO examDAO;
    private ExamListDAO examListDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for exam history servlet");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            examListDAO = daoFactory.getDAO(ExamListDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for exam history servlet", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            if (user instanceof Patient) {
                List<Exam> exams_history = null;
                try {
                    exams_history = examDAO.getByPatient(((Patient) user).getID());
                    // Since Exam description is in another table, here I join everything together
                    for (Exam exam : exams_history) {
                        try {
                            exam.setExamDescription(examListDAO.getByPrimaryKey(exam.getType()).getDescription());
                        } catch (DAOException e) {
                            e.printStackTrace();
                        }
                    }
                } catch (DAOException e) {
                    e.printStackTrace();
                }
                request.setAttribute("exams", exams_history);

            }
        }
        request.getRequestDispatcher("/jsp/patient/exam_history-p.jsp").forward(request, response);

    }

}