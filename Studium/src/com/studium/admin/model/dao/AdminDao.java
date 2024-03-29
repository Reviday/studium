package com.studium.admin.model.dao;

import static common.template.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import com.studium.admin.model.vo.CanclePayMember;
import com.studium.admin.model.vo.PayMember;
import com.studium.admin.model.vo.PointShow;
import com.studium.admin.model.vo.QandA;
import com.studium.fstudy.model.vo.Fstudy;
import com.studium.member.model.vo.Member;
import com.studium.member.model.vo.MemberLoginLog;
import com.studium.mypage.model.vo.LeaderAdd;
import com.studium.pstudy.model.vo.Pstudy;

public class AdminDao {

	private Properties prop=new Properties();

	public AdminDao() {
		String path=AdminDao.class.getResource("/sql/admin/admin-QandA.properties").getPath();
		try {
			prop.load(new FileReader(path));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}

	public int insertQandA(Connection conn, String content, String email) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("insertQandA");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, content);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}

	public int selectCountQandA(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountQandA");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountLoginLog(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountLoginLog");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountMember(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountMember");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountLeader(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountLeader");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountStudy(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountStudy");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountCanclePayMember(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountCanclePayMember");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountPayMember(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountPayMember");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountPointMember(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountPointMember");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountLoginLogSearch(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountLoginLogSearch") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountMemberName(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountMemberName") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountPayMemberName(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountPayMemberName") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountCanclePayMemberName(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountCanclePayMemberName") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountFreeStudy(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountFreeStudy");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountEndFreeStudyList(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountEndFreeStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountFutureStudyList(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountFutureStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountFutureFreeStudyList(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountFutureFreeStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountEndStudyList(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountEndStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountCanclePayMemberEmail(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountCanclePayMemberEmail") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountMemberEmail(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountMemberEmail") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountPayMemberEmail(Connection conn, String memberName) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountPayMemberEmail") + memberName+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}

	public int selectCountMemberSearch(Connection conn, String grade, String status) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;

		if(grade.equals("allGrade") && status.equals("allStatus")) {
			String sql=prop.getProperty("selectCountMember");
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}

		}

		if(grade.equals("allGrade") && !status.equals("allStatus")) {

			String sql=prop.getProperty("selectCountStatusMember") + " '" + status + "'";
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}

		}

		if(!grade.equals("allGrade") && status.equals("allStatus")) {
			String sql=prop.getProperty("selectCountGradeMember") + " '" + grade + "'";
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}

		}

		if(!grade.equals("allGrade") && !status.equals("allStatus")) {
			String sql=prop.getProperty("selectCountGradeMember") + " '" + grade + "'"
					+ "AND MEM_DENIED =" + " '" + status + "'";
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
		}

		return result;

	}

	public List<MemberLoginLog> selectLoginLogList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberLoginLog> list=new ArrayList();
		String sql=prop.getProperty("selectLoginLogList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				MemberLoginLog m=new MemberLoginLog();
				m.setMllNo(rs.getInt("mll_no"));
				m.setMllSuccess(rs.getString("mll_success").charAt(0));
				m.setMllMemNo(rs.getInt("mll_mem_no"));
				m.setMllUserEmail(rs.getString("mll_user_email"));
				m.setMllDatetime(rs.getTimestamp("mll_datetime"));
				m.setMllIp(rs.getString("mll_ip"));
				m.setMllReason(rs.getString("mll_reason"));
				m.setMllUseragent(rs.getString("mll_useragent"));
				m.setMllUrl(rs.getString("mll_url"));
				m.setMllReferer(rs.getString("mll_referer"));
				list.add(m);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Fstudy> selectEndFreeStudyList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Fstudy> list=new ArrayList();
		String sql=prop.getProperty("selectEndFreeStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Fstudy p=new Fstudy();
				p.setfNo(rs.getInt("f_no"));
				p.setfTitle(rs.getString("f_title"));
				p.setfName(rs.getString("f_name"));
				p.setfArea(rs.getString("f_area"));
				p.setfDay(rs.getString("f_day"));
				p.setfStudypserson(rs.getInt("F_STUDYPERSON"));
				p.setfCategory(rs.getString("f_category"));
				p.setfIntro1(rs.getString("f_intro1"));
				p.setfIntro2(rs.getString("f_intro2"));
				p.setfImgtitle(rs.getString("f_imgtitle"));
				p.setfImg1(rs.getString("f_img1"));
				p.setfImg2(rs.getString("f_img2"));
				p.setfImg3(rs.getString("f_img3"));
				p.setfTimestart(rs.getString("f_timestart"));
				p.setfTimeend(rs.getString("f_timeend"));
				p.setfDatestart(rs.getDate("f_datestart"));
				p.setfDateend(rs.getDate("f_dateend"));
				p.setfLike(rs.getInt("f_like"));
				p.setfReadername(rs.getString("f_readername"));
				p.setfStudyMember(rs.getInt("f_studyMember"));

				list.add(p);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Fstudy> selectFutureFreeStudyList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Fstudy> list=new ArrayList();
		String sql=prop.getProperty("selectFutureFreeStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Fstudy p=new Fstudy();
				p.setfNo(rs.getInt("f_no"));
				p.setfTitle(rs.getString("f_title"));
				p.setfName(rs.getString("f_name"));
				p.setfArea(rs.getString("f_area"));
				p.setfDay(rs.getString("f_day"));
				p.setfStudypserson(rs.getInt("F_STUDYPERSON"));
				p.setfCategory(rs.getString("f_category"));
				p.setfIntro1(rs.getString("f_intro1"));
				p.setfIntro2(rs.getString("f_intro2"));
				p.setfImgtitle(rs.getString("f_imgtitle"));
				p.setfImg1(rs.getString("f_img1"));
				p.setfImg2(rs.getString("f_img2"));
				p.setfImg3(rs.getString("f_img3"));
				p.setfTimestart(rs.getString("f_timestart"));
				p.setfTimeend(rs.getString("f_timeend"));
				p.setfDatestart(rs.getDate("f_datestart"));
				p.setfDateend(rs.getDate("f_dateend"));
				p.setfLike(rs.getInt("f_like"));
				p.setfReadername(rs.getString("f_readername"));
				p.setfStudyMember(rs.getInt("f_studyMember"));
				list.add(p);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Fstudy> selectFreeStudyPlayList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Fstudy> list=new ArrayList();
		String sql=prop.getProperty("selectFreeStudyPlayList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Fstudy p=new Fstudy();
				p.setfNo(rs.getInt("f_no"));
				p.setfTitle(rs.getString("f_title"));
				p.setfName(rs.getString("f_name"));
				p.setfArea(rs.getString("f_area"));
				p.setfDay(rs.getString("f_day"));
				p.setfStudypserson(rs.getInt("F_STUDYPERSON"));
				p.setfCategory(rs.getString("f_category"));
				p.setfIntro1(rs.getString("f_intro1"));
				p.setfIntro2(rs.getString("f_intro2"));
				p.setfImgtitle(rs.getString("f_imgtitle"));
				p.setfImg1(rs.getString("f_img1"));
				p.setfImg2(rs.getString("f_img2"));
				p.setfImg3(rs.getString("f_img3"));
				p.setfTimestart(rs.getString("f_timestart"));
				p.setfTimeend(rs.getString("f_timeend"));
				p.setfDatestart(rs.getDate("f_datestart"));
				p.setfDateend(rs.getDate("f_dateend"));
				p.setfLike(rs.getInt("f_like"));
				p.setfReadername(rs.getString("f_readername"));
				p.setfStudyMember(rs.getInt("f_studyMember"));
				list.add(p);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Pstudy> selectFutureStudyList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Pstudy> list=new ArrayList();
		String sql=prop.getProperty("selectFutureStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Pstudy p=new Pstudy();
				p.setpNo(rs.getInt("p_no"));
				p.setpTitle(rs.getString("p_title"));
				p.setpName(rs.getString("p_name"));
				p.setpArea(rs.getString("p_area"));
				p.setpDay(rs.getString("p_day"));
				p.setpStudypserson(rs.getInt("p_studyperson"));
				p.setpPrice(rs.getInt("p_price"));
				p.setpCategory(rs.getString("p_category"));
				p.setpIntro1(rs.getString("p_intro1"));
				p.setpIntro2(rs.getString("p_intro2"));
				p.setpImgtitle(rs.getString("p_imgtitle"));
				p.setpImg1(rs.getString("p_img1"));
				p.setpImg2(rs.getString("p_img2"));
				p.setpImg3(rs.getString("p_img3"));
				p.setpTimestart(rs.getString("p_timestart"));
				p.setpTimeend(rs.getString("P_timeend"));
				p.setpDatestart(rs.getDate("p_datestart"));
				p.setpDateend(rs.getDate("p_dateend"));
				p.setpLike(rs.getInt("p_like"));
				p.setpTeachername(rs.getString("p_teachername"));
				p.setpStudyMember(rs.getInt("p_studyMember"));
				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Pstudy> selectEndStudyList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Pstudy> list=new ArrayList();
		String sql=prop.getProperty("selectEndStudyList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Pstudy p=new Pstudy();
				p.setpNo(rs.getInt("p_no"));
				p.setpTitle(rs.getString("p_title"));
				p.setpName(rs.getString("p_name"));
				p.setpArea(rs.getString("p_area"));
				p.setpDay(rs.getString("p_day"));
				p.setpStudypserson(rs.getInt("p_studyperson"));
				p.setpPrice(rs.getInt("p_price"));
				p.setpCategory(rs.getString("p_category"));
				p.setpIntro1(rs.getString("p_intro1"));
				p.setpIntro2(rs.getString("p_intro2"));
				p.setpImgtitle(rs.getString("p_imgtitle"));
				p.setpImg1(rs.getString("p_img1"));
				p.setpImg2(rs.getString("p_img2"));
				p.setpImg3(rs.getString("p_img3"));
				p.setpTimestart(rs.getString("p_timestart"));
				p.setpTimeend(rs.getString("P_timeend"));
				p.setpDatestart(rs.getDate("p_datestart"));
				p.setpDateend(rs.getDate("p_dateend"));
				p.setpLike(rs.getInt("p_like"));
				p.setpTeachername(rs.getString("p_teachername"));
				p.setpStudyMember(rs.getInt("p_studyMember"));
				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Pstudy> selectStudyPlayList(Connection conn, int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Pstudy> list=new ArrayList();
		String sql=prop.getProperty("selectStudyPlayList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Pstudy p=new Pstudy();
				p.setpNo(rs.getInt("p_no"));
				p.setpTitle(rs.getString("p_title"));
				p.setpName(rs.getString("p_name"));
				p.setpArea(rs.getString("p_area"));
				p.setpDay(rs.getString("P_day"));
				p.setpStudypserson(rs.getInt("p_studyperson"));
				p.setpPrice(rs.getInt("p_price"));
				p.setpCategory(rs.getString("p_category"));
				p.setpIntro1(rs.getString("p_intro1"));
				p.setpIntro2(rs.getString("p_intro2"));
				p.setpImgtitle(rs.getString("p_imgtitle"));
				p.setpImg1(rs.getString("p_img1"));
				p.setpImg2(rs.getString("p_img2"));
				p.setpImg3(rs.getString("p_img3"));
				p.setpTimestart(rs.getString("p_timestart"));
				p.setpTimeend(rs.getString("P_timeend"));
				p.setpDatestart(rs.getDate("p_datestart"));
				p.setpDateend(rs.getDate("p_dateend"));
				p.setpLike(rs.getInt("p_like"));
				p.setpTeachername(rs.getString("p_teachername"));
				p.setpStudyMember(rs.getInt("p_studyMember"));
				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<LeaderAdd> selectLeaderPSList(Connection conn,int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<LeaderAdd> list=new ArrayList();
		String sql=prop.getProperty("selectLeaderPSList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				LeaderAdd l=new LeaderAdd();
				l.setlNo(rs.getInt("l_no"));
				l.setlName(rs.getString("l_name"));
				l.setlGender(rs.getString("l_gender"));
				l.setlEmail(rs.getString("l_email"));
				l.setlPhone(rs.getString("l_phone"));
				l.setlType(rs.getString("l_type"));
				l.setlArea(rs.getString("l_area"));
				l.setlCategory1(rs.getString("l_category1"));
				l.setlMessage(rs.getString("l_message"));
				l.setlEnrolldate(rs.getDate("l_enrolldate"));
				l.setlStatus(rs.getString("l_status"));

				list.add(l);				
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<CanclePayMember> selectCanclePayMemberList(Connection conn,int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CanclePayMember> list=new ArrayList();
		String sql=prop.getProperty("selectCanclePayMemberList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CanclePayMember p=new CanclePayMember();
				p.setMemNo(rs.getInt("mem_no"));
				p.setMemName(rs.getString("mem_name"));
				p.setMemPhone(rs.getString("mem_phone"));
				p.setpTitle(rs.getString("p_title"));
				p.setCancleDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("cancel_date")));
				p.setPrice(rs.getInt("p_price"));				
				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}


	public List<PayMember> selectPayMemberList(Connection conn,int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PayMember> list=new ArrayList();
		String sql=prop.getProperty("selectPayMemberList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PayMember p=new PayMember();
				p.setMemNo(rs.getInt("mem_no"));
				p.setMemName(rs.getString("mem_name"));
				p.setMemPhone(rs.getString("mem_phone"));
				p.setpTitle(rs.getString("p_title"));
				p.setPurchaseDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("purchase_date")));

				String status = "";
				if(rs.getString("purchase_status").equals("N")) status = "스터디 진행 중";
				if(rs.getString("purchase_status").equals("Y")) status = "스터디 종료";
				if(rs.getString("purchase_status").equals("B")) status = "스터디 준비 중";

				p.setPurchaseStatus(status);

				list.add(p);

			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}


	public List<QandA> selectQandAList(Connection conn,int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QandA> list=new ArrayList();
		String sql=prop.getProperty("selectQandAList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QandA q=new QandA();
				q.setcNo(rs.getInt("no"));
				q.setEmail(rs.getString("email"));
				if(rs.getString("content").length() < 20) {
					q.setContent(rs.getString("content"));
				}else {
					q.setContent(rs.getString("content").substring(0, 17)+"...");					
				}
				q.setFullContent(rs.getString("content"));
				q.setEnrollDate(rs.getDate("enroll_date"));


				Date today = new Date();
				long calDate = today.getTime() - rs.getDate("enroll_date").getTime();
				long calDateDays = calDate / (24*60*60*1000); 
				calDateDays = Math.abs(calDateDays);
				if(calDateDays == 0) {
					q.setPastDate("오늘");
				}else {
					q.setPastDate(calDateDays+"일 전");
				}


				list.add(q);				
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Member> selectMemberList(Connection conn,int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();
		String sql=prop.getProperty("selectMemberList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemNo(rs.getInt("mem_no"));
				m.setMemUserEmail(rs.getString("mem_email"));
				m.setMemPassword(rs.getString("mem_password"));
				m.setMemCode(rs.getString("mem_code").charAt(0));
				m.setMemName(rs.getString("mem_name"));
				m.setMemBirth(rs.getDate("mem_birth"));
				m.setMemPhone(rs.getString("mem_phone"));
				m.setMemGender(rs.getString("mem_gender").charAt(0));
				m.setMemPoint(rs.getInt("mem_point"));
				m.setMemCategory1(rs.getString("mem_category1"));
				m.setMemCategory2(rs.getString("mem_category2"));
				m.setMemCategory3(rs.getString("mem_category3"));
				m.setMemZipCode(rs.getString("mem_zipcode"));
				m.setMemAddress1(rs.getString("mem_address1"));
				m.setMemAddress2(rs.getString("mem_address2"));
				m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
				m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
				m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
				m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
				m.setMemDenied(rs.getString("mem_denied").charAt(0));
				m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
				m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
				m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
				m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
				m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
				m.setMemProfileContent(rs.getString("mem_profile_content"));
				m.setMemAdminmemo(rs.getString("mem_adminmemo"));
				m.setMemIcon(rs.getString("mem_icon"));
				m.setMemPhoto(rs.getString("mem_photo"));
				m.setMemStatus(rs.getString("mem_status").charAt(0));
				m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
				m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

				list.add(m);				
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Member> selectMemberPointList(Connection conn,int cPage, int numPerPage){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();
		String sql=prop.getProperty("selectMemberPointList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemNo(rs.getInt("mem_no"));
				m.setMemUserEmail(rs.getString("mem_email"));
				m.setMemPassword(rs.getString("mem_password"));
				m.setMemCode(rs.getString("mem_code").charAt(0));
				m.setMemName(rs.getString("mem_name"));
				m.setMemBirth(rs.getDate("mem_birth"));
				m.setMemPhone(rs.getString("mem_phone"));
				m.setMemGender(rs.getString("mem_gender").charAt(0));
				m.setMemPoint(rs.getInt("mem_point"));
				m.setMemCategory1(rs.getString("mem_category1"));
				m.setMemCategory2(rs.getString("mem_category2"));
				m.setMemCategory3(rs.getString("mem_category3"));
				m.setMemZipCode(rs.getString("mem_zipcode"));
				m.setMemAddress1(rs.getString("mem_address1"));
				m.setMemAddress2(rs.getString("mem_address2"));
				m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
				m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
				m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
				m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
				m.setMemDenied(rs.getString("mem_denied").charAt(0));
				m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
				m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
				m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
				m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
				m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
				m.setMemProfileContent(rs.getString("mem_profile_content"));
				m.setMemAdminmemo(rs.getString("mem_adminmemo"));
				m.setMemIcon(rs.getString("mem_icon"));
				m.setMemPhoto(rs.getString("mem_photo"));
				m.setMemStatus(rs.getString("mem_status").charAt(0));
				m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
				m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

				list.add(m);				
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Member> selectMemberSearchList(Connection conn,int cPage, int numPerPage, String grade, String status) {

		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();

		if(grade.equals("allGrade") && status.equals("allStatus")) {
			String sql=prop.getProperty("selectMemberList");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, (cPage-1)*numPerPage+1);
				pstmt.setInt(2, cPage*numPerPage);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Member m = new Member();
					m.setMemNo(rs.getInt("mem_no"));
					m.setMemUserEmail(rs.getString("mem_email"));
					m.setMemPassword(rs.getString("mem_password"));
					m.setMemCode(rs.getString("mem_code").charAt(0));
					m.setMemName(rs.getString("mem_name"));
					m.setMemBirth(rs.getDate("mem_birth"));
					m.setMemPhone(rs.getString("mem_phone"));
					m.setMemGender(rs.getString("mem_gender").charAt(0));
					m.setMemPoint(rs.getInt("mem_point"));
					m.setMemCategory1(rs.getString("mem_category1"));
					m.setMemCategory2(rs.getString("mem_category2"));
					m.setMemCategory3(rs.getString("mem_category3"));
					m.setMemZipCode(rs.getString("mem_zipcode"));
					m.setMemAddress1(rs.getString("mem_address1"));
					m.setMemAddress2(rs.getString("mem_address2"));
					m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
					m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
					m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
					m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
					m.setMemDenied(rs.getString("mem_denied").charAt(0));
					m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
					m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
					m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
					m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
					m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
					m.setMemProfileContent(rs.getString("mem_profile_content"));
					m.setMemAdminmemo(rs.getString("mem_adminmemo"));
					m.setMemIcon(rs.getString("mem_icon"));
					m.setMemPhoto(rs.getString("mem_photo"));
					m.setMemStatus(rs.getString("mem_status").charAt(0));
					m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
					m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

					list.add(m);				
				}

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
		}

		if(grade.equals("allGrade") && !status.equals("allStatus")) {
			String sql=prop.getProperty("selectMemberStatusList");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, status);
				pstmt.setInt(2, (cPage-1)*numPerPage+1);
				pstmt.setInt(3, cPage*numPerPage);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Member m = new Member();
					m.setMemNo(rs.getInt("mem_no"));
					m.setMemUserEmail(rs.getString("mem_email"));
					m.setMemPassword(rs.getString("mem_password"));
					m.setMemCode(rs.getString("mem_code").charAt(0));
					m.setMemName(rs.getString("mem_name"));
					m.setMemBirth(rs.getDate("mem_birth"));
					m.setMemPhone(rs.getString("mem_phone"));
					m.setMemGender(rs.getString("mem_gender").charAt(0));
					m.setMemPoint(rs.getInt("mem_point"));
					m.setMemCategory1(rs.getString("mem_category1"));
					m.setMemCategory2(rs.getString("mem_category2"));
					m.setMemCategory3(rs.getString("mem_category3"));
					m.setMemZipCode(rs.getString("mem_zipcode"));
					m.setMemAddress1(rs.getString("mem_address1"));
					m.setMemAddress2(rs.getString("mem_address2"));
					m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
					m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
					m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
					m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
					m.setMemDenied(rs.getString("mem_denied").charAt(0));
					m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
					m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
					m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
					m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
					m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
					m.setMemProfileContent(rs.getString("mem_profile_content"));
					m.setMemAdminmemo(rs.getString("mem_adminmemo"));
					m.setMemIcon(rs.getString("mem_icon"));
					m.setMemPhoto(rs.getString("mem_photo"));
					m.setMemStatus(rs.getString("mem_status").charAt(0));
					m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
					m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

					list.add(m);				
				}

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}

		}

		if(!grade.equals("allGrade") && status.equals("allStatus")) {
			String sql=prop.getProperty("selectMemberGradeList");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, grade);
				pstmt.setInt(2, (cPage-1)*numPerPage+1);
				pstmt.setInt(3, cPage*numPerPage);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Member m = new Member();
					m.setMemNo(rs.getInt("mem_no"));
					m.setMemUserEmail(rs.getString("mem_email"));
					m.setMemPassword(rs.getString("mem_password"));
					m.setMemCode(rs.getString("mem_code").charAt(0));
					m.setMemName(rs.getString("mem_name"));
					m.setMemBirth(rs.getDate("mem_birth"));
					m.setMemPhone(rs.getString("mem_phone"));
					m.setMemGender(rs.getString("mem_gender").charAt(0));
					m.setMemPoint(rs.getInt("mem_point"));
					m.setMemCategory1(rs.getString("mem_category1"));
					m.setMemCategory2(rs.getString("mem_category2"));
					m.setMemCategory3(rs.getString("mem_category3"));
					m.setMemZipCode(rs.getString("mem_zipcode"));
					m.setMemAddress1(rs.getString("mem_address1"));
					m.setMemAddress2(rs.getString("mem_address2"));
					m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
					m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
					m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
					m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
					m.setMemDenied(rs.getString("mem_denied").charAt(0));
					m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
					m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
					m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
					m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
					m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
					m.setMemProfileContent(rs.getString("mem_profile_content"));
					m.setMemAdminmemo(rs.getString("mem_adminmemo"));
					m.setMemIcon(rs.getString("mem_icon"));
					m.setMemPhoto(rs.getString("mem_photo"));
					m.setMemStatus(rs.getString("mem_status").charAt(0));
					m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
					m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

					list.add(m);				
				}

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}

		}

		if(!grade.equals("allGrade") && !status.equals("allStatus")) {

			String sql=prop.getProperty("selectMemberSearchList");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, grade);
				pstmt.setString(2, status);
				pstmt.setInt(3, (cPage-1)*numPerPage+1);
				pstmt.setInt(4, cPage*numPerPage);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Member m = new Member();
					m.setMemNo(rs.getInt("mem_no"));
					m.setMemUserEmail(rs.getString("mem_email"));
					m.setMemPassword(rs.getString("mem_password"));
					m.setMemCode(rs.getString("mem_code").charAt(0));
					m.setMemName(rs.getString("mem_name"));
					m.setMemBirth(rs.getDate("mem_birth"));
					m.setMemPhone(rs.getString("mem_phone"));
					m.setMemGender(rs.getString("mem_gender").charAt(0));
					m.setMemPoint(rs.getInt("mem_point"));
					m.setMemCategory1(rs.getString("mem_category1"));
					m.setMemCategory2(rs.getString("mem_category2"));
					m.setMemCategory3(rs.getString("mem_category3"));
					m.setMemZipCode(rs.getString("mem_zipcode"));
					m.setMemAddress1(rs.getString("mem_address1"));
					m.setMemAddress2(rs.getString("mem_address2"));
					m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
					m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
					m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
					m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
					m.setMemDenied(rs.getString("mem_denied").charAt(0));
					m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
					m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
					m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
					m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
					m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
					m.setMemProfileContent(rs.getString("mem_profile_content"));
					m.setMemAdminmemo(rs.getString("mem_adminmemo"));
					m.setMemIcon(rs.getString("mem_icon"));
					m.setMemPhoto(rs.getString("mem_photo"));
					m.setMemStatus(rs.getString("mem_status").charAt(0));
					m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
					m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

					list.add(m);				
				}

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}


		}

		return list;

	}

	public List<PayMember> selectPayMemberNameList(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PayMember> list=new ArrayList();
		String sql=prop.getProperty("selectPayMemberNameList") + memberName + 
				"%' ORDER BY PURCHASE_DATE DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PayMember p=new PayMember();
				p.setMemNo(rs.getInt("mem_no"));
				p.setMemName(rs.getString("mem_name"));
				p.setMemPhone(rs.getString("mem_phone"));
				p.setpTitle(rs.getString("p_title"));
				p.setPurchaseDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("purchase_date")));

				String status = "";
				if(rs.getString("purchase_status").equals("N")) status = "스터디 진행 중";
				if(rs.getString("purchase_status").equals("Y")) status = "스터디 종료";
				if(rs.getString("purchase_status").equals("B")) status = "스터디 준비 중";

				p.setPurchaseStatus(status);

				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}


	public List<Member> selectMemberNameList(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();
		//		String sql=prop.getProperty("selectMemberNameList");
		String sql="SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM (SELECT * FROM TA_MEMBER WHERE MEM_STATUS = 'Y' AND MEM_NAME LIKE '%"
				+ memberName + "%' ORDER BY MEM_NO DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			//			pstmt.setString(1, memberName);
			//			pstmt.setInt(2, (cPage-1)*numPerPage+1);
			//			pstmt.setInt(3, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemNo(rs.getInt("mem_no"));
				m.setMemUserEmail(rs.getString("mem_email"));
				m.setMemPassword(rs.getString("mem_password"));
				m.setMemCode(rs.getString("mem_code").charAt(0));
				m.setMemName(rs.getString("mem_name"));
				m.setMemBirth(rs.getDate("mem_birth"));
				m.setMemPhone(rs.getString("mem_phone"));
				m.setMemGender(rs.getString("mem_gender").charAt(0));
				m.setMemPoint(rs.getInt("mem_point"));
				m.setMemCategory1(rs.getString("mem_category1"));
				m.setMemCategory2(rs.getString("mem_category2"));
				m.setMemCategory3(rs.getString("mem_category3"));
				m.setMemZipCode(rs.getString("mem_zipcode"));
				m.setMemAddress1(rs.getString("mem_address1"));
				m.setMemAddress2(rs.getString("mem_address2"));
				m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
				m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
				m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
				m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
				m.setMemDenied(rs.getString("mem_denied").charAt(0));
				m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
				m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
				m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
				m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
				m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
				m.setMemProfileContent(rs.getString("mem_profile_content"));
				m.setMemAdminmemo(rs.getString("mem_adminmemo"));
				m.setMemIcon(rs.getString("mem_icon"));
				m.setMemPhoto(rs.getString("mem_photo"));
				m.setMemStatus(rs.getString("mem_status").charAt(0));
				m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
				m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

				list.add(m);	
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<CanclePayMember> selectCanclePayMemberNameList(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CanclePayMember> list=new ArrayList();
		String sql=prop.getProperty("selectCanclePayMemberNameList") + memberName + 
				"%' ORDER BY CANCEL_DATE DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CanclePayMember p=new CanclePayMember();
				p.setMemNo(rs.getInt("mem_no"));
				p.setMemName(rs.getString("mem_name"));
				p.setMemPhone(rs.getString("mem_phone"));
				p.setpTitle(rs.getString("p_title"));
				p.setCancleDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("cancel_date")));
				p.setPrice(rs.getInt("p_price"));

				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<CanclePayMember> selectCanclePayMemberEmailList(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CanclePayMember> list=new ArrayList();
		String sql=prop.getProperty("selectCanclePayMemberEmailList") + memberName + 
				"%' ORDER BY CANCEL_DATE DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CanclePayMember p=new CanclePayMember();
				p.setMemNo(rs.getInt("mem_no"));
				p.setMemName(rs.getString("mem_name"));
				p.setMemPhone(rs.getString("mem_phone"));
				p.setpTitle(rs.getString("p_title"));
				p.setCancleDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("cancel_date")));
				p.setPrice(rs.getInt("p_price"));

				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<PayMember> selectPayMemberEmailList(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PayMember> list=new ArrayList();
		String sql=prop.getProperty("selectPayMemberEmailList") + memberName + 
				"%' ORDER BY PURCHASE_DATE DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PayMember p=new PayMember();
				p.setMemNo(rs.getInt("mem_no"));
				p.setMemName(rs.getString("mem_name"));
				p.setMemPhone(rs.getString("mem_phone"));
				p.setpTitle(rs.getString("p_title"));
				p.setPurchaseDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("purchase_date")));

				String status = "";
				if(rs.getString("purchase_status").equals("N")) status = "스터디 진행 중";
				if(rs.getString("purchase_status").equals("Y")) status = "스터디 종료";
				if(rs.getString("purchase_status").equals("B")) status = "스터디 준비 중";

				p.setPurchaseStatus(status);

				list.add(p);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<MemberLoginLog> selectCountLoginLogSearch(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberLoginLog> list=new ArrayList();

		String sql="SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM (SELECT * FROM TA_MEMBER_LOGIN_LOG WHERE MLL_USER_EMAIL LIKE '%"
				+ memberName + "%' ORDER BY MLL_DATETIME DESC)A) WHERE RNUM BETWEEN " + ((cPage-1)*numPerPage+1) + " AND " + (cPage*numPerPage);
		try {
			pstmt=conn.prepareStatement(sql);

			rs=pstmt.executeQuery();
			while(rs.next()) {
				MemberLoginLog m=new MemberLoginLog();
				m.setMllNo(rs.getInt("mll_no"));
				m.setMllSuccess(rs.getString("mll_success").charAt(0));
				m.setMllMemNo(rs.getInt("mll_mem_no"));
				m.setMllUserEmail(rs.getString("mll_user_email"));
				m.setMllDatetime(rs.getTimestamp("mll_datetime"));
				m.setMllIp(rs.getString("mll_ip"));
				m.setMllReason(rs.getString("mll_reason"));
				m.setMllUseragent(rs.getString("mll_useragent"));
				m.setMllUrl(rs.getString("mll_url"));
				m.setMllReferer(rs.getString("mll_referer"));

				list.add(m);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}

		return list;
	}

	public List<Member> selectMemberEmailList(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();
		//		String sql=prop.getProperty("selectMemberNameList");
		String sql="SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM (SELECT * FROM TA_MEMBER WHERE MEM_STATUS = 'Y' AND MEM_EMAIL LIKE '%"
				+ memberName + "%' ORDER BY MEM_NO DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			//			pstmt.setString(1, memberName);
			//			pstmt.setInt(2, (cPage-1)*numPerPage+1);
			//			pstmt.setInt(3, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemNo(rs.getInt("mem_no"));
				m.setMemUserEmail(rs.getString("mem_email"));
				m.setMemPassword(rs.getString("mem_password"));
				m.setMemCode(rs.getString("mem_code").charAt(0));
				m.setMemName(rs.getString("mem_name"));
				m.setMemBirth(rs.getDate("mem_birth"));
				m.setMemPhone(rs.getString("mem_phone"));
				m.setMemGender(rs.getString("mem_gender").charAt(0));
				m.setMemPoint(rs.getInt("mem_point"));
				m.setMemCategory1(rs.getString("mem_category1"));
				m.setMemCategory2(rs.getString("mem_category2"));
				m.setMemCategory3(rs.getString("mem_category3"));
				m.setMemZipCode(rs.getString("mem_zipcode"));
				m.setMemAddress1(rs.getString("mem_address1"));
				m.setMemAddress2(rs.getString("mem_address2"));
				m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
				m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
				m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
				m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
				m.setMemDenied(rs.getString("mem_denied").charAt(0));
				m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
				m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
				m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
				m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
				m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
				m.setMemProfileContent(rs.getString("mem_profile_content"));
				m.setMemAdminmemo(rs.getString("mem_adminmemo"));
				m.setMemIcon(rs.getString("mem_icon"));
				m.setMemPhoto(rs.getString("mem_photo"));
				m.setMemStatus(rs.getString("mem_status").charAt(0));
				m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
				m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

				list.add(m);	
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public List<Member> selectCountMemberEmail(Connection conn,int cPage, int numPerPage, String memberName){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> list=new ArrayList();
		//		String sql=prop.getProperty("selectMemberNameList");
		String sql="SELECT * FROM (SELECT ROWNUM AS RNUM, A.* FROM (SELECT * FROM TA_MEMBER WHERE MEM_STATUS = 'Y' AND MEM_EMAIL LIKE '%"
				+ memberName + "%' ORDER BY MEM_NO DESC)A) WHERE RNUM BETWEEN " + (cPage-1)*numPerPage+1 + " AND " + cPage*numPerPage;
		try {
			pstmt=conn.prepareStatement(sql);
			//			pstmt.setString(1, memberName);
			//			pstmt.setInt(2, (cPage-1)*numPerPage+1);
			//			pstmt.setInt(3, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemNo(rs.getInt("mem_no"));
				m.setMemUserEmail(rs.getString("mem_email"));
				m.setMemPassword(rs.getString("mem_password"));
				m.setMemCode(rs.getString("mem_code").charAt(0));
				m.setMemName(rs.getString("mem_name"));
				m.setMemBirth(rs.getDate("mem_birth"));
				m.setMemPhone(rs.getString("mem_phone"));
				m.setMemGender(rs.getString("mem_gender").charAt(0));
				m.setMemPoint(rs.getInt("mem_point"));
				m.setMemCategory1(rs.getString("mem_category1"));
				m.setMemCategory2(rs.getString("mem_category2"));
				m.setMemCategory3(rs.getString("mem_category3"));
				m.setMemZipCode(rs.getString("mem_zipcode"));
				m.setMemAddress1(rs.getString("mem_address1"));
				m.setMemAddress2(rs.getString("mem_address2"));
				m.setMemReceiveEmail(rs.getString("mem_receive_email").charAt(0));
				m.setMemUseNote(rs.getString("mem_use_note").charAt(0));
				m.setMemReceiveSms(rs.getString("mem_receive_sms").charAt(0));
				m.setMemOpenProfile(rs.getString("mem_open_profile").charAt(0));
				m.setMemDenied(rs.getString("mem_denied").charAt(0));
				m.setMemEmailCert(rs.getString("mem_email_cert").charAt(0));
				m.setMemEnrollDatetime(rs.getTimestamp("mem_enroll_datetime"));
				m.setMemEnrollIp(rs.getString("mem_enroll_ip"));
				m.setMemLastloginDatetime(rs.getTimestamp("mem_lastlogin_datetime"));
				m.setMemLastloginIp(rs.getString("mem_lastlogin_ip"));
				m.setMemProfileContent(rs.getString("mem_profile_content"));
				m.setMemAdminmemo(rs.getString("mem_adminmemo"));
				m.setMemIcon(rs.getString("mem_icon"));
				m.setMemPhoto(rs.getString("mem_photo"));
				m.setMemStatus(rs.getString("mem_status").charAt(0));
				m.setMemWithdrawalDate(rs.getTimestamp("mem_withdrawal_date"));
				m.setMemDeniedDate(rs.getTimestamp("mem_denied_date"));

				list.add(m);	
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public int deleteQnAList(Connection conn, String[] deList) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deleteQandAList");
		for(String s : deList) {
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, s);				
				result=pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
		}
		return result;
	}

	public int deletePayMember(Connection conn, String memNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deletePayMember");

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memNo);				
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

	public int deleteMember(Connection conn, String memNo) {

		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deleteMember");

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memNo);				
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;

	}

	public int updateMember(Connection conn, String memNo, String grade, String status) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updateMember");

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, grade);
			pstmt.setString(2, status);
			pstmt.setString(3, memNo);	
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

	public List<Integer> memberPoint(Connection conn, String[] memberNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Integer> result = new ArrayList<Integer>();

		for(int i = 0; i < memberNo.length; i++) {
			String sql=prop.getProperty("selectMemberPoint") + " '" + memberNo[i] + "'";
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result.add(rs.getInt(1));

				}
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
		}
		return result;
	}

	public int memberPointUp(Connection conn, String[] memberNo, List<Integer> memberPoint) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("memberPointUp");
		for(int i = 0; i < memberNo.length; i++) {
			try {

				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, memberPoint.get(i));
				pstmt.setString(2, memberNo[i]);
				result=pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
		}
		return result;
	}

	public int pointUpContent(Connection conn, String point, String[] memberNo, String[] memName, String[] memEmail) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("pointUpContent");
		for(int i = 0; i < memberNo.length; i++) {
			try {

				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(memberNo[i]));
				pstmt.setString(2, memName[i]);
				pstmt.setString(3, memEmail[i]);
				pstmt.setInt(4, Integer.parseInt(point));
				result=pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
		}
		return result;
	}

	public int pointDownContent(Connection conn, String point, String[] memberNo, String[] memName, String[] memEmail) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("pointDownContent");
		for(int i = 0; i < memberNo.length; i++) {
			try {

				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(memberNo[i]));
				pstmt.setString(2, memName[i]);
				pstmt.setString(3, memEmail[i]);
				pstmt.setInt(4, Integer.parseInt(point));
				result=pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
		}
		return result;
	}

	public List<PointShow> pointShow(Connection conn, String memNo){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PointShow> list=new ArrayList();
		String sql=prop.getProperty("pointShow");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(memNo));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PointShow p = new PointShow();
				p.setMemId(memNo);
				p.setMemName(rs.getString("mem_name"));
				p.setMemEmail(rs.getString("mem_email"));
				p.setPoint(rs.getInt("mem_point"));
				p.setPointStatus(rs.getString("point_status").charAt(0));
				p.setPointEnrollDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("point_enrolldate")));

				list.add(p);				
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}

	public int updateMemo(Connection conn, String memNo, String memo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updateMemo");

		try {

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memo);
			pstmt.setInt(2, Integer.parseInt(memNo));

			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}

		return result;
	}

	public int deletePS(Connection conn, String[] leaderNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deletePS");
		for(String s : leaderNo) {
			try {
				System.out.println(leaderNo);

				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, s);
				result=pstmt.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
		}
		return result;
	}

	public String showMemo(Connection conn, String memNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String memo = "";
		String sql=prop.getProperty("showMemo");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				memo=rs.getString(1);

			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return memo;
	}

	public String memoPS(Connection conn, String memNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String memo = "";
		String sql=prop.getProperty("memoPS");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				memo=rs.getString(1);

			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return memo;
	}

}
