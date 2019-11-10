package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;
import java.util.logging.Level;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private GeneralPractitionerDAO practitionerDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
        try {
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServletException("Error in DAO retrieval: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
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
        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            try {
                String userID = request.getParameter("userID");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String rememberMe = request.getParameter("rememberMe");
                String referrer = request.getParameter("referrer");

                CryptoService cryptoService = CryptoService.getInstance();
                User user = cryptoService.authenticate(userID, password, role);
                String json;

                if (user == null) {
                    response.setStatus(400);
                    json = "{\"url\":\"\"}";
                } else {
                    if (rememberMe != null && rememberMe.equals("on")) {
                        request.getSession().setMaxInactiveInterval(2592000);
                    }

                    request.getSession().setAttribute("user", user);
                    request.getSession().setAttribute("role", role);
                    request.getSession().setAttribute("displayName", getDisplayName(user));

                    response.setStatus(200);
                    if (!Objects.equals(referrer, "")
                            && !referrer.equals(request.getContextPath() + "/restricted/logout_handler")) {
                        json = "{\"url\":\"" + referrer.replace('$', '&') + "\"}";
                    } else {
                        json = "{\"url\":\"" + response.encodeRedirectURL(contextPath + "restricted/user") + "\"}";
                    }

                    java.util.logging.Logger.getLogger("SCE").log(Level.INFO,
                            "User " + userID + " logged in with role "
                                    + role + " - redirected with JSON " + json);
                }

                response.getWriter().write(json);
            } catch (ServiceException e) {
                throw new ServletException("Failed to authenticate user: ", e);
            }
        }
    }

    private String getDisplayName(User user) {
        String displayName;
        if (user instanceof Patient) {
            displayName = ((Patient) user).getFirstName();
        } else if (user instanceof GeneralPractitioner) {
            displayName = ((GeneralPractitioner) user).getFirstName();
        } else if (user instanceof SpecializedDoctor) {
            displayName = ((SpecializedDoctor) user).getFirstName();
        } else if (user instanceof Chemist) {
            displayName = ((Chemist) user).getName();
        } else if (user instanceof HealthService) {
            displayName = ((HealthService) user).getOperatingProvince().getName() + " HS";
        } else {
            displayName = "default";
        }
        return displayName;
    }
}
