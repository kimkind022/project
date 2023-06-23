package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.GongguDAO;



public class GongguDeleteProService {
	
	public boolean isArticleWriter(int postId, String memberId) throws Exception {
		boolean isArticleWriter = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		isArticleWriter = gongguDAO.isArticleBoardWriter(postId, memberId);
		close(con);
		return isArticleWriter;
		
	}

	public boolean removeArticle(int board_num) throws Exception{
		boolean isRemoveSuccess = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		int deleteCount = gongguDAO.deleteArticle(board_num);
		
		if(deleteCount > 0){
			gongguDAO.deleteAllReply(board_num);
			gongguDAO.deleteAllHeart(board_num);
			gongguDAO.deleteAllPersonnel(board_num);
			
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
