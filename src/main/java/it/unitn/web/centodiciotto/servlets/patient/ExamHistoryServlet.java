package it.unitn.web.centodiciotto.servlets.patient;


import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.utils.entities.Pair;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/restricted/patient/exam_history")
public class ExamHistoryServlet extends HttpServlet {

    private ExamDAO examDAO;
    private ExamTypeDAO examTypeDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            examTypeDAO = daoFactory.getDAO(ExamTypeDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof Patient) {
            // TODO Inizio codice da modificare con i beans
            try {
                List<Pair<Exam, String>> to_be_sent = new ArrayList<>();
                List<Exam> exams_history = examDAO.getByPatient(user.getID());
                // Since Exam description is in another table, here I join everything together
                for (Exam exam : exams_history) {
                    try {
                        to_be_sent.add(Pair.makePair(exam,
                                examTypeDAO.getByPrimaryKey(exam.getType().getID()).getDescription()));
                    } catch (DAOException e) {
                        throw new ServletException("Error in DAO usage: ", e);
                    }
                }
                request.setAttribute("exams", to_be_sent);
                request.getRequestDispatcher("/jsp/patient/exam_history-p.jsp").forward(request, response);
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            }
            // TODO Fine codice da modificare
        }
    }
}