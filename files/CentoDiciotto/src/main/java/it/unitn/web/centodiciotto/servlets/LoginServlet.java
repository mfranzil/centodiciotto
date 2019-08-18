package it.unitn.web.centodiciotto.servlets;

import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOException;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.disi.wp.commons.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet that handles the login web page.
 *
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
public class LoginServlet extends HttpServlet {

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            userDao = daoFactory.getDAO(UserDAO.class);
        } catch (DAOFactoryException ex) {
            throw new ServletException("Impossible to get dao factory for user storage system", ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     * @author Stefano Chirico
     * @since 1.0.0.190519
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        try {
            User user = userDao.getByEmailAndPassword(email, password);
            // LA SEGUENTE CAGATA E' TEMPORANEA

            if (user == null || !user.getRole().equals(role)) {
                request.setAttribute("loginResult", true);
                response.sendRedirect(response.encodeRedirectURL(contextPath + "login"));
            } else {
                request.getSession().setAttribute("user", user);
                response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/user"));
               /* } else {
                    response.sendRedirect(response.encodeRedirectURL(contextPath + "restricted/shopping.lists.html?id=" + user.getId()));
                }*/
            }
        } catch (DAOException ex) {
            //TODO: log exception
            request.getServletContext().log("Impossible to retrieve the user", ex);
        }
    }
}
