package it.unitn.web.centodiciotto.filters;

import it.unitn.web.centodiciotto.persistence.entities.*;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthenticationFilter implements Filter {

    private FilterConfig filterConfig = null;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        ServletContext servletContext = request.getServletContext();
        HttpSession session = ((HttpServletRequest) request).getSession(false);
        User user = null;

        String contextPath = servletContext.getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (session == null) {
            ((HttpServletResponse) response).sendRedirect(((HttpServletResponse) response).encodeRedirectURL(contextPath + "login"));
        } else {
            user = (User) session.getAttribute("user");
            if (user == null) {
                ((HttpServletResponse) response).sendRedirect(((HttpServletResponse) response).encodeRedirectURL(contextPath + "login"));
            } else {
                boolean allowed = true;
                String requestedUrl = ((HttpServletRequest) request).getRequestURL().toString();

                if (!(user instanceof Patient) && requestedUrl.contains("/restricted/patient")) {
                    allowed = false;
                } else if (!(user instanceof GeneralPractitioner) && requestedUrl.contains("/restricted/general_practitioner")) {
                    allowed = false;
                } else if (!(user instanceof SpecializedDoctor) && requestedUrl.contains("/restricted/specialized_doctor")) {
                    allowed = false;
                } else if (!(user instanceof Chemist) && requestedUrl.contains("/restricted/chemist")) {
                    allowed = false;
                } else if (!(user instanceof HealthService) && requestedUrl.contains("/restricted/health_service")) {
                    allowed = false;
                }

                if (!allowed) {
                    ((HttpServletResponse) response).sendRedirect(((HttpServletResponse) response).encodeRedirectURL(contextPath));
                } else {
                    chain.doFilter(request, response);
                }
            }
        }
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    @Override
    public void destroy() {
        this.filterConfig = null;
    }

    @Override
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

}
