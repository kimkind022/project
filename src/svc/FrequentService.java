package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDAO;
import dao.ProductDAO;
import dao.OrderDAO;
import dto.BoardBean;
import dto.OrderBean;
import dto.ProductBean;

public class FrequentService {
	
	public ArrayList<ProductBean> articleListOrdered(String memberId) throws Exception {
	    System.out.println("3. 위치: FrequentService.java - 상태: articleListOrdered 들어옴");

	    Connection con = getConnection();
	    ProductDAO productDAO = ProductDAO.getInstance();
	    productDAO.setConnection(con);

	    ArrayList<ProductBean> articleListOrdered = productDAO.articleListOrdered(memberId);
	    System.out.println("5. 위치: FrequentService 아래 articleListOrdered. 상태: 개별 memberId가 주문한 적이 있는 productId들을 orders테이블에서 검색해서. "
	        + "그 productid들을 가지고  products에서 모든정보출력해서 담은 ArrayList를 가지고 돌아왔음. ");
	    System.out.println("articleListOrdered :" + articleListOrdered);
	   
	    close(con);

	    return articleListOrdered;
	  }


  public ArrayList<OrderBean> dataOrdersList(String memberId) throws Exception {
    System.out.println("7. 위치 : FrequentService, 상태: getDataFromOrders로 들어옴");

    OrderBean orderList = null;

    Connection con = getConnection();
    OrderDAO orderDAO = OrderDAO.getInstance();
    orderDAO.setConnection(con);

    ArrayList<OrderBean> dataOrdersList = orderDAO.dataOrdersList(memberId);
    // System.out.println("dataOrdersList : " + dataOrdersList);
    System.out.println("9. 위치 : FrequentService, getDataFromOrders. "
        + "상태: selectDataFromOrder로 들어가서 order테이블에서 정보 뽑아서 ArrayLis반환받아서 돌아온 상태");
    close(con);
    return dataOrdersList;
  }


  public ArrayList<BoardBean> reviewCheck(String memberId) throws Exception {
 
    Connection con = getConnection();
    BoardDAO boardDAO = BoardDAO.getInstance();
    boardDAO.setConnection(con);

    ArrayList<BoardBean> reviewCheck = boardDAO.reviewCheck(memberId);
    close(con);
    return reviewCheck;
  }


}
