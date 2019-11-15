package it.unitn.web.centodiciotto.servlets.patient;


import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.ExamDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.DrugPrescription;
import it.unitn.web.centodiciotto.persistence.entities.Exam;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * The type Ticket servlet.
 */
@WebServlet("/restricted/patient/tickets")
public class TicketServlet extends HttpServlet {
    private ExamDAO examDAO;
    private DrugPrescriptionDAO drugPrescriptionDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }

        try {
            examDAO = daoFactory.getDAO(ExamDAO.class);
            drugPrescriptionDAO = daoFactory.getDAO(DrugPrescriptionDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user instanceof Patient) {
            request.getRequestDispatcher("/jsp/patient/tickets-p.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user instanceof Patient) {
            String type = request.getParameter("type");
            Integer ID = Integer.valueOf(request.getParameter("ID"));
            if (type.equals("exam")) {
                try {
                    Exam selectedExam = examDAO.getByPrimaryKey(ID);

                    if (selectedExam.isTicketPaid()) {
                        response.setStatus(400);
                    } else {
                        selectedExam.setTicketPaid(true);
                        examDAO.update(selectedExam);
                        response.setStatus(200);
                    }
                } catch (DAOException e) {
                    response.setStatus(400);
                    throw new ServletException("Error in DAO usage: ", e);
                }
            } else if (type.equals("drug")) {
                try {
                    DrugPrescription selectedPrescription = drugPrescriptionDAO.getByPrimaryKey(ID);

                    if (selectedPrescription.getTicketPaid()) {
                        response.setStatus(400);
                    } else {
                        selectedPrescription.setTicketPaid(true);
                        drugPrescriptionDAO.update(selectedPrescription);
                        response.setStatus(200);
                    }
                } catch (DAOException e) {
                    response.setStatus(400);
                    throw new ServletException("Error in DAO usage: ", e);
                }
            } else {
                throw new ServletException("Malformed input (type must be drug or exam)");
            }
        }
    }
}
