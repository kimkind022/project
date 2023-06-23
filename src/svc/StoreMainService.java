package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import action.ProductAction;
import dao.BoardDAO;
import dao.ProductDAO;
import dto.BoardBean;
import dto.ProductBean;
import dto.ProductBeanCategoryCount;
import dto.ProductBeanWithReviewCount;

public class StoreMainService {
	
	
  public ArrayList<ProductBeanWithReviewCount> mainpageList() throws Exception {	
	  	System.out.println("StoreMainService 들어옴 mainpageList 메소드");
	    Connection con = getConnection();
	    ProductDAO productDAO = ProductDAO.getInstance();
	    productDAO.setConnection(con);
	    
	    ArrayList<ProductBeanWithReviewCount> mainpageList = productDAO.mainpageList();
	    System.out.println("위치: StoreMainService.java 상태:productDAO에서 가져온 mainpageList " + mainpageList);

	    close(con);

	    return mainpageList;

	  }
  
  public ArrayList<ProductBeanCategoryCount> categoryDataList(String category) throws Exception {
	  	System.out.println("StoreMainService 들어옴 mainpageList 메소드");
	  	Connection con = getConnection();
	    ProductDAO productDAO = ProductDAO.getInstance();
	    productDAO.setConnection(con);

	    ArrayList<ProductBeanCategoryCount> categoryDataList = productDAO.categoryDataList(category);
	    System.out.println("위치: StoreMainService.java 상태:productDAO에서 가져온 categoryDataList " + categoryDataList);

	    close(con);

	    return categoryDataList;
  }
	
}
