package it.unitn.web.centodiciotto.servlets.shared;


import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.centodiciotto.services.CryptoService;
import it.unitn.web.centodiciotto.services.ServiceException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/restricted/change_password")
public class PasswordChangeServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("DAOFactory is null.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            try {
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                CryptoService cryptoService = CryptoService.getInstance();

                if (cryptoService.isCurrentPassword(user.getID(), oldPassword)) {
                    cryptoService.changePassword(user.getID(), newPassword);
                    response.setStatus(200);
                } else {
                    response.setStatus(400);
                }
            } catch (ServiceException e) {
                response.setStatus(400);
                throw new ServletException("Failed to change password: ", e);
            }
        }
    }
}
