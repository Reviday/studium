package com.studium.story.model.service;

import static common.template.JDBCTemplate.close;
import static common.template.JDBCTemplate.commit;
import static common.template.JDBCTemplate.getConnection;
import static common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.studium.story.model.dao.StoryDao;
import com.studium.story.model.vo.Story;

public class StoryService {
	
	private StoryDao dao=new StoryDao();
	
	public Story selectBoard(int no, boolean hasRead) {
		Connection conn=getConnection();
		 Story s=dao.selectStory(conn,no);
		if(!hasRead && s!=null) {
			int result=dao.updateReadCount(conn,no);
			if(result>0) {commit(conn);}
			else {rollback(conn);}
		}
		
		close(conn);
		return s;
	}
	public List<Story> selectStoryList() {
		Connection conn=getConnection();
		List<Story> list=dao.selectStoryList(conn);
		close(conn);
		return list;
	}
	public List<Story> selectForeignlanguageList() {
		Connection conn=getConnection();
		List<Story> list=dao.selectForeignlanguageList(conn);
		close(conn);
		return list;
	}
	public List<Story> selectProgrammingList() {
		Connection conn=getConnection();
		List<Story> list=dao.selectProgrammingList(conn);
		close(conn);
		return list;
	}
	public List<Story> selectPublicofficerList() {
		Connection conn=getConnection();
		List<Story> list=dao.selectPublicofficerList(conn);
		close(conn);
		return list;
	}
	public List<Story> selectCertificateList() {
		Connection conn=getConnection();
		List<Story> list=dao.selectCertificateList(conn);
		close(conn);
		return list;
	}
	public List<Story> selectEmploymentList() {
		Connection conn=getConnection();
		List<Story> list=dao.selectEmploymentList(conn);
		close(conn);
		return list;
	}
	public int selectTotalnumberList() {
		Connection conn=getConnection();
		int result=dao.selectTotalnumberList(conn);
		close(conn);
		return result;
	}
	public int selectForeignlanguagenumberList() {
		Connection conn=getConnection();
		int result=dao.selectForeignlanguagenumberList(conn);
		close(conn);
		return result;
	}
	public int selectProgrammingnumberList() {
		Connection conn=getConnection();
		int result=dao.selectProgrammingnumberList(conn);
		close(conn);
		return result;
	}
	public int selectPublicofficernumberList() {
		Connection conn=getConnection();
		int result=dao.selectPublicofficernumberList(conn);
		close(conn);
		return result;
	}
	public int selectCertificatenumberList() {
		Connection conn=getConnection();
		int result=dao.selectCertificatenumberList(conn);
		close(conn);
		return result;
	}
	public int selectEmploymentnumberList() {
		Connection conn=getConnection();
		int result=dao.selectEmploymentnumberList(conn);
		close(conn);
		return result;
	}
	public List<Story> selectPstudyStory(int no){
		Connection conn=getConnection();
		List<Story> list=dao.selectPstudyStory(conn,no);
		close(conn);
		return list;
	}
	

}
