package it.unitn.web.centodiciotto.servlets;

import com.alibaba.fastjson.JSONObject;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.entities.*;
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

                String displayName = "default";
                String photoPath = null;
                GeneralPractitioner practitioner = null;

                if (user instanceof Patient) {
                    practitioner = practitionerDAO.getByPrimaryKey(((Patient) user).getPractitionerID());
                    photoPath = PhotoService.getLastPhoto((Patient) user);
                    displayName = ((Patient) user).getFirstName();
                } else if (user instanceof GeneralPractitioner) {
                    displayName = ((GeneralPractitioner) user).getFirstName();
                } else if (user instanceof SpecializedDoctor) {
                    displayName = ((SpecializedDoctor) user).getFirstName();
                } else if (user instanceof Chemist) {
                    displayName = ((Chemist) user).getName();
                } else if (user instanceof HealthService) {
                    displayName = ((HealthService) user).getOperatingProvince() + " Health Service";
                }

                request.getSession().setAttribute("user", user);
                request.getSession().setAttribute("practitioner", practitioner);
                request.getSession().setAttribute("photoPath", photoPath);
                request.getSession().setAttribute("role", role);
                request.getSession().setAttribute("displayName", displayName);

                jobj.put("url", response.encodeRedirectURL(contextPath + "restricted/user"));
            }
            response.getWriter().write(jobj.toString());
        } catch (RuntimeException | DAOException ex) {
            throw new ServletException("Impossible to retrieve the user.", ex);
        }
    }
}
