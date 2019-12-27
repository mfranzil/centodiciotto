package it.unitn.web.centodiciotto.servlets;

import it.unitn.web.centodiciotto.persistence.entities.*;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

/**
 * LoginServlet for handling requests to /login
 * <p>
 * GET requests pass through as long as the user isn't logged in.
 * <p>
 * POST requests authenticate the user with a {@link CryptoService} instance. If the authentication is
 * successful, initialize a new {@link javax.websocket.Session} (eventually setting its duration to infinity
 * if the rememberMe flag was set during login), sets the {@code user}, {@code role} and {@code displayName}
 * session attributes and eventually redirects the user to the referral URL received in the request (which
 * will be filtered by an {@link it.unitn.web.centodiciotto.filters.AuthenticationFilter} for role compatibility)
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private String contextPath;

    private CryptoService cryptoService;

    @Override
    public void init() throws ServletException {
        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        try {
            cryptoService = CryptoService.getInstance();
        } catch (ServiceException e) {
            throw new ServletException("Error in initializing services: ", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        response.setContentType("application/json");

        if (request.getSession() != null && request.getSession().getAttribute("user") != null) {
            response.sendRedirect(response.encodeRedirectURL(contextPath));
        } else {
            try {
                String userID = request.getParameter("userID");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String rememberMe = request.getParameter("rememberMe");
                String referrer = request.getParameter("referrer"); // Nullable

                String json;

                if (userID == null || password == null || role == null) {
                    response.setStatus(400);
                    json = "{\"error\": \"Malformed input. Please fill all parameters correctly.\"}";
                    writer.write(json);
                    Logger.getLogger("C18").severe(json);
                } else {
                    User user = cryptoService.authenticate(userID, password, role);

                    if (user == null) {
                        response.setStatus(422);
                        json = "{\"error\":\"Invalid username or password.\"}";
                        writer.write(json);
                        Logger.getLogger("C18").severe(json);
                    } else {
                        if (rememberMe != null && rememberMe.equals("on")) {
                            request.getSession().setMaxInactiveInterval(2592000);
                        }

                        request.getSession().setAttribute("user", user);
                        request.getSession().setAttribute("role", role);
                        request.getSession().setAttribute("displayName", getDisplayName(user));

                        // To avoid corner cases in which the user tries to visit the logout page,
                        // which is restricted, and would be redirected immediately to it upon login

                        if (referrer == null || referrer.equals("")
                                || referrer.equals(request.getContextPath() + "restricted/logout_handler")) {
                            json = "{\"url\":\"" + response.encodeRedirectURL(contextPath + "restricted/user") + "\"}";
                        } else {
                            json = "{\"url\":\"" + referrer.replace('$', '&') + "\"}";
                        }

                        Logger.getLogger("C18").info("User " + userID + " logged in with role "
                                + role + " with JSON " + json);
                        writer.write(json);
                    }
                }
            } catch (ServiceException e) {
                throw new ServletException("Failed to authenticate user: ", e);
            }
        }
    }

    /**
     * Returns a short variant of a {@link User} name for navbar purposes.
     *
     * @param user the User from which to retrieve the name
     * @return a {@link String} representing the displayed short name
     */
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
