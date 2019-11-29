package it.unitn.web.centodiciotto.filters;

import it.unitn.web.centodiciotto.persistence.entities.*;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Only filter present for the web application. Its job is to filter incoming requests depending on the
 * requesting account's {@link User} type and on the URL requested.
 */
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        ServletContext servletContext = request.getServletContext();
        HttpSession session = request.getSession(false);
        User user;
        String redirectUrl;

        String contextPath = servletContext.getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        // If the request needs to be redirected to login, adds a referrer parameter for
        // automatic redirect after login. Ampersand & symbols are changed into dollar $ symbols
        // (unused in urls) to avoid ambiguity.
        if (request.getRequestURI() != null) {
            if (request.getQueryString() != null) {
                String originalRequest = request.getRequestURI() + "?"
                        + request.getQueryString().replace('&', '$');
                redirectUrl = contextPath + "login?referrer=" + originalRequest;
            } else {
                redirectUrl = contextPath + "login?referrer=" + request.getRequestURI();
            }
        } else {
            redirectUrl = contextPath + "login";
        }

        // Authorizes access to the user if and only if the session and the user are both not null,
        // and the URL contains the role name given to the user.
        if (session == null) {
            response.sendRedirect(response.encodeRedirectURL(redirectUrl));
        } else {
            user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(response.encodeRedirectURL(redirectUrl));
            } else {
                boolean allowed = true;
                String requestedUrl = request.getRequestURL().toString();

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
                    response.sendRedirect(response.encodeRedirectURL(contextPath));
                } else {
                    chain.doFilter(request, response);
                }
            }
        }
    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig filterConfig) {
    }

}
