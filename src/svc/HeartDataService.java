package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.BoardDAO;
import dao.HeartDataDAO;
import dto.BoardBean;
import dto.HeartBean;

public class HeartDataService {

	public int heartDataResist(HeartBean heartbean) throws Exception {
		System.out.println("위치: HeartDataService heartDataResist메소드 들어옴.");
	   
		Connection con = getConnection();
	    HeartDataDAO heartDataDAO = HeartDataDAO.getInstance();
	    heartDataDAO.setConnection(con);
	   
	    int checkExecute = heartDataDAO.heartDataResist(heartbean);
	    System.out.println("위치: HeartDataService.java 상태: HeartDataDAO에서 반환받아온 checkExecute값: "+ checkExecute);
	    return checkExecute;
	       
	   
	}
	
}
