package common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class PasswordEncryptFilter
 */
@WebFilter(servletNames = {
					"LoginServlet",
					"RegisterServlet",
					"MyInfoServlet",
					"ModifyMemberServlet",
					"CheckOriginPwServlet"
					
			})
public class PasswordEncryptFilter implements Filter {

    /**
     * Default constructor. 
     */
    public PasswordEncryptFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		EncryptPasswordWrapper encPw=new EncryptPasswordWrapper((HttpServletRequest)request);
		
		// pass the request along the filter chain
		chain.doFilter(encPw, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
