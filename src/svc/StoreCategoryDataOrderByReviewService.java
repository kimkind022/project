package svc;

import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ProductDAO;
import dto.ProductBeanCategoryReviewCount;

public class StoreCategoryDataOrderByReviewService {
	public ArrayList<ProductBeanCategoryReviewCount> categoryReviewCountList(String category) throws Exception {
		System.out.println("위치: StoreCategoryDataOrderByReviewService categoryReviewCountList 메소드 들어옴.");
	   
		Connection con = getConnection();
		ProductDAO productDAO = ProductDAO.getInstance();
		productDAO.setConnection(con);
	   
		
		//	카테고리 좋아요 순으로 정렬한 products.* + heartCount
	   /* ArrayList<ProductBeanCategoryReviewCount> categoryReviewCountList = productDAO.categoryReviewCountList(category);*/
		 ArrayList<ProductBeanCategoryReviewCount> categoryReviewCountList = null;
	    System.out.println("위치: StoreCategoryDataOrderByReviewService.java 상태: ProductDAO에서 반환받아온 categoryReviewCountList: "+ categoryReviewCountList);
	    
	    
	    
	    return categoryReviewCountList;
	    
	}
	
}
   