package it.unitn.web.centodiciotto.servlets.shared;

import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Crypto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/restricted/password_change_handler")
public class PasswordChangeServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String oldPassword = request.getParameter("old-password");
        String newPassword = request.getParameter("new-password");

        if (Crypto.isCurrentPassword(user.getID(), oldPassword)) {
            Crypto.changePassword(user.getID(), newPassword);
            response.setStatus(200);
        } else {
            response.setStatus(400);
        }
    }
}
