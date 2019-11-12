package it.unitn.web.centodiciotto.servlets.shared;


import com.google.gson.Gson;
import it.unitn.web.centodiciotto.persistence.dao.DrugTypeDAO;
import it.unitn.web.centodiciotto.persistence.dao.DrugPrescriptionDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;

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

@WebServlet(urlPatterns = {"/restricted/general_practitioner/drugs"})
public class DrugsServlet extends HttpServlet {
    private static final List<DrugSearchResult> ALL_INTERNAL_DRUGS = new ArrayList<>();
    private static List<DrugType> ALL_DRUGS = new ArrayList<>();

    /*
    TODO It's still testing time, please do not pay attention
     */
    private DrugPrescriptionDAO drugPrescriptionDAO;
    private DrugTypeDAO drugTypeDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
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

        if (user instanceof Patient) {
            doPost(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String requestType = request.getParameter("requestType");

        switch (requestType) {
            case "drugSearch": {
                if (user instanceof GeneralPractitioner) {
                    String userInput = request.getParameter("term");

                    List<DrugSearchResult> results;

                    if (userInput == null) {
                        results = ALL_INTERNAL_DRUGS;
                    } else {
                        List<DrugSearchResult> tmpResults = new ArrayList<>();
                        ALL_INTERNAL_DRUGS.stream().filter(exam_SearchResult_
                                -> (exam_SearchResult_.getText().toLowerCase().contains(userInput.toLowerCase()))).forEach(tmpResults::add);
                        results = tmpResults;
                    }

                    Gson gson = new Gson();
                    response.setContentType("application/json");
                    response.getWriter().write(gson.toJson(new Results(results.toArray(new DrugSearchResult[0]))));
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
                    throw new ServletException("Error with DAOs in DrugsServlet", e);
                } catch (NumberFormatException e) {
                    throw new ServletException("Error DrugID is null", e);
                }
                break;
            }
        }
    }

    private static class DrugSearchResult implements Serializable {
        private Integer id;
        private String text;

        DrugSearchResult(Integer id, String text) {
            this.id = id;
            this.text = text;
        }

        public String getText() {
            return text;
        }

    }

    private static class Results implements Serializable {
        private DrugSearchResult[] results;

        Results(DrugSearchResult[] results) {
            this.results = results;
        }
    }
}