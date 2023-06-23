package svc;
import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.StoryDAO;
import dto.StoryPostsDTO;
import dto.StoryProductsDTO;

public class StoryDetailService {

	public StoryPostsDTO getArticle(int id) throws Exception{
		StoryPostsDTO article = null;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		int updateCount = storyDAO.updateReadCount(id);
		
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		
		article = storyDAO.selectArticle(id);
		close(con);
		return article;
		
	}
	
	public ArrayList<StoryProductsDTO> getProductsList(int id) throws Exception{ // 글 데이터 가져오기
		
		ArrayList<StoryProductsDTO> articleList = null;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		articleList = storyDAO.selectProductList(id);
		close(con);
		return articleList;
	}
}
