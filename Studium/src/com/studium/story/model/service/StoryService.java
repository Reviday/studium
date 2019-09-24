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

}