package it.unitn.web.centodiciotto.filters;

import it.unitn.web.centodiciotto.persistence.entities.HealthService;
import it.unitn.web.centodiciotto.persistence.entities.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter for requests directed to the XLS folder. Users are given access if and only if
 * they are an Health Service trying to access their reports (which are identified by the Province ID).
 */
@WebFilter("/xls/*")
public class ReportAccessFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        ServletContext servletContext = request.getServletContext();
        HttpSession session = request.getSession(false);
        User user;

        String contextPath = servletContext.getContextPath();
        if (!contextPath.endsWith("/")) {
            contextPath += "/";
        }

        if (session != null) {
            user = (User) session.getAttribute("user");
            if (user instanceof HealthService) {
                String[] tmp = request.getRequestURI().split("/");
                String fileName = tmp[tmp.length - 1];
                String operatingProvinceID = ((HealthService) user).getOperatingProvince().getID().toUpperCase();

                // Check if the first two letters of the file match the operating province of the User requesting it
                if (!fileName.equals("report.xlsx") &&
                        fileName.substring(0, 2).toUpperCase().equals(operatingProvinceID) &&
                        fileName.charAt(2) == '_') {
                    chain.doFilter(req, res);
                    return;
                }
            }
        }
        response.sendRedirect(response.encodeRedirectURL(contextPath));
    }

    @Override
    public void init(FilterConfig filterConfig) {
    }


    @Override
    public void destroy() {
    }
}