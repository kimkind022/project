package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import action.ProductAction;
import dao.BasketDAO;
import dao.BoardDAO;
import dao.MembersDAO;
import dao.ProductDAO;
import dao.OrderDAO;
import dto.BasketBean;
import dto.BoardBean;
import dto.MembersBean;
import dto.OrderBean;
import dto.ProductBean;

public class BasketService {

  // storeBasket에서 가격, 수량 부분 보여줄 때 사용, Basket테이블에서 내가 장바구니에 담은적이 있는 것을
  // memberId를 조건으로 다 뽑아서 담아온 ArrayList
  public ArrayList<BasketBean> getArticleAddedInBasket(String memberId) throws Exception {
    System.out.println("3. 위치: BasketService, memberId: " + memberId);

    Connection con = getConnection();
    BasketDAO basketDAO = BasketDAO.getInstance();
    basketDAO.setConnection(con);

    ArrayList<BasketBean> addedInBasket = basketDAO.selectArticleAddedInBasket(memberId);
    System.out.println("4. adedInBasket: " + addedInBasket);
    close(con);

    return addedInBasket;

  }

  public ArrayList<ProductBean> getProductList(String memberId) throws Exception {

    Connection con = getConnection();
    ProductDAO productDAO = ProductDAO.getInstance();
    productDAO.setConnection(con);

    ArrayList<ProductBean> productList = productDAO.selectNameAndThumbnail(memberId);
    System.out.println("위치: BassketService, 상태:productList: " + productList);

    close(con);
    return productList;

  }
  
  public MembersBean getAddressBean(String memberId) throws Exception {

	    MembersBean membersBean = null;
	    
	    Connection con = getConnection();
	    MembersDAO membersDAO = MembersDAO.getInstance();
	    membersDAO.setCon(con);

	    membersBean = membersDAO.selectAddress(memberId);   //membersBean에는 address1과 address2가 담겨있음. 
	    System.out.println("위치: BasketService의 getAddressBean, 상태:membersBean: " + membersBean);

	    close(con);
	    return membersBean;

	  }
  
  
  
}
