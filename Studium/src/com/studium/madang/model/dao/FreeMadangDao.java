package com.studium.madang.model.dao;

import static common.template.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.studium.madang.model.vo.FreeMadang;
import com.studium.madang.model.vo.FreeMadangFile;
import com.studium.member.model.service.MemberService;

public class FreeMadangDao {

	private Properties prop=new Properties();
	
	public FreeMadangDao() {
		String path=FreeMadangDao.class.getResource("/sql/madang/freemadang-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int selectCountList(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectCountList");
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return result;
	}
	
	public List<FreeMadang> selectMadangList(Connection conn, int cPage, int numPerPage) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<FreeMadang> list=new ArrayList<FreeMadang>();
		String sql=prop.getProperty("selectMadangList");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				FreeMadang fm=new FreeMadang();
				fm.setMadangNo(rs.getInt("madang_no"));
				fm.setMadangParent(rs.getInt("madang_parent"));
				fm.setMadangOrder(rs.getInt("madang_order"));
				fm.setMadangWriterUid(rs.getInt("madang_writer_uid"));
				fm.setMadangWriterEmail(rs.getString("madang_writer_email"));
				fm.setMadangWriterName(rs.getString("madang_writer_name"));
				fm.setMadangTitle(rs.getString("madang_title"));
				fm.setMadangContent(rs.getString("madang_content"));
				fm.setMadangRegisterDatetime(rs.getTimestamp("madang_register_datetime"));
				fm.setMadangRegisterIp(rs.getString("madang_register_ip"));
				fm.setMadangUpdatedDatetime(rs.getTimestamp("madang_updated_datetime"));
				fm.setMadangUpdatedIp(rs.getString("madang_updated_ip"));
				fm.setMadangRecCount(rs.getInt("madang_rec_count"));
				fm.setMadangRepCount(rs.getInt("madang_rep_count"));
				fm.setMadangReadCount(rs.getInt("madang_read_count"));
				fm.setMadangFilePresence(rs.getString("madang_file_presence").charAt(0));
				fm.setMadangImgPresence(rs.getString("madang_img_presence").charAt(0));
				list.add(fm);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return list;
	}
	
	public FreeMadang selectMadang(Connection conn, int no) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		FreeMadang fm=null;
		String sql=prop.getProperty("selectMadang");
		MemberService service= new MemberService();
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				fm=new FreeMadang();
				fm.setMadangNo(rs.getInt("madang_no"));
				fm.setMadangParent(rs.getInt("madang_parent"));
				fm.setMadangOrder(rs.getInt("madang_order"));
				fm.setMadangWriterUid(rs.getInt("madang_writer_uid"));
				fm.setMadangWriterEmail(rs.getString("madang_writer_email"));
				fm.setMadangWriterName(rs.getString("madang_writer_name"));
				fm.setMadangTitle(rs.getString("madang_title"));
				fm.setMadangContent(rs.getString("madang_content"));
				fm.setMadangRegisterDatetime(rs.getTimestamp("madang_register_datetime"));
				fm.setMadangRegisterIp(rs.getString("madang_register_ip"));
				fm.setMadangUpdatedDatetime(rs.getTimestamp("madang_updated_datetime"));
				fm.setMadangUpdatedIp(rs.getString("madang_updated_ip"));
				fm.setMadangRecCount(rs.getInt("madang_rec_count"));
				fm.setMadangRepCount(rs.getInt("madang_rep_count"));
				fm.setMadangReadCount(rs.getInt("madang_read_count"));
				fm.setMadangFilePresence(rs.getString("madang_file_presence").charAt(0));
				fm.setMadangImgPresence(rs.getString("madang_img_presence").charAt(0));
				fm.setProfilePath(service.selectNo(fm.getMadangWriterUid()).getMemPhoto());
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return fm;
	}
	
	public Map<String, FreeMadang> selectPreNext(Connection conn, int madangNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Map<String, FreeMadang> preNext=new HashMap<String, FreeMadang>();
		String sql=prop.getProperty("selectPreNext");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, madangNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				FreeMadang prev=new FreeMadang();
				prev.setMadangNo(rs.getInt("prev"));
				prev.setMadangTitle(rs.getString("prev_title"));
				preNext.put("prev", prev);
				FreeMadang next=new FreeMadang();
				next.setMadangNo(rs.getInt("next"));
				next.setMadangTitle(rs.getString("next_title"));
				preNext.put("next", next);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		} return preNext;
	}
	
	public int updateReadCount(Connection conn, int madangNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updateReadCount");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, madangNo);
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int insertMadang(Connection conn, FreeMadang fm) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("insertMadang");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, fm.getMadangWriterUid());
			pstmt.setString(2, fm.getMadangWriterEmail());
			pstmt.setString(3, fm.getMadangWriterName());
			pstmt.setString(4, fm.getMadangTitle());
			pstmt.setString(5, fm.getMadangContent());
			pstmt.setString(6, fm.getMadangRegisterIp());
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int selectSeqCurrval(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String sql=prop.getProperty("selectSeqCurrval");
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int checkWriter(Connection conn, FreeMadang fm) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("checkWriter");
			
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, fm.getMadangNo());
			pstmt.setInt(2, fm.getMadangWriterUid());
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int updateMadang(Connection conn, FreeMadang fm) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updateMadang");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, fm.getMadangTitle());
			pstmt.setString(2, fm.getMadangContent());
			pstmt.setString(3, fm.getMadangUpdatedIp());
			pstmt.setString(4, String.valueOf(fm.getMadangFilePresence()));
			pstmt.setString(5, String.valueOf(fm.getMadangImgPresence()));
			pstmt.setInt(6, fm.getMadangNo());
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int deleteMadang(Connection conn, FreeMadang fm) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("deleteMadang");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, fm.getMadangNo());
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int insertFile(Connection conn, FreeMadangFile fmf) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("insertFile");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, fmf.getMadangNo());
			pstmt.setInt(2, fmf.getMemberNo());
			pstmt.setString(3, fmf.getFmfOriginalFilename());
			pstmt.setString(4, fmf.getFmfRenameFilename());
			pstmt.setLong(5, fmf.getFmfFilesize());
			pstmt.setString(6, fmf.getFmfType());
			pstmt.setString(7, fmf.getFmfIp());
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
	
	public int updateMadangRepCount(Connection conn, int madangNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("updateMadangRepCount");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, madangNo);
			pstmt.setInt(2, madangNo);
			result=pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		} return result;
	}
 }
