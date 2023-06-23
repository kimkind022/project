package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.BoardDAO;
import dto.BoardBean;

public class ReviewModifyService {
	
	public BoardBean selectReview(String orderId, int productId ) throws Exception {
		
		System.out.println("위치: ReviewModifyService, 상태: selectReview들어옴");
		System.out.println("orderId:" + orderId);
		System.out.println("productId:" + productId);
		
	    Connection con = getConnection();
	    BoardDAO boardDAO = BoardDAO.getInstance();
	    boardDAO.setConnection(con);
	    BoardBean selectReview = boardDAO.selectReview(orderId, productId);
	    System.out.println("selectReview : "+selectReview);
	 
	    close(con);
	    return selectReview;
	  }

	
	
	
	public boolean modifyReview(BoardBean boardBean) throws Exception {

	    boolean isModifySuccess = false;
	    Connection con = getConnection();
	    BoardDAO boardDAO = BoardDAO.getInstance();
	    boardDAO.setConnection(con);
	    int insertCount = boardDAO.modifyReview(boardBean);

	    if (insertCount > 0) {
	      commit(con);
	      isModifySuccess = true;
	    } else {
	      rollback(con);
	    }

	    close(con);
	    return isModifySuccess;
	  }
}

