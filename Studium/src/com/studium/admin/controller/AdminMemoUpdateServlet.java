package com.studium.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.studium.admin.service.AdminService;

/**
 * Servlet implementation class AdminMemoUpdateServlet
 */
@WebServlet("/adminMemoUpdate")
public class AdminMemoUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMemoUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memo = request.getParameter("memo");
		String memNo = request.getParameter("memNo");
		
		AdminService service = new AdminService();
		int result = service.updateMemo(memNo, memo);

		String memo1 = service.showMemo(memNo);
		response.setContentType("application/json;charset=UTF-8");
		
		new Gson().toJson(memo1,response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
