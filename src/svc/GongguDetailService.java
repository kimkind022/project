package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.CReplyDAO;
import dao.GongguDAO;
import dto.CReplyDTO;
import dto.GongguDTO;
import dto.ProductBean;


public class GongguDetailService {

	public GongguDTO getArticle(int id) throws Exception{
		GongguDTO article = null;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		int updateCount = gongguDAO.updateReadCount(id);
		
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		
		article = gongguDAO.selectArticle(id);
		close(con);
		return article;
		
	}

	public ArrayList<GongguDTO> getPersonnelList(int postId) throws Exception{
		
		ArrayList<GongguDTO> personnelList = null;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);
		personnelList = gongguDAO.selectPersonnelList(postId);
		close(con);
		return personnelList;
		
	}
	
	public ProductBean getProduct(int productid) throws Exception{
		ProductBean article = null;
		Connection con = getConnection();
		GongguDAO gongguDAO = GongguDAO.getInstance();
		gongguDAO.setConnection(con);

		article = gongguDAO.selectProduct(productid);
		close(con);
		return article;
		
	}

}
