package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.StoryDAO;
import dto.StoryPostsDTO;

public class StoryWriteProService {

	public boolean registArticle(StoryPostsDTO storyDTO) throws Exception{
		
		boolean isWriteSuccess = false;
		Connection con = getConnection();
		StoryDAO storyDAO = StoryDAO.getInstance();
		storyDAO.setConnection(con);
		int insertCount = storyDAO.insertArticle(storyDTO);
		
		if(insertCount > 0){
			commit(con);
			isWriteSuccess = true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isWriteSuccess;
		
	}
}