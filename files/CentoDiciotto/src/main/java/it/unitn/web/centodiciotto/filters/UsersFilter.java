/*
 * AA 2018-2019
 * Introduction to Web Programming
 * Lab 12 - Shopping List Implementation
 * UniTN
 */
package it.unitn.web.centodiciotto.filters;

import it.unitn.disi.wp.commons.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.disi.wp.commons.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.dao.UserDAO;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter that check if the user is authenticated (and authorized).
 *
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
public class UsersFilter implements Filter {

    private static final boolean DEBUG = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public UsersFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (DEBUG) {
            log("ShoppingListsFilter:DoBeforeProcessing");
        }

        if (request instanceof HttpServletRequest) {
            ServletContext servletContext = request.getServletContext();

            String contextPath = servletContext.getContextPath();
            if (contextPath.endsWith("/")) {
                contextPath = contextPath.substring(0, contextPath.length() - 1);
            }
            request.setAttribute("contextPath", contextPath);

            HttpSession session = ((HttpServletRequest) request).getSession(false);
            User authenticatedUser = null;
            if (session != null) {
                authenticatedUser = (User) session.getAttribute("user");
            }
            if (authenticatedUser != null) {
                String avatarPath = "../images/avatars/" + authenticatedUser.getAvatarPath();
                request.setAttribute("avatarPath", avatarPath);

                if (!authenticatedUser.getEmail().equals("stefano.chirico@unitn.it")) {

                    String requestUrl = (String) request.getAttribute(RequestDispatcher.FORWARD_REQUEST_URI);
                    if (requestUrl == null) {
                        requestUrl = ((HttpServletRequest) request).getHeader("referer");
                    }
                    if (requestUrl == null) {
                        requestUrl = contextPath + "/shopping.lists.html";
                    }
                    ((HttpServletResponse) response).sendRedirect(((HttpServletResponse) response).encodeRedirectURL(requestUrl));
                    return;
                }
            }

            DAOFactory daoFactory = (DAOFactory) request.getServletContext().getAttribute("daoFactory");
            if (daoFactory == null) {
                throw new RuntimeException(new ServletException("Impossible to get dao factory for user storage system"));
            }
            try {
                UserDAO userDao = daoFactory.getDAO(UserDAO.class);
                if (userDao != null) {
                    request.setAttribute("userDao", userDao);
                }
            } catch (DAOFactoryException ex) {
                throw new RuntimeException(new ServletException("Impossible to get dao factory for user storage system", ex));
            }
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (DEBUG) {
            log("ShoppingListsFilter:DoAfterProcessing");
        }
        //Nothing to post-process
    }

    /**
     * @param request  The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain    The filter chain we are processing
     * @throws IOException      if an input/output error occurs
     * @throws ServletException if a servlet error occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        if (DEBUG) {
            log("ShoppingListsFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        Throwable problem = null;
        try {
            chain.doFilter(request, response);
        } catch (IOException | ServletException | RuntimeException ex) {
            problem = ex;
            log(ex.getMessage());
//            ex.printStackTrace();
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            ((HttpServletResponse) response).sendError(500, problem.getMessage());
        }
    }

    /**
     * Return the filter configuration object for this filter.
     *
     * @return
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    @Override
    public void destroy() {
    }

    /**
     * Init method for this filter
     *
     * @param filterConfig
     */
    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (DEBUG) {
                log("ShoppingListsFilter:Initializing filter");
            }
        }
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

    public void log(String msg, Throwable t) {
        filterConfig.getServletContext().log(msg, t);
    }
}