package com.studium.admin.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studium.admin.model.vo.FAQ;
import com.studium.admin.service.AdminBoardService;
import com.studium.member.model.vo.Member;
import com.studium.util.model.service.SideMenuElementService;
import com.studium.util.model.vo.SideMenuElement;

import common.template.PaginationTemplate;

/**
 * Servlet implementation class AdminBoardFAQDeleteServlet
 */
@WebServlet("/AdminBoardDeleteFAQ")
public class AdminBoardFAQDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminBoardFAQDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember != null && loginMember.getMemCode() == 'M') {
		String faqNo = request.getParameter("no");

		AdminBoardService service=new AdminBoardService();
		int result = service.deleteFAQ(faqNo);
		int totalData=service.selectCountFAQ();
		String URLmapping="/AdminBoardDeleteFAQ"; // 패턴을 넘겨주기 위한 변수
		PaginationTemplate pt=new PaginationTemplate(request, totalData, URLmapping); // 페이징 처리 
		List<FAQ> list=service.selectFAQList(pt.getcPage(),pt.getNumPerPage());
		request.setAttribute("list",list);
		request.setAttribute("cPage", pt.getcPage());
		request.setAttribute("pageBar", pt.getPageBar());
		request.setAttribute("numPerPage", pt.getNumPerPage());
		
		List<SideMenuElement> elements=new SideMenuElementService().selectElements("adminboard");
		request.setAttribute("elements", elements);
		
		request.getRequestDispatcher("/views/adminBoard/commonFAQ.jsp")
				.forward(request,response);
		}else {
			String msg = "로그인이 필요합니다.";
			String loc = "/";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
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
