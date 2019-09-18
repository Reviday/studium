package com.studium.madang.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studium.madang.model.service.FreeMadangService;
import com.studium.madang.model.vo.FreeMadang;
import com.studium.util.model.service.SideMenuElementService;
import com.studium.util.model.vo.SideMenuElement;

/**
 * Servlet implementation class FreeMadangViewServlet
 */
@WebServlet("/madnag/freeMadangView")
public class FreeMadangViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeMadangViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 자유마당이므로 모든 회원,비회원에게 열람권이 부여된다.
		// 때문에 파라미터로 받을 인수는 글번호와 cPage 뿐이다.
		int no=Integer.parseInt(request.getParameter("madangNo"));
		int cPage=Integer.parseInt(request.getParameter("cPage"));
		
		FreeMadang fm=new FreeMadangService().selectMadang(no);
		List<SideMenuElement> elements=new SideMenuElementService().selectElements("madang");
		String view="";
		if(fm!=null)
		{
			view="/views/madang/freeMadangView.jsp";
			request.setAttribute("fm", fm);
			request.setAttribute("cPage", cPage);
		}
		else
		{
			String msg="게시글이 존재하지 않습니다.";
			String loc="/madang/freeMadangList";
			view="/views/common/msg.jsp";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
		}
		request.setAttribute("choice", "free");
		request.setAttribute("elements", elements);
		request.getRequestDispatcher(view).forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}