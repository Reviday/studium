package com.studium.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studium.admin.service.AdminService;
import com.studium.member.model.vo.Member;
import com.studium.util.model.service.SideMenuElementService;
import com.studium.util.model.vo.SideMenuElement;

import common.template.PaginationTemplate;

/**
 * Servlet implementation class AdminPointManagePointDownServlet
 */
@WebServlet("/admin/memberPointDown")
public class AdminPointManagePointDownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPointManagePointDownServlet() {
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
			String point = request.getParameter("pointDown");
			String[] memberNo = request.getParameterValues("checkMember1");
			String[] memName = request.getParameterValues("memName1");
			String[] memEmail = request.getParameterValues("memEmail1");
			String method = request.getParameter("method");
			int cPage;
			try {
			 cPage= Integer.parseInt(request.getParameter("cPage"));
			}catch(NumberFormatException e) {
				cPage=1;
			}
			
			AdminService service = new AdminService();
			
			service.pointDownContent(point, memberNo, memName, memEmail);

			
			List<Integer> memPoint = service.memberPoint(memberNo);
			
			List<Integer> memberPoint = new ArrayList<Integer>();
			for(int i = 0; i < memberNo.length; i++) {
				int a = memPoint.get(i) - Integer.parseInt(point);
				memberPoint.add(a);
			}
			
			int result = service.memberPointUp(memberNo, memberPoint);
			
			if( result > 0 ) {
				String URLmapping="/admin/memberPointUp"; // 패턴을 넘겨주기 위한 변수
				int totalData=service.selectCountPointMember();
				AdminPaginationTemplate pt=new AdminPaginationTemplate(request, totalData, URLmapping, method); // 페이징 처리 
				List<Member> list=service.selectMemberPointList(cPage,pt.getNumPerPage());
				request.setAttribute("list",list);
				request.setAttribute("cPage", cPage);
				request.setAttribute("pageBar", pt.getPageBar());
				request.setAttribute("numPerPage", pt.getNumPerPage());
				
				List<SideMenuElement> elements=new SideMenuElementService().selectElements("admin");
				request.setAttribute("elements", elements);
				request.getRequestDispatcher("/views/admin/commonPoint.jsp")
						.forward(request,response);
			}
			
			
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
