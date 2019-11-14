package it.unitn.web.centodiciotto.servlets.doctor;

import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.SpecializedDoctor;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/restricted/specialized_doctor/exam_calendar")
public class ExamCalendarServlet extends HttpServlet {
    private ExamDAO examDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor) {
            request.getRequestDispatcher("/jsp/specialized_doctor/exam_calendar-sd.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor) {
            Integer examID;

            try {
                examID = Integer.valueOf(request.getParameter("examID"));
            } catch (NumberFormatException e) {
                throw new ServletException("Malformed input: ", e);
            }

            try {
                Exam exam = examDAO.getByPrimaryKey(examID);
                exam.setDone(true);
                examDAO.update(exam);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
        }
    }
}
