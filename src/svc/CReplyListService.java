package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.CReplyDAO;
import dto.CReplyDTO;

public class CReplyListService {

	public int getListCount(String postType, int id) throws Exception{	// 페이지 나누기
		int listCount = 0;
		Connection con = getConnection();
		CReplyDAO cReplyDAO = CReplyDAO.getInstance();
		cReplyDAO.setConnection(con);
		listCount = cReplyDAO.selectListCount(postType, id);
		close(con);
		return listCount;
		
	}

	public ArrayList<CReplyDTO> getArticleList(String postType, int postId, int page, int limit) throws Exception{ // 글 데이터 가져오기
		
		ArrayList<CReplyDTO> replyList = null;
		Connection con = getConnection();
		CReplyDAO cReplyDAO = CReplyDAO.getInstance();
		cReplyDAO.setConnection(con);
		replyList = cReplyDAO.selectArticleList(postType, postId, page,limit);
		close(con);
		return replyList;
		
	}

}
	
	