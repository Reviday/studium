package com.studium.pstudy.model.service;
import static common.template.JDBCTemplate.close;
import static common.template.JDBCTemplate.commit;
import static common.template.JDBCTemplate.getConnection;
import static common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.studium.fstudy.model.vo.Fstudy;
import com.studium.member.model.vo.Member;
import com.studium.member.model.vo.MyPurchase;
import com.studium.pstudy.model.dao.PstudyDao;
import com.studium.pstudy.model.vo.Pstudy;


public class PstudyService {
	
	private PstudyDao dao=new PstudyDao();
	
	
	public int inserPstudy(Pstudy p) {
		Connection conn =getConnection();
		int result=dao.insertPstudy(conn,p);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
		
	}
	public List<Pstudy> selectMypstudy(){
		Connection conn =getConnection();
		List<Pstudy> list=dao.selectMypstudy(conn);
		close(conn);
		return list;
	}
	
	public int paymentMember(Member m) {
		Connection conn=getConnection();
		int result=dao.paymentMember(conn,m);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public Pstudy selectpStudyVIew(int no) {
		Connection conn=getConnection();
		Pstudy p=dao.selectpStudyVIew(conn,no);
		close(conn);
		return p;
	}
	public List<Pstudy> selectPstudy(int cPage,int numPerPage){
		Connection conn=getConnection();
		List<Pstudy> list=dao.selectPstudy(conn,cPage,numPerPage);
		close(conn);
		return list;
		
	}
	public int deletePstudy(int pNo) {
		Connection conn=getConnection();
		int result=dao.deletePstudy(conn,pNo);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	
	}
	public List<Pstudy> searchPstudy(String setString,String area,String day,String category,int cPage,int numPerPage){
		Connection conn=getConnection();
		List<Pstudy> list=dao.searchPstudy(conn,setString,area,day,category,cPage,numPerPage);
		close(conn);
		return list;
	}
	public int updatePstudy(Pstudy p) {
		Connection conn=getConnection();
		int result=dao.updatePstudy(conn,p);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public List<Pstudy> bestPstudy(){
		Connection conn=getConnection();
		List<Pstudy> list=dao.bestPstudy(conn);
		close(conn);
		return list;
	}
	public int pstudyDibs(int no,int mNo) {
		Connection conn=getConnection();
		int result=dao.pstudyDibs(conn,no,mNo);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public int pstudyDibsDelete(int no,int mNo) {
		Connection conn=getConnection();
		int result=dao.pstudyDibsDelete(conn,no,mNo);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public int selectCountPstudy() {
		Connection conn=getConnection();
		int result=dao.selectCountPstudy(conn);
		close(conn);
		return result;
	}
	public int addPurchaseResult(int mno,int pno) {
		Connection conn=getConnection();
		int result=dao.addPurchaseResult(conn,mno,pno);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public int PurchaseCount(int pno) {
		Connection conn=getConnection();
		int result=dao.PurchaseCount(conn,pno);
		close(conn);
		return result;
	}
	public int addPerson(int pno,int count) {
		Connection conn=getConnection();
		int result=dao.addPerson(conn,pno,count);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public int selectCountSearch(String area, String day, String category) {
		Connection conn=getConnection();
		int result=dao.selectCountSearch(conn,area,day,category);
		close(conn);
		return result;
	}
	public List<Pstudy> selectcategoryList(String category){
		Connection conn=getConnection();
		List<Pstudy> list=dao.selectcategoryList(conn,category);
		close(conn);
		return list;
	}
	public int selectcountCategoryList(String category) {
		Connection conn=getConnection();
		int result=dao.selectcountCategoryList(conn,category);
		close(conn);
		return result;
	}
	public int updatePstudyStar(int pNo,int totalstar) {
		Connection conn=getConnection();
		int result=dao.updatePstudyStar(conn,pNo,totalstar);
		if(result>0) {commit(conn);}
		else {rollback(conn);}
		close(conn);
		return result;
	}
	public List<MyPurchase> selectPurchase(){
		Connection conn=getConnection();
		List<MyPurchase> list=dao.selectPurchase(conn);
		close(conn);
		return list;
	}


}
