package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.NoticeDAO;
import dto.NoticeDTO;


public class NoticeService {
	public boolean registArticle(NoticeDTO noticeDTO) throws Exception{
		
		boolean isWriteSuccess = false;
		Connection con = getConnection();
		int insertCount = NoticeDAO.insertArticle(noticeDTO);
		
		
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
