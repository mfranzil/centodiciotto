package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.entities.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LogoutServlet for handling requests to /restricted/logout_handler.
 * <p>
 * GET and POST requests invalidate the session and redirect the user to the main page.
 */
@SuppressWarnings({"FieldCanBeLocal", "unused", "DuplicatedCode"})
@WebServlet("/restricted/logout_handler")
public class LogoutServlet extends HttpServlet {

    private String contextPath;

    @Override
    public void init() {
        contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            session.setAttribute("user", null);
            session.setAttribute("role", null);
            session.setAttribute("displayName", null);
            session.invalidate();

            response.sendRedirect(response.encodeRedirectURL(contextPath));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        processRequest(request, response);
    }
}
