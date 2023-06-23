package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import dto.HeartBean;
import dto.OrderBean;

public class HeartDataDAO {

	DataSource ds;
	Connection con;
	
	private static HeartDataDAO heartDataDAO;

	private HeartDataDAO() {}

	public static HeartDataDAO getInstance() {
		if (heartDataDAO == null) {
			heartDataDAO = new HeartDataDAO();
		}
		return heartDataDAO;
	}
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	
	public int heartDataSelectCheck(String memberId, String productId) {
	    System.out.println("위치: heartDataDAO 아래 heartDataSelectCheck 메소드. ");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("memberId: " + memberId + " productId: " + productId);
		String sql = "select * from heartroom where memberId=? and productId=?";
		
		int heartDataSelectCheck = 0;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, productId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				heartDataSelectCheck = 1;
			}
			
			System.out.println("반환할 값:" + heartDataSelectCheck);

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}

		return heartDataSelectCheck;
	}
	 
	public int heartDataResist(HeartBean heartbean) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		int checkExecute = 0;
		int result = 0;
		
		try {
			  sql = "select * from heartroom where productId=? and memberId=?";
		      pstmt = con.prepareStatement(sql);
		      pstmt.setString(1, heartbean.getProductId());
		      pstmt.setString(2, heartbean.getMemberId());
		      rs = pstmt.executeQuery();

		      if (rs.next()) {
		        System.out.println("좋아요 테이블에 좋아요 한 적 있으면 delete 수행");
			    sql = "delete from heartroom where productId=? and memberId= ?";
			    //sql = "insert into heartroom values('5','gildong@gmail.com','2022-10-06')"; 	
			    pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, heartbean.getProductId());
		        pstmt.setString(2, heartbean.getMemberId());
		        checkExecute = pstmt.executeUpdate();
		        
			        if(checkExecute == 1) {
			        	result = 1; // 1이면 delete 수행한 것
			        }
		      }
		      else {
		    	  System.out.println("HeartDataDAO, heartDataResist메소드, 좋아요 테이블에 좋아요 한 적 없으면 insert 수행");
		    	  sql = "insert into heartroom(productId, memberId, date) value(?, ?, now())";
		    	  pstmt = con.prepareStatement(sql);
		    	  pstmt.setString(1, heartbean.getProductId());
		    	  pstmt.setString(2, heartbean.getMemberId());
			      checkExecute = pstmt.executeUpdate();
				     
			      	if(checkExecute == 1) {
				        	result = 2; // 2면 insert 수행한 것
				    }
		      }
		} catch (Exception ex) {
	      System.out.println(ex + "ex");
	    } finally {
	      close(rs);
	      close(pstmt);
	    }
	    return result;
	  }

	

}
