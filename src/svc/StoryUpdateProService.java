package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.StoryDAO;
import dto.StoryPostsDTO;


public class StoryUpdateProService {
	public boolean isArticleWriter(int board_num, String name) throws Exception {
		boolean isArticleWriter = false;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		isArticleWriter = storyDAO.isArticleBoardWriter(board_num, name);
		close(con);
		return isArticleWriter;
		
	}

	public boolean modifyArticle(StoryPostsDTO article) throws Exception {
		
		boolean isModifySuccess = false;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		int updateCount = storyDAO.updateArticle(article);
		
		if(updateCount > 0){
			commit(con);
			isModifySuccess=true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isModifySuccess;
		
	}
}
