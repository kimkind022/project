package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.CReplyDAO;
import dao.GongguDAO;
import dao.StoryDAO;

public class CHeartListService {
	
	//// 게시글 좋아요
	public String isHeartExist(String postType, int postId, String memberId) throws Exception{
		
		String heart = null;
		Connection con = getConnection();
		
		if(postType == "gonggu") {
			GongguDAO gongguDAO = GongguDAO.getInstance();
			gongguDAO.setConnection(con);
			heart = gongguDAO.isMemberLikeGonggu(postId, memberId);

			close(con);
		}
		else if(postType == "story") {
			StoryDAO storyDAO = StoryDAO.getInstance();
			storyDAO.setConnection(con);
			heart = storyDAO.isMemberLikeStory(postId, memberId);

			close(con);
		}
		return heart;	
	}
	
	public int getHeartCount(String postType, int postId)throws Exception{
		int heart = 0;
		Connection con = getConnection();
		
		if(postType=="gonggu") {
			GongguDAO gongguDAO = GongguDAO.getInstance();
			gongguDAO.setConnection(con);
			heart = gongguDAO.selectHeartCount(postId);
		}
		else if(postType=="story") {
			StoryDAO storyDAO = StoryDAO.getInstance();
			storyDAO.setConnection(con);
			heart = storyDAO.selectHeartCount(postId);
		}
		close(con);
		return heart;
	}
	
	//// 댓글 좋아요
	public String isReplyHeartExist(String postType, int postId, String memberId) throws Exception{
		
		String heart = null;
		Connection con = getConnection();
		CReplyDAO cReplyDAO = CReplyDAO.getInstance();
		cReplyDAO.setConnection(con);
		heart = cReplyDAO.isMemberLikeReply(postType, postId, memberId);
		

		close(con);
		return heart;	
	}
	
	public int getReplyHeartCount(String PostType, int postId)throws Exception{
		int heart = 0;
		Connection con = getConnection();
		CReplyDAO cReplyDAO = CReplyDAO.getInstance();
		cReplyDAO.setConnection(con);
		heart = cReplyDAO.selectReplyHeartCount(PostType, postId);
		close(con);
		return heart;
	}
}
