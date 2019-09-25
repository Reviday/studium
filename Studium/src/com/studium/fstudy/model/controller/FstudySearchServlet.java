package com.studium.fstudy.model.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studium.category.model.service.CategoryService;
import com.studium.category.model.vo.Category;
import com.studium.fstudy.model.service.FstudyService;
import com.studium.fstudy.model.vo.Fstudy;

/**
 * Servlet implementation class PstudySearchServlet
 */
@WebServlet("/fstudy/search")
public class FstudySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FstudySearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String area=request.getParameter("p_area");
		String day=request.getParameter("p_day");
		String category= request.getParameter("p_category");
		System.out.println(area+day);
		List<Category> listM=new CategoryService().selectTitleM();
		request.setAttribute("categoryM", listM);
		List<Fstudy>fList=new FstudyService().searchFstudy(area, day,category);
		request.setAttribute("fList", fList);
		request.setAttribute("area", area);
		request.setAttribute("day", day);
		request.setAttribute("category",category);
		request.getRequestDispatcher("/views/fstudy/studySearch.jsp").forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
