package com.studium.member.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.studium.member.model.service.MemberService;
import com.studium.member.model.vo.Member;

/**
 * Servlet implementation class AddmyInfoEnteredServlet
 */
@WebServlet("/myPage/addmyInfoEntered")
public class AddmyInfoEnteredServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddmyInfoEnteredServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("loginMember");
		int no=Integer.parseInt(request.getParameter("no"));
		String phone=request.getParameter("phone");
		String birth=request.getParameter("birthday");
		String gender=request.getParameter("gender");
		
		String zipcode=request.getParameter("zipcode");
		String address1=request.getParameter("address1");
		String address2=request.getParameter("address2");

	
		// 수정한 내용
		Member m=new Member();
		m.setMemPhone(phone);
		m.setMemZipCode(zipcode);
		m.setMemAddress1(address1);
		m.setMemAddress2(address2);
		System.out.println("멤버객체"+m);
		
		MemberService ms=new MemberService();
		//회원정보 수정
		int result=ms.modifyMember(m, id);
		String msg="";
		String loc="/";
		String view="";
		//해당 아이디로  수정된 멤버객체 가지고옴
		m=ms.selectNo(no);
		
		if(result>0) {
			//회원정보수정성공
			request.setAttribute("member", m);
			request.getRequestDispatcher("/views/myPage/myInfo.jsp")
			.forward(request,response);
			
		} else {
			//회원정보수정 실패
			msg="회원 정보 수정이 실패하였습니다.";
			view="/views/common/msg.jsp";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			request.getRequestDispatcher(view).forward(request, response);
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