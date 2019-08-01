
package it.unitn.web.centodiciotto.services;

import com.alibaba.fastjson.JSON;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOException;
import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.disi.wp.commons.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.DatatablesResponse;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;
import java.io.IOException;
import java.util.List;

/**
 * REST Web Service
 *
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
@Path("users")
public class UsersService {

    @Context
    private UriInfo context;

    @Context
    private HttpServletRequest request;

    @Context
    private HttpServletResponse response;

    private ServletContext servletContext;

    private UserDAO userDao;

    /**
     * Creates a new instance of LanguagesService
     */
    public UsersService() {
    }

    @Context
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
        if (servletContext != null) {
            DAOFactory daoFactory = (DAOFactory) servletContext.getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new RuntimeException(new ServletException("Impossible to get dao factory for storage system"));
            }
            try {
                userDao = daoFactory.getDAO(UserDAO.class);
            } catch (DAOFactoryException ex) {
                throw new RuntimeException(new ServletException("Impossible to get dao factory for user storage system", ex));
            }
        }
    }

//    @GET
//    @Produces(MediaType.APPLICATION_JSON)
//    public String getU() {
//        return "{ \"users\": [1, 2, 3, 4] }";
//    }

    /**
     * Retrieves representation of an instance of
     * UsersService
     *
     * @param searchValue
     * @param draw
     * @param start
     * @param length
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getUsers() {
        try {
            Integer draw = 0;
            Long start = 0L;
            Long length = -1L;
            String searchValue = request.getParameter("search[value]");
            String drawParameter = request.getParameter("draw");
            if (drawParameter != null) {
                draw = Integer.parseInt(drawParameter);
            }
            String startParameter = request.getParameter("start");
            if (startParameter != null) {
                start = Long.parseLong(startParameter);
            }
            String lengthParameter = request.getParameter("length");
            if (lengthParameter != null) {
                length = Long.parseLong(lengthParameter);
            }

            Long usersCount = userDao.getCount();
            if (length < 0) {
                length = usersCount - start;
            }
            List<User> users = userDao.pageBySearchValue(searchValue, start, length);

            DatatablesResponse tableResponse = new DatatablesResponse(draw, usersCount, usersCount, users);

            String usersJsoned = JSON.toJSONString(tableResponse);

//            response.setContentType("application/json");
//            PrintWriter out = response.getWriter();
//            out.append(usersJsoned);
//            out.flush();
            return usersJsoned;

        } catch (DAOException ex) {
            try {
                response.sendError(500, "Impossible to access the persistence layer: " + ex.getMessage());
            } catch (IOException ioex) {
                //TODO handle exception
            }
            return null;
        }
    }

    /**
     * PUT method for updating or creating an instance of UsersService
     *
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
}
