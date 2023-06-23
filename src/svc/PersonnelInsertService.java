package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.GongguDAO;
import dto.GongguDTO;

public class PersonnelInsertService {

	public boolean updatePersonnel(int postId) throws Exception{
		boolean isUpdateSuccess = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		int updateCount = gongguDAO.updatePersonnel(postId);
		
		if(updateCount > 0){
			commit(con);
			isUpdateSuccess=true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isUpdateSuccess;
			
		}

	public boolean insertPersonnel(GongguDTO personnel) throws Exception {
			
		boolean isInsertSuccess = false;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		int insertCount = gongguDAO.insertPersonnel(personnel);
		
		if(insertCount > 0){
			commit(con);
			isInsertSuccess = true;
		}
		else{
			rollback(con);
		}
		
		close(con);
		return isInsertSuccess;
		
	}

}
