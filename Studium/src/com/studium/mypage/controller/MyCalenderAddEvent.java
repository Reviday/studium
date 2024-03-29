package com.studium.mypage.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.studium.mypage.model.service.MyDibsService;
import com.studium.mypage.model.vo.MyCalendar;

/**
 * Servlet implementation class MyCalenderAddEvent
 */
@WebServlet("/MyCalender")
public class MyCalenderAddEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyCalenderAddEvent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject obj = new JSONObject();
		MyCalendar m = new MyCalendar();
		
		System.out.println("여기 넘어옴 ??");
		String title=request.getParameter("edit-title");
		java.sql.Date datestart = java.sql.Date.valueOf(request.getParameter("p_datestart"));
		java.sql.Date dateend = java.sql.Date.valueOf(request.getParameter("p_dateend"));
		System.out.println(datestart);
		System.out.println(dateend);
		/*
		 * java.util.Date editStart; try { editStart = new
		 * java.text.SimpleDateFormat("yyyy-mm-dd").parse(request.getParameter(
		 * "edit-start")); java.sql.Date sqlDateStart = new
		 * java.sql.Date(editStart.getTime()); System.out.println(editStart+"형식이 어캐되냐");
		 * System.out.println(sqlDateStart); m.setEditStart(sqlDateStart); } catch
		 * (ParseException e) { // TODO Auto-generated catch block e.printStackTrace();
		 * } java.util.Date editEnd; try { editEnd = new
		 * java.text.SimpleDateFormat("yyyy-MM-DD").parse(request.getParameter(
		 * "edit-end")); java.sql.Date sqlDateEnd = new
		 * java.sql.Date(editEnd.getTime()); System.out.println(sqlDateEnd);
		 * m.setEditEnd(sqlDateEnd); } catch (ParseException e) { // TODO Auto-generated
		 * catch block e.printStackTrace(); }
		 */
		String descsciption=request.getParameter("edit-desc");
		String backgroundColor=request.getParameter("color");
		System.out.println(title+descsciption+backgroundColor);
		int mNo=Integer.parseInt(request.getParameter("mNo"));
		String mName=request.getParameter("mName");
		MyDibsService service =new MyDibsService();
		m.setEditStart(datestart);
		m.setMemNo(mNo);
		m.setMemberName(mName);
		m.setEditTitle(title);
		m.setEditStart(datestart);
		m.setEditEnd(dateend);
		
		m.setEditcolor(backgroundColor);
		m.setEditdesc(descsciption);
		int result =service.insertCalendar(m);
		obj.put("m",m);
		System.out.println(m);
		System.out.println(obj);
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
