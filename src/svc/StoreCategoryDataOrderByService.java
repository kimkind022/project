package svc;

import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ProductDAO;
import dto.ProductBeanCategoryCount;
import dto.ProductBeanCategoryHeartCount;

public class StoreCategoryDataOrderByService {
	public ArrayList<ProductBeanCategoryCount> categoryOrderByList(String category, String selectOption) throws Exception {
		System.out.println("위치: StoreCategoryDataOrderByHeartService categoryOrderByList 메소드 들어옴.");
	   
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
	   
		
		//	카테고리 좋아요 순으로 정렬한 products.* + heartCount
	    ArrayList<ProductBeanCategoryCount> categoryOrderByList = productDAO.categoryOrderByList(category, selectOption);
	    System.out.println("위치: StoreCategoryDataOrderByService.java 상태: ProductDAO에서 반환받아온 categoryOrderByList: "+ categoryOrderByList);
	    
	    return categoryOrderByList;
	}	

}
 