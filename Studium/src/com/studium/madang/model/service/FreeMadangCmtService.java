package com.studium.madang.model.service;

import static common.template.JDBCTemplate.close;
import static common.template.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.studium.madang.model.dao.FreeMadangCmtDao;
import com.studium.madang.model.vo.FreeMadangCmt;

public class FreeMadangCmtService {
	
	private FreeMadangCmtDao dao=new FreeMadangCmtDao();
	
	public int selectCountList(int madangNo) {
		Connection conn=getConnection();
		int result=dao.selectCountList(conn, madangNo);
		close(conn);
		return result;
	}
	
	public List<FreeMadangCmt> selectCmtList(int madangNo, int cPage, int numPerPage) {
		Connection conn=getConnection();
		List<FreeMadangCmt> list=dao.selectCmtList(conn, madangNo, cPage, numPerPage);
		close(conn);
		return list;
	}
}