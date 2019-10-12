package it.unitn.web.centodiciotto.servlets.patient;

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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
            List<ExamPrescription> exam_prescription = null;
            try {
                exam_prescription = examPrescriptionDAO.getByPatient(user.getEmail());
            } catch (DAOException e) {
                e.printStackTrace();
            }
            request.setAttribute("exam_prescriptions", exam_prescription);
        }

        List<ExamList> examLists = new ArrayList<>();
        if (request.getParameter("exam-search") == null) {
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

        request.setAttribute("exam_lists", examLists);
        request.getRequestDispatcher("/jsp/patient/exam_booking-p.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}