package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BoardDAO;
import dao.HeartDataDAO;
import dao.ProductDAO;
import dto.BoardBean;
import dto.HeartBean;
import dto.ProductBean;
import dto.ProductBeanCategoryCount;

public class StoreCategoryDataService {

	public ArrayList<ProductBeanCategoryCount> categoryDataList(String category) throws Exception {
		System.out.println("위치: StoreCategoryDataService categoryDataList 메소드 들어옴.");
	   
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
	   
	    ArrayList<ProductBeanCategoryCount> categoryDataList = productDAO.categoryDataList(category);
	    System.out.println("위치: StoreCategoryDataService.java 상태: ProductDAO에서 반환받아온 categoryDataList: "+ categoryDataList);
	    
	    close(con);
	    
	    return categoryDataList;
	    
	}
	
}
   