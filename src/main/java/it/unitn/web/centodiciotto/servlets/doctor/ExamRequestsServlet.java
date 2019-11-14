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
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/restricted/specialized_doctor/exam_requests")
public class ExamRequestsServlet extends HttpServlet {
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
            request.getRequestDispatcher("/jsp/specialized_doctor/exam_requests-sd.jsp").forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user instanceof SpecializedDoctor) {
            String doctorID = user.getID();
            String patientID = request.getParameter("patientID");
            String examID = request.getParameter("examID");
            String examDate = request.getParameter("examDate");
            String examTime = request.getParameter("examTime");
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm");

            if (examDate == null || examTime == null || patientID == null
                    || examTime.equals("") || examDate.equals("") || examID == null) {
                throw new ServletException("Malformed input.");
            }

            try {
                Date date = formatter.parse(examDate + " " + examTime);

                Exam pendingExam = examDAO.getPendingByDoctorAndPatient(doctorID, patientID, Integer.valueOf(examID));

                if (pendingExam != null) {
                    pendingExam.setDate(new Timestamp(date.getTime()));
                    pendingExam.setBooked(true);

                    examDAO.update(pendingExam);
                }
            } catch (DAOException e) {
                throw new ServletException("Error in DAO usage: ", e);
            } catch (ParseException e) {
                throw new ServletException("Error in Date parsing: ", e);
            }
        }
    }
}
