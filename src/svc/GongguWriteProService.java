package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.GongguDAO;
import dto.GongguDTO;

public class GongguWriteProService {

	public boolean registArticle(GongguDTO gongguDTO) throws Exception{
		
		boolean isWriteSuccess = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		int insertCount = gongguDAO.insertArticle(gongguDTO);
		
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
