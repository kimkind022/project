package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.StoryDAO;


public class StoryDeleteProService {
	
	public boolean isArticleWriter(int postId, String memberId) throws Exception {
		boolean isArticleWriter = false;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		isArticleWriter = storyDAO.isArticleBoardWriter(postId, memberId);
		close(con);
		return isArticleWriter;
		
	}

	public boolean removeArticle(int board_num) throws Exception{
		boolean isRemoveSuccess = false;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		int deleteCount = storyDAO.deleteArticle(board_num);
		
		if(deleteCount > 0){
			storyDAO.deleteAllReply(board_num);
			storyDAO.deleteAllHeart(board_num);
			
			commit(con);
			isRemoveSuccess=true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isRemoveSuccess;
	}

}
