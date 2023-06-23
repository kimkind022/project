package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.BoardDAO;
import dao.HeartDataDAO;
import dto.BoardBean;

public class HeartSelectService {

	public int heartDataSelectCheck(String memberId, String productId) throws Exception {
		System.out.println("위치: HeartSelectService heartDataSelectCheck메소드.");
	   
		Connection con = getConnection();
	    HeartDataDAO heartDataDAO = HeartDataDAO.getInstance();
	    heartDataDAO.setConnection(con);
	   
	    int heartDataSelectCheck = heartDataDAO.heartDataSelectCheck(memberId, productId);
	    System.out.println("위치: HeartDataService.java 상태: HeartDataDAO에서 반환받아온 heartDataSelectCheck값: "+ heartDataSelectCheck);
	    return heartDataSelectCheck;
	       
	   
	}
	
}
