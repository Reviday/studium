package com.studium.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studium.admin.service.AdminService;
import com.studium.member.model.vo.Member;

import common.template.PaginationTemplate;

/**
 * Servlet implementation class AdminInqueryUpdateMemberServlet
 */
@WebServlet("/adminUpdateMember")
public class AdminInqueryUpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminInqueryUpdateMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String grade = request.getParameter("memberGradeList");
		String status = request.getParameter("memberStatusList");
		String memNo = request.getParameter("memUpdateNo");
		
		AdminService service = new AdminService();

		int result = service.updateMember(memNo, grade, status); 
		
		int totalData=service.selectCountMemberSearch(grade, status);
		String URLmapping="/adminUpdateMember"; // 패턴을 넘겨주기 위한 변수
		PaginationTemplate pt=new PaginationTemplate(request, totalData, URLmapping); // 페이징 처리 
		List<Member> list=service.selectMemberList(pt.getcPage(),pt.getNumPerPage());
		
		request.setAttribute("list",list);
		request.setAttribute("cPage", pt.getcPage());
		request.setAttribute("pageBar", pt.getPageBar());
		request.setAttribute("numPerPage", pt.getNumPerPage());
		request.getRequestDispatcher("/views/admin/memberInquery.jsp")
				.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
