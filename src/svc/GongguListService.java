package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.GongguDAO;
import dto.GongguDTO;

public class GongguListService {

	public int getListCount(String status1, String status2) throws Exception{	// 페이지 나누기
		int listCount = 0;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		listCount = gongguDAO.selectListCount(status1, status2);
		close(con);
		return listCount;
		
	}

	public ArrayList<GongguDTO> getArticleList(int page, int limit, String status1, String status2) throws Exception{ // 글 데이터 가져오기
		
		ArrayList<GongguDTO> articleList = null;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		articleList = gongguDAO.selectArticleList(page,limit,status1, status2);
		close(con);
		return articleList;
		
	}

	public ArrayList<GongguDTO> getMarkerList(String status1, String status2) {
		ArrayList<GongguDTO> articleList = null;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		articleList = gongguDAO.selectMarkerList(status1,status2);
		close(con);
		return articleList;
	}

}