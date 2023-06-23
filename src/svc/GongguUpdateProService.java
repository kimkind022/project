package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.GongguDAO;
import dto.GongguDTO;


public class GongguUpdateProService {
	public boolean isArticleWriter(int postId, String memberId) throws Exception {
		boolean isArticleWriter = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		isArticleWriter = gongguDAO.isArticleBoardWriter(postId, memberId);
		close(con);
		return isArticleWriter;
		
	}

	public boolean modifyArticle(GongguDTO article) throws Exception {
		
		boolean isModifySuccess = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		int updateCount = gongguDAO.updateArticle(article);
		
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
