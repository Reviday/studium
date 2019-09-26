package com.studium.madang.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studium.madang.model.service.BoastMadangService;
import com.studium.madang.model.vo.BoastMadang;

import common.template.LoginCheck;

/**
 * Servlet implementation class BoastMadangWriterEndServlet
 */
@WebServlet("/madang/boast/writeEnd")
public class BoastMadangWriterEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoastMadangWriterEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		new LoginCheck(request, response, 1005);
		
		BoastMadang bm=new BoastMadang();
		bm.setMadangTitle(request.getParameter("subject"));
		bm.setMadangWriterUid(Integer.parseInt(request.getParameter("userUid")));
		bm.setMadangWriterEmail(request.getParameter("userEmail"));
		bm.setMadangWriterName(request.getParameter("userName"));
		bm.setMadangRegisterIp(request.getParameter("REMOTE_ADDR"));
		bm.setMadangContent(request.getParameter("bmarteditor"));
		
		
		//파일 받기 및 넣기
		
		//이미지 받기 및 넣기
		
		//일단 작성 가능상태를 보기위해, 파일/이미지 기능은 제외처리하고 구동시킨다.
		//정상적으로 insert되면 해당 madangNo가 반환된다.
		int madangNo=new BoastMadangService().insertMadang(bm);
		
		String view="/";
		if(madangNo>0) {
			view="/madang/boastMadangView?madangNo="+madangNo+"&cPage=1";
		} else {
			String msg="게시글 작성에 실패하였습니다.";
			String loc="/madang/boastMadangList";
			view="/views/common/msg.jsp";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
		}
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
