package it.unitn.web.centodiciotto.servlets;

import com.alibaba.fastjson.JSONObject;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Crypto;
import it.unitn.web.utils.PhotoService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession(false) != null && request.getSession().getAttribute("user") != null) {
            String contextPath = getServletContext().getContextPath();
            if (!contextPath.endsWith("/")) {
                contextPath += "/";
            }

            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String rememberMe = request.getParameter("remember-me");

        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        try {
            User user = Crypto.authenticate(email, password, role);
            JSONObject jobj = new JSONObject();

            if (user == null) {
                response.setStatus(400);
                jobj.put("url", "");
            } else {
                if (rememberMe != null && rememberMe.equals("on")) {
                    request.getSession().setMaxInactiveInterval(2592000);
                }
                response.setStatus(200);
                request.getSession().setAttribute("user", user);

                if (user instanceof Patient) { // Inserisco il medico del paziente nelle variabili
                    GeneralPractitioner practitioner =
                            practitionerDAO.getByPrimaryKey(((Patient) user).getGeneralPractitionerEmail());

                    String photoPath = PhotoService.getLastPhoto((Patient) user);

                    request.getSession().setAttribute("practitioner", practitioner);
                    request.getSession().setAttribute("photo_path", photoPath);
                }

                jobj.put("url", response.encodeRedirectURL(contextPath + "restricted/user"));
            }
            response.getWriter().write(jobj.toString());
        } catch (RuntimeException | DAOException ex) {
            throw new ServletException("Impossible to retrieve the user.", ex);
        }
    }
}
