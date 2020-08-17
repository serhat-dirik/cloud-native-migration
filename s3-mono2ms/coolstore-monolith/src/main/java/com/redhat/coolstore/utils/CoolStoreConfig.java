package com.redhat.coolstore.utils;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CoolStoreConfig
 */
@WebServlet("/coolstore.json")
public class CoolStoreConfig extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String ENV_MONOLITH="MONOLITH";
    private static final String ENV_API_ENDPOINT="API_ENDPOINT";
    private static final String ENV_SECURE_API_ENDPOINT="SECURE_API_ENDPOINT";
    private static final String ENV_SSO_ENABLED="SSO_ENABLED";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CoolStoreConfig() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * Prints CoolStore config json. The config values gathered from the system environment variable, otherwise filled with the default values
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().append("{")
		.append("\"").append(ENV_MONOLITH).append("\": ")
		.append(System.getenv(ENV_MONOLITH)==null?"true":System.getenv(ENV_MONOLITH)).append(",")
		.append("\"").append(ENV_API_ENDPOINT).append("\": ")
		.append("\"").append(System.getenv(ENV_API_ENDPOINT)==null?"":System.getenv(ENV_API_ENDPOINT)).append("\",")
		.append("\"").append(ENV_SECURE_API_ENDPOINT).append("\": ")
		.append("\"").append(System.getenv(ENV_SECURE_API_ENDPOINT)==null?"":System.getenv(ENV_SECURE_API_ENDPOINT)).append("\",")
		.append("\"").append(ENV_SSO_ENABLED).append("\": ")
		.append(System.getenv(ENV_SSO_ENABLED)==null?"false":System.getenv(ENV_SSO_ENABLED))
		.append("}")
		.flush();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
 

}
