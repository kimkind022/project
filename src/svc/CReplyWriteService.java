package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.CReplyDAO;
import dto.CReplyDTO;

public class CReplyWriteService {

	public boolean registArticle(String postType, CReplyDTO cReplyDTO) throws Exception{
		
		boolean isWriteSuccess = false;
		Connection con = getConnection();
		CReplyDAO cReplyDAO = CReplyDAO.getInstance();
		cReplyDAO.setConnection(con);
		int insertCount = cReplyDAO.insertArticle(postType, cReplyDTO);
		
		
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
