package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoryDAO;
import dto.StoryPostsDTO;

public class StoryListService {
	public int getListCount(String status1) throws Exception{	// 페이지 나누기
		int listCount = 0;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		listCount = storyDAO.selectListCount(status1);
		close(con);
		return listCount;
		
	}

	public ArrayList<StoryPostsDTO> getArticleList(int page, int limit, String status1, String status2) throws Exception{ // 글 데이터 가져오기
		
		ArrayList<StoryPostsDTO> articleList = null;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		articleList = storyDAO.selectArticleList(page,limit,status1, status2);
		close(con);
		return articleList;
		
	}
}
