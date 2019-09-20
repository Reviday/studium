package com.studium.admin.service;

import static common.template.JDBCTemplate.close;
import static common.template.JDBCTemplate.commit;
import static common.template.JDBCTemplate.getConnection;
import static common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.studium.admin.model.dao.AdminDao;
import com.studium.admin.model.vo.QandA;
import com.studium.member.model.vo.Member;

public class AdminService {

	
	private AdminDao dao = new AdminDao();
	
	public int insertQandA(String content, String email) {
		
		Connection conn=getConnection();
		int result=dao.insertQandA(conn,content, email);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;	
		
	}
	
	public int selectCountQandA() {
		Connection conn=getConnection();
		int result=dao.selectCountQandA(conn);
		close(conn);
		return result;
	}
	
	public int selectCountMember() {
		Connection conn=getConnection();
		int result=dao.selectCountMember(conn);
		close(conn);
		return result;
	}
	
	public int selectCountMemberName(String memberName) {
		Connection conn=getConnection();
		int result=dao.selectCountMemberName(conn, memberName);
		close(conn);
		return result;
	}
	
	public int selectCountMemberSearch(String grade, String status) {
		Connection conn=getConnection();
		int result=dao.selectCountMemberSearch(conn, grade, status);
		close(conn);
		return result;
	}
	
	public List<QandA> selectQandAList(int cPage, int numPerPage){
		Connection conn=getConnection();
		List<QandA> list=dao.selectQandAList(conn,cPage,numPerPage);
		close(conn);
		return list;
	}
	
	public List<Member> selectMemberList(int cPage, int numPerPage){
		Connection conn=getConnection();
		List<Member> list=dao.selectMemberList(conn,cPage,numPerPage);
		close(conn);
		return list;
	}
	
	public List<Member> selectMemberSearchList(int cPage, int numPerPage, String grade, String status) {
		Connection conn = getConnection();
		List<Member> list = dao.selectMemberSearchList(conn, cPage, numPerPage, grade, status);
		close(conn);
		return list;
	}
	
	public List<Member> selectMemberNameList(int cPage, int numPerPage, String memberName){
		Connection conn=getConnection();
		List<Member> list=dao.selectMemberNameList(conn,cPage,numPerPage, memberName);
		close(conn);
		return list;
	}
	
	public int deleteQnAList(String[] deList) {
		Connection conn = getConnection();
		int result = dao.deleteQnAList(conn, deList);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;	 
	}
	
}
