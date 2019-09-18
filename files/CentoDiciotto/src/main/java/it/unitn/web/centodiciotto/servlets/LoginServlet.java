package it.unitn.web.centodiciotto.servlets;

import com.alibaba.fastjson.JSONObject;
import it.unitn.web.centodiciotto.persistence.dao.GeneralPractitionerDAO;
import it.unitn.web.centodiciotto.persistence.dao.PhotoDAO;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.GeneralPractitioner;
import it.unitn.web.centodiciotto.persistence.entities.Patient;
import it.unitn.web.centodiciotto.persistence.entities.Photo;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;
import it.unitn.web.utils.Common;

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

    private UserDAO userDAO;
    private GeneralPractitionerDAO practitionerDAO;
    private PhotoDAO photoDAO;

    @Override
    public void init() throws ServletException {
        DAOFactory daoFactory = (DAOFactory) super.getServletContext().getAttribute("daoFactory");
        if (daoFactory == null) {
            throw new ServletException("Impossible to get dao factory for user storage system");
        }
        try {
            userDAO = daoFactory.getDAO(UserDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            photoDAO = daoFactory.getDAO(PhotoDAO.class);
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

        String contextPath = getServletContext().getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        try {
            User user = userDAO.getByEmailAndPassword(email, password, role);
            JSONObject jobj = new JSONObject();

            if (user == null) {
                response.setStatus(400);

                jobj.put("url", "");
            } else {
                response.setStatus(200);
                request.getSession().setAttribute("user", user);

                if (user instanceof Patient) { // Inserisco il medico del paziente nelle variabili
                    GeneralPractitioner practitioner =
                            practitionerDAO.getByPrimaryKey(((Patient) user).getGeneralPractitionerEmail());
                    Photo photo = photoDAO.getLastPhotoByEmail(user.getEmail());

                    String photoPath = Common.getPhotoPosition(getServletContext(), user.getEmail(), photo.getPhotoid());

                    request.getSession().setAttribute("practitioner", practitioner);
                    request.getSession().setAttribute("photo_path", photoPath);
                }

                jobj.put("url", response.encodeRedirectURL(contextPath + "restricted/user"));
            }
            response.getWriter().write(jobj.toString());
        } catch (DAOException ex) {
            throw new ServletException("Impossible to retrieve the user.", ex);
        }
    }
}
