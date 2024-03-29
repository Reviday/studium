package com.studium.fstudy.model.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.studium.fstudy.model.service.FstudyService;

/**
 * Servlet implementation class PstudyDibssServlet
 */
@WebServlet("/fstudy/fstudyDibss")
public class FstudyDibssServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FstudyDibssServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		찜하기 서블릿
		int no=Integer.parseInt(request.getParameter("pNo"));
		int mNo=Integer.parseInt(request.getParameter("mNo"));
		String  A= request.getParameter("A"); //새로운 값 넣어서 다른값이면 추가 0이면 삭제
		FstudyService service=new FstudyService(); 
		JSONObject obj = new JSONObject();
		if(A.equals("0")){
			// 찜하기 풀기 쿼리
			int result=service.fstudyDibsDelete(no,mNo);
			String a="0";
			obj.put("result",a);
			response.setContentType("application/x-json; charset=UTF-8");
			response.getWriter().print(a);

		}else{
			// 찜하기 쿼리
		
		int result=service.fstudyDibs(no,mNo);
		String b="1";
		obj.put("result",b);
		//request.setAttribute("json", json);
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(b);
		
		
		}
	
		
		

	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
