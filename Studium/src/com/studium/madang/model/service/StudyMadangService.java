package com.studium.madang.model.service;

import static common.template.JDBCTemplate.close;
import static common.template.JDBCTemplate.commit;
import static common.template.JDBCTemplate.getConnection;
import static common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.studium.madang.model.dao.StudyMadangDao;
import com.studium.madang.model.vo.StudyMadang;
import com.studium.madang.model.vo.StudyMadangQuestion;

public class StudyMadangService {

	private StudyMadangDao dao = new StudyMadangDao();

	public int selectCountList() {
		Connection conn = getConnection();
		int result = dao.selectCountList(conn);
		close(conn);
		return result;
	}
	
	public int selectCountList(String choiceSub) {
		Connection conn = getConnection();
		int result = dao.selectCountList(conn, choiceSub);
		close(conn);
		return result;
	}

	public List<StudyMadang> selectMadangList(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<StudyMadang> list = dao.selectMadangList(conn, cPage, numPerPage);
		close(conn);
		return list;
	}
	
	public List<StudyMadang> selectMadangList(String mCategory, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<StudyMadang> list = dao.selectMadangList(conn, mCategory, cPage, numPerPage);
		close(conn);
		return list;
	}

	public StudyMadang selectMadang(int no, boolean hasRead) {
		Connection conn = getConnection();
		StudyMadang fm = dao.selectMadang(conn, no);
		if (!hasRead && fm != null) {
			int result = dao.updateReadCount(conn, no);
			if (result > 0)
				commit(conn);
			else
				rollback(conn);
		}
		close(conn);
		return fm;
	}

	public Map<String, StudyMadang> selectPreNext(int madangNo) {
		Connection conn = getConnection();
		Map<String, StudyMadang> preNext = dao.selectPreNext(conn, madangNo);
		close(conn);
		return preNext;
	}

	public int insertMadang(StudyMadang sm) {
		Connection conn = getConnection();
		int result = dao.insertMadang(conn, sm);
		int madangNo = -1;
		if (result > 0) {
			commit(conn);
			madangNo = dao.selectSeqCurrval(conn);
		} else
			rollback(conn);
		close(conn);
		return madangNo;
	}
	
	public int insertLike(int madangNo, int memNo, String REMOTE_ADDR) {
		Connection conn = getConnection();
		int check = dao.checkLike(conn, madangNo, memNo);
		int result = -1;
		System.out.println("check:"+check);
		if(check==0) {
			result = dao.insertLike(conn, madangNo, memNo, REMOTE_ADDR);
			System.out.println("result:"+result);
			if(result>0) commit(conn);
			else rollback(conn);
		} 
		close(conn);
		return result;
	}
	
	public int insertQuestion(StudyMadangQuestion smq) {
		Connection conn = getConnection();
		int update=dao.updateMadangAnswerCount(conn, smq);
		int result=-1;
		if(update>0) {
			result=dao.insertQuestion(conn, smq);
			if(result>0) commit(conn);
			else rollback(conn);
		} else rollback(conn);
		close(conn);
		return result;
	}
	
	public List<StudyMadangQuestion> selectQuestionList(int madangNo, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<StudyMadangQuestion> list=dao.selectQuestionList(conn, madangNo, cPage, numPerPage);
		close(conn);
		return list;
	}
	
	public int updateMadangRepCount(int madangNo) {
		Connection conn=getConnection();
		int result=dao.updateMadangRepCount(conn, madangNo);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
}
