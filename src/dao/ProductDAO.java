package dao;

import static db.JdbcUtil.close;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.sql.DataSource;
import dto.BoardBean;
import dto.ProductBean;
import dto.ProductBeanCategoryCount;

import dto.ProductBeanWithReviewCount;

public class ProductDAO {

	DataSource ds;
	Connection con;
	private static ProductDAO productDAO;

	private ProductDAO() {}

	public static ProductDAO getInstance() {
		if (productDAO == null) {
			productDAO = new ProductDAO();
		}
		return productDAO;
	}

	public void setConnection(Connection con) {
		this.con = con;
	}

	public ProductBean selectArticleWhere(int productId) {
		System.out.println("4. 위치: ProductDAO속 selectArticleWhere메소드로 들어옴. 상태: 셀렉 입력하기전. ");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean productBean = null;

		try {
			pstmt = con.prepareStatement("select * from products where id = ?");
			pstmt.setInt(1, productId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				productBean = new ProductBean();
				productBean.setId(rs.getInt("id"));
				productBean.setSellerId(rs.getString("sellerId"));
				productBean.setName(rs.getString("name"));
				productBean.setCategory(rs.getString("category"));
				productBean.setOrigin(rs.getString("origin"));
				productBean.setInfo(rs.getString("info"));
				productBean.setUploadDate(rs.getString("uploadDate"));
				productBean.setProductOption(rs.getString("productOption"));
				productBean.setPrice(rs.getInt("price"));
				productBean.setDiscountRate(rs.getInt("discountRate"));
				productBean.setStock(rs.getInt("stock"));
				productBean.setImageNo1(rs.getString("imageNo1"));
				productBean.setImageNo2(rs.getString("imageNo2"));
				productBean.setImageNo3(rs.getString("imageNo3"));
				productBean.setImageNo4(rs.getString("imageNo4"));
				productBean.setImageNo5(rs.getString("imageNo5"));
			}
			System.out.println("? 잘들어갔는지 확인하는 법 : " + pstmt.toString());
		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}

		return productBean;

	}

	// storeMain페이지에 신상품보여줄때 쓰임
	public ArrayList<ProductBean> selectArticleAllasList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean productBean = null;

		ArrayList<ProductBean> articleListAll = new ArrayList<ProductBean>();


		try {
			pstmt = con.prepareStatement("select * from products order by uploadDate desc;");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				productBean = new ProductBean();
				productBean.setId(rs.getInt("id"));
				productBean.setSellerId(rs.getString("sellerId"));
				productBean.setName(rs.getString("name"));
				productBean.setCategory(rs.getString("category"));
				productBean.setOrigin(rs.getString("origin"));
				productBean.setInfo(rs.getString("info"));
				productBean.setUploadDate(rs.getString("uploadDate"));
				productBean.setProductOption(rs.getString("productOption"));
				productBean.setPrice(rs.getInt("price"));
				productBean.setDiscountRate(rs.getInt("discountRate"));
				productBean.setStock(rs.getInt("stock"));
				productBean.setImageNo1(rs.getString("imageNo1"));
				productBean.setImageNo2(rs.getString("imageNo2"));
				productBean.setImageNo3(rs.getString("imageNo3"));
				productBean.setImageNo4(rs.getString("imageNo4"));
				productBean.setImageNo5(rs.getString("imageNo5"));

				articleListAll.add(productBean);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return articleListAll;
	}

	public ArrayList<ProductBean> articleListOrdered(String memberId) {
		System.out.println("4. 위치: productDAO.articleListOrdered 들어옴");
		// System.out.println(memberId);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		String sql = "";
		ProductBean productBean = null;
		ArrayList<ProductBean> articleListOrdered = new ArrayList<ProductBean>();
		try {
			
			sql = "select count(*) from (select * from products where id in (select productId from orders where memberId =? order by orderDate)) as kk";
			//갯수셈
			pstmt = con.prepareStatement(sql);
		    pstmt.setString(1, memberId);
		    rs = pstmt.executeQuery();
		    
		    if (rs.next()) {
			    count = rs.getInt("count(*)");
			    System.out.println("count: " + count);
			    int secondCount = (count-5);
			    System.out.println(secondCount);
			    
			    
			    // 길동이가 주문한 적이 있는 상품의 아이디를 조건으로 해서. 상품테이블에서 상품의 정보를 전부 담은 리스트. 
			    
			    sql ="select * from products where id in (select productId from orders where memberId =? order by orderDate desc) limit ?,5";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memberId);
				pstmt.setInt(2, secondCount);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					productBean = new ProductBean();
					productBean.setId(rs.getInt("id"));
					productBean.setSellerId(rs.getString("sellerId"));
					productBean.setName(rs.getString("name"));
					productBean.setCategory(rs.getString("category"));
					productBean.setOrigin(rs.getString("origin"));
					productBean.setInfo(rs.getString("info"));
					productBean.setUploadDate(rs.getString("uploadDate"));
					productBean.setProductOption(rs.getString("productOption"));
					productBean.setPrice(rs.getInt("price"));
					productBean.setDiscountRate(rs.getInt("discountRate"));
					productBean.setStock(rs.getInt("stock"));
					productBean.setImageNo1(rs.getString("imageNo1"));
					productBean.setImageNo2(rs.getString("imageNo2"));
					productBean.setImageNo3(rs.getString("imageNo3"));
					productBean.setImageNo4(rs.getString("imageNo4"));
					productBean.setImageNo5(rs.getString("imageNo5"));
	
					articleListOrdered.add(productBean);
				}
		    }
		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}

		return articleListOrdered;

	}

	// Basket페이지에서 상품 썸네일사진, 이름 보여줄 사용
	public ArrayList<ProductBean> selectNameAndThumbnail(String memberId) {
		System.out.println("위치: productDAO.selectNameAndThumbnail 들어옴");
		// System.out.println(memberId);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean productBean = null;

		ArrayList<ProductBean> articleList = new ArrayList<ProductBean>();

		try {
			pstmt = con.prepareStatement(
					"select * from products where id in (select productId from storeBasket where memberId= ? );");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				productBean = new ProductBean();

				productBean.setId(rs.getInt("id"));
				productBean.setName(rs.getString("name"));
				productBean.setImageNo1(rs.getString("imageNo1"));

				articleList.add(productBean);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return articleList;
	}
	
//	메인페이지에서 인기상품순 박스에 뿌려줄 데이터 셀렉하는 부분
	public ArrayList<ProductBeanWithReviewCount> mainpageList() {
		System.out.println("위치: productDAO.mainpageList 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBeanWithReviewCount productBeanWithReviewCount = null;
		
		ArrayList<ProductBeanWithReviewCount> mainpageList = new ArrayList<ProductBeanWithReviewCount>();
		
		try {
			pstmt = con.prepareStatement(
					"select count(rr.productId) as re , p.* from products as p "
					+ "left outer join reviews as rr "
					+ "on rr.productid = p.id "
					+ "left outer join "
					+ " (select productid from heartroom  group by productid order by count(productid) desc limit 100)  as r"
					+ " on r.productid = p.id"
					+ " group by  p.id;"	);
					
			rs = pstmt.executeQuery();

			while (rs.next()) {
				productBeanWithReviewCount = new ProductBeanWithReviewCount();
				
				productBeanWithReviewCount.setRe(rs.getInt("re"));
				
				productBeanWithReviewCount.setId(rs.getInt("id"));
				productBeanWithReviewCount.setSellerId(rs.getString("sellerId"));
				productBeanWithReviewCount.setName(rs.getString("name"));
				productBeanWithReviewCount.setCategory(rs.getString("category"));
				productBeanWithReviewCount.setOrigin(rs.getString("origin"));
				productBeanWithReviewCount.setInfo(rs.getString("info"));
				productBeanWithReviewCount.setUploadDate(rs.getString("uploadDate"));
				productBeanWithReviewCount.setProductOption(rs.getString("productOption"));
				productBeanWithReviewCount.setPrice(rs.getInt("price"));
				productBeanWithReviewCount.setDiscountRate(rs.getInt("discountRate"));
				productBeanWithReviewCount.setStock(rs.getInt("stock"));
				productBeanWithReviewCount.setImageNo1(rs.getString("imageNo1"));
				productBeanWithReviewCount.setImageNo2(rs.getString("imageNo2"));
				productBeanWithReviewCount.setImageNo3(rs.getString("imageNo3"));
				productBeanWithReviewCount.setImageNo4(rs.getString("imageNo4"));
				productBeanWithReviewCount.setImageNo5(rs.getString("imageNo5"));

				mainpageList.add(productBeanWithReviewCount);
			}
		} catch (Exception ex) {
			System.out.println("ex 위치 : " + ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return mainpageList;
	}

	
//  메인페이지에서 카테고리 아이콘 클릭 전 8개만 보여줄 부분. order by uploadDate desc 
//	ajax로 카테고리 아이콘 클릭시 8개만 바꿔서 보여주는 부분 uploadDate desc 
	public ArrayList<ProductBeanCategoryCount> categoryDataList(String category) {
		System.out.println("위치: productDAO.categoryDataList 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBeanCategoryCount productBeanCategoryCount = null;
		
		ArrayList<ProductBeanCategoryCount> categoryDataList = new ArrayList<ProductBeanCategoryCount>();
		
		String sql = "SELECT *, (select count(productId) FROM reviews WHERE p.id = reviews.productId GROUP BY productID) AS reviewCount "
	            + "FROM products AS p ";
			
			if ( !("전체").equals(category) ) {
				sql += "WHERE category = '"+category+"'" ;
	        }
			
			sql += "ORDER BY uploadDate desc "
	            + "limit 0, 8";
			
			try {
				pstmt = con.prepareStatement
						(sql);


		
			rs = pstmt.executeQuery();
			System.out.println( "00000" );

			while (rs.next()) {
				productBeanCategoryCount = new ProductBeanCategoryCount();
				
				productBeanCategoryCount.setId(rs.getInt("id"));
				productBeanCategoryCount.setSellerId(rs.getString("sellerId"));
				productBeanCategoryCount.setName(rs.getString("name"));
				productBeanCategoryCount.setCategory(rs.getString("category"));
				productBeanCategoryCount.setOrigin(rs.getString("origin"));
				productBeanCategoryCount.setInfo(rs.getString("info"));
				productBeanCategoryCount.setUploadDate(rs.getString("uploadDate"));
				productBeanCategoryCount.setProductOption(rs.getString("productOption"));
				productBeanCategoryCount.setPrice(rs.getInt("price"));
				productBeanCategoryCount.setDiscountRate(rs.getInt("discountRate"));
				productBeanCategoryCount.setStock(rs.getInt("stock"));
				productBeanCategoryCount.setImageNo1(rs.getString("imageNo1"));
				productBeanCategoryCount.setImageNo2(rs.getString("imageNo2"));
				productBeanCategoryCount.setImageNo3(rs.getString("imageNo3"));
				productBeanCategoryCount.setImageNo4(rs.getString("imageNo4"));
				productBeanCategoryCount.setImageNo5(rs.getString("imageNo5"));
				
				productBeanCategoryCount.setReviewCount(rs.getInt("reviewCount"));

				categoryDataList.add(productBeanCategoryCount);
			}
		} catch (Exception ex) {
			System.out.println("ex 위치 productDAO: " + ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return categoryDataList;
	}
	
	
	//카테고리별 더보기 버튼 눌렀을 떄 넘어갈 페이지에서 처음으로 상품들 뿌려줄 부분, 최신순으로 정렬한
	public ArrayList<ProductBeanCategoryCount> categoryShowMoreList(String category) {
		System.out.println("위치: productDAO.categoryShowMoreList 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ProductBeanCategoryCount productBeanCategoryCount = null;
		
		ArrayList<ProductBeanCategoryCount> categoryShowMoreList = new ArrayList<ProductBeanCategoryCount>();
		sql = "SELECT *, (select count(productId) FROM reviews WHERE p.id = reviews.productId GROUP BY productID) AS reviewCount "
	            + "FROM products AS p ";
			
			if (!("전체").equals(category)) {
			  sql += "WHERE category = '"+category+"'" ;
	        }
			
			sql += "ORDER BY uploadDate desc "
	            + "limit 0, 12";
			
			try {
				pstmt = con.prepareStatement
						(sql);


		
		
			rs = pstmt.executeQuery();

			while (rs.next()) {
				productBeanCategoryCount = new ProductBeanCategoryCount();
				
				productBeanCategoryCount.setId(rs.getInt("id"));
				productBeanCategoryCount.setSellerId(rs.getString("sellerId"));
				productBeanCategoryCount.setName(rs.getString("name"));
				productBeanCategoryCount.setCategory(rs.getString("category"));
				productBeanCategoryCount.setOrigin(rs.getString("origin"));
				productBeanCategoryCount.setInfo(rs.getString("info"));
				productBeanCategoryCount.setUploadDate(rs.getString("uploadDate"));
				productBeanCategoryCount.setProductOption(rs.getString("productOption"));
				productBeanCategoryCount.setPrice(rs.getInt("price"));
				productBeanCategoryCount.setDiscountRate(rs.getInt("discountRate"));
				productBeanCategoryCount.setStock(rs.getInt("stock"));
				productBeanCategoryCount.setImageNo1(rs.getString("imageNo1"));
				productBeanCategoryCount.setImageNo2(rs.getString("imageNo2"));
				productBeanCategoryCount.setImageNo3(rs.getString("imageNo3"));
				productBeanCategoryCount.setImageNo4(rs.getString("imageNo4"));
				productBeanCategoryCount.setImageNo5(rs.getString("imageNo5"));

				productBeanCategoryCount.setReviewCount(rs.getInt("reviewCount"));

				categoryShowMoreList.add(productBeanCategoryCount);
			}
		} catch (Exception ex) {
			System.out.println("ex 위치 : " + ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		System.out.println("위치: ProductDAO, categoryShowMoreList메소드, categoryShowMoreList반환하기 전");
		System.out.println("반환할 값 categoryShowMoreList: " +categoryShowMoreList);
		return categoryShowMoreList;
	}
	
	
	
	
	
	public ArrayList<ProductBeanCategoryCount> categoryOrderByList(String category, String selectOption) {
		System.out.println("위치:ProductDAO, categoryOrderByList메소드 들어옴");
		ArrayList<ProductBeanCategoryCount> categoryOrderByList = null;
		
		
		if("최신순".equals(selectOption)) {
			System.out.println("if문 중 최신순 인 경우");
			categoryOrderByList = orderByRecentList( category );
		}
		else if("좋아요순".equals(selectOption)) {
			System.out.println("if문 중 좋아요순 인 경우");
			categoryOrderByList = orderByHeartList( category );
		}
		else if("리뷰순".equals(selectOption)) {
			System.out.println("if문 중 리뷰순 인 경우");
			categoryOrderByList = orderByReviewList( category );
		}
		else if("판매량순".equals(selectOption)) {
			System.out.println("if문 중 판매량순 인 경우");
			categoryOrderByList = orderByOrderList( category );
		}
		return categoryOrderByList;

	}
		
	
	//	카테고리 최신순으로 정렬한 products.* + Count
	public ArrayList<ProductBeanCategoryCount> orderByRecentList(String category) {
		System.out.println("위치:ProductDAO, orderByHeartList메소드 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ArrayList<ProductBeanCategoryCount> orderByHeartList = new ArrayList<ProductBeanCategoryCount>();
		ProductBeanCategoryCount productBeanCategoryCount = null;
	
			try {
				sql = "SELECT *, (select count(productId) FROM reviews WHERE p.id "
						+ "= reviews.productId GROUP BY productID ) AS reviewCount "
						+ "FROM products AS p ";
				
				if (!("전체").equals(category)) {
				  sql += "WHERE category = '"+category+"'" ;
		        
				}
				  sql += "order by uploadDate desc "
					   + "limit 0,12";
						
				pstmt = con.prepareStatement( sql );
	
				rs = pstmt.executeQuery();
				
				while( rs.next() ) {
					productBeanCategoryCount = new ProductBeanCategoryCount();
					
					productBeanCategoryCount.setId(rs.getInt("id"));
					productBeanCategoryCount.setSellerId(rs.getString("sellerId"));
					productBeanCategoryCount.setName(rs.getString("name"));
					productBeanCategoryCount.setCategory(rs.getString("category"));
					productBeanCategoryCount.setOrigin(rs.getString("origin"));
					productBeanCategoryCount.setInfo(rs.getString("info"));
					productBeanCategoryCount.setUploadDate(rs.getString("uploadDate"));
					productBeanCategoryCount.setProductOption(rs.getString("productOption"));
					productBeanCategoryCount.setPrice(rs.getInt("price"));
					productBeanCategoryCount.setDiscountRate(rs.getInt("discountRate"));
					productBeanCategoryCount.setStock(rs.getInt("stock"));
					productBeanCategoryCount.setImageNo1(rs.getString("imageNo1"));
					productBeanCategoryCount.setImageNo2(rs.getString("imageNo2"));
					productBeanCategoryCount.setImageNo3(rs.getString("imageNo3"));
					productBeanCategoryCount.setImageNo4(rs.getString("imageNo4"));
					productBeanCategoryCount.setImageNo5(rs.getString("imageNo5"));
					
//					productBeanCategoryCount.setCount(rs.getInt("count"));
					productBeanCategoryCount.setReviewCount(rs.getInt("reviewCount"));

					orderByHeartList.add(productBeanCategoryCount);
					
				}
			}catch(Exception e) {
				System.out.println(e);
			}
			return orderByHeartList;
		}
		
		
	//	카테고리 좋아요 많은	순으로 정렬한 products.* + heartCount
	public ArrayList<ProductBeanCategoryCount> orderByHeartList(String category) {
		System.out.println("위치:ProductDAO, orderByHeartList메소드 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ArrayList<ProductBeanCategoryCount> orderByHeartList = new ArrayList<ProductBeanCategoryCount>();
		ProductBeanCategoryCount productBeanCategoryCount = null;
	
			try {
				sql = "SELECT p.*, ifnull(count(h.productId),0) AS count, (SELECT count(productId) FROM reviews WHERE p.id "
						+ "= reviews.productId GROUP BY productId) AS reviewCount "
						+ "FROM products AS p "
						
						+ "LEFT OUTER JOIN heartroom AS h "
						+ "ON p.Id = h.productId ";
						
						if (!("전체").equals(category)) {
							  sql += "WHERE category = '"+category+"'" ;
						}
				
			     sql += "GROUP BY p.id "
						+ "ORDER BY count desc limit 0,12";		
				
				pstmt = con.prepareStatement( sql );
					
				rs = pstmt.executeQuery();
				
				while( rs.next() ) {
					productBeanCategoryCount = new ProductBeanCategoryCount();
					
					productBeanCategoryCount.setId(rs.getInt("id"));
					productBeanCategoryCount.setSellerId(rs.getString("sellerId"));
					productBeanCategoryCount.setName(rs.getString("name"));
					productBeanCategoryCount.setCategory(rs.getString("category"));
					productBeanCategoryCount.setOrigin(rs.getString("origin"));
					productBeanCategoryCount.setInfo(rs.getString("info"));
					productBeanCategoryCount.setUploadDate(rs.getString("uploadDate"));
					productBeanCategoryCount.setProductOption(rs.getString("productOption"));
					productBeanCategoryCount.setPrice(rs.getInt("price"));
					productBeanCategoryCount.setDiscountRate(rs.getInt("discountRate"));
					productBeanCategoryCount.setStock(rs.getInt("stock"));
					productBeanCategoryCount.setImageNo1(rs.getString("imageNo1"));
					productBeanCategoryCount.setImageNo2(rs.getString("imageNo2"));
					productBeanCategoryCount.setImageNo3(rs.getString("imageNo3"));
					productBeanCategoryCount.setImageNo4(rs.getString("imageNo4"));
					productBeanCategoryCount.setImageNo5(rs.getString("imageNo5"));
					
					productBeanCategoryCount.setCount(rs.getInt("count"));
					productBeanCategoryCount.setReviewCount(rs.getInt("reviewCount"));
					
					orderByHeartList.add(productBeanCategoryCount);
					
				}
			}catch(Exception e) {
				System.out.println(e);
			}
			return orderByHeartList;
		}


	
    //	카테고리 리뷰 많은 순으로 정렬한 products.* + reviewCount
	public ArrayList<ProductBeanCategoryCount> orderByReviewList(String category) {
		System.out.println("위치:ProductDAO, orderByReviewList메소드 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ProductBeanCategoryCount productBeanCategoryCount = null;
		ArrayList<ProductBeanCategoryCount> orderByReviewList = new ArrayList<ProductBeanCategoryCount>();
		
		try {
			sql = "SELECT p.*, ifnull(count(r.productId),0) as count, (SELECT count(productId) FROM reviews WHERE p.id "
					+ "= reviews.productId GROUP BY productId) AS reviewCount "
					+ "FROM products AS p "
					+ "LEFT OUTER JOIN reviews AS r "
					+ "ON p.Id = r.productId ";
					
				if (!("전체").equals(category)) {
						  sql += "WHERE category = '"+category+"'" ;
					}
					
			sql +="GROUP BY p.id "
				+ "order by count desc "
				+ "limit 0,12";	
										
			pstmt = con.prepareStatement( sql );
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				productBeanCategoryCount = new ProductBeanCategoryCount();
				
				productBeanCategoryCount.setId(rs.getInt("id"));
				productBeanCategoryCount.setSellerId(rs.getString("sellerId"));
				productBeanCategoryCount.setName(rs.getString("name"));
				productBeanCategoryCount.setCategory(rs.getString("category"));
				productBeanCategoryCount.setOrigin(rs.getString("origin"));
				productBeanCategoryCount.setInfo(rs.getString("info"));
				productBeanCategoryCount.setUploadDate(rs.getString("uploadDate"));
				productBeanCategoryCount.setProductOption(rs.getString("productOption"));
				productBeanCategoryCount.setPrice(rs.getInt("price"));
				productBeanCategoryCount.setDiscountRate(rs.getInt("discountRate"));
				productBeanCategoryCount.setStock(rs.getInt("stock"));
				productBeanCategoryCount.setImageNo1(rs.getString("imageNo1"));
				productBeanCategoryCount.setImageNo2(rs.getString("imageNo2"));
				productBeanCategoryCount.setImageNo3(rs.getString("imageNo3"));
				productBeanCategoryCount.setImageNo4(rs.getString("imageNo4"));
				productBeanCategoryCount.setImageNo5(rs.getString("imageNo5"));
				
				productBeanCategoryCount.setCount(rs.getInt("count"));
				productBeanCategoryCount.setReviewCount(rs.getInt("reviewCount"));
				
				orderByReviewList.add(productBeanCategoryCount);
				
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return orderByReviewList;
	}
	
	
//	카테고리 판매량 많은 순으로 정렬한 products.* + orderCount
	public ArrayList<ProductBeanCategoryCount> orderByOrderList(String category) {
		System.out.println("위치:ProductDAO, orderByOrderList메소드 들어옴");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ProductBeanCategoryCount productBeanCategoryCount = null;
		ArrayList<ProductBeanCategoryCount> orderByOrderList = new ArrayList<ProductBeanCategoryCount>();
		
		try {
			sql = "SELECT p.*, ifnull(count(o.productId),0) as count, (SELECT count(productId) FROM reviews WHERE p.id "
					+ "= reviews.productId GROUP BY productId) AS reviewCount "
					+ "FROM products p "
					+ "LEFT OUTER JOIN orders o "
					+ "ON p.Id = o.productId ";
					
					if (!("전체").equals(category)) {
						  sql += "WHERE category = '"+category+"'" ;
					}

			sql += "GROUP BY p.id limit 0, 12";	
			
					
			pstmt = con.prepareStatement( sql );
			

			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				productBeanCategoryCount = new ProductBeanCategoryCount();
				
				productBeanCategoryCount.setId(rs.getInt("id"));
				productBeanCategoryCount.setSellerId(rs.getString("sellerId"));
				productBeanCategoryCount.setName(rs.getString("name"));
				productBeanCategoryCount.setCategory(rs.getString("category"));
				productBeanCategoryCount.setOrigin(rs.getString("origin"));
				productBeanCategoryCount.setInfo(rs.getString("info"));
				productBeanCategoryCount.setUploadDate(rs.getString("uploadDate"));
				productBeanCategoryCount.setProductOption(rs.getString("productOption"));
				productBeanCategoryCount.setPrice(rs.getInt("price"));
				productBeanCategoryCount.setDiscountRate(rs.getInt("discountRate"));
				productBeanCategoryCount.setStock(rs.getInt("stock"));
				productBeanCategoryCount.setImageNo1(rs.getString("imageNo1"));
				productBeanCategoryCount.setImageNo2(rs.getString("imageNo2"));
				productBeanCategoryCount.setImageNo3(rs.getString("imageNo3"));
				productBeanCategoryCount.setImageNo4(rs.getString("imageNo4"));
				productBeanCategoryCount.setImageNo5(rs.getString("imageNo5"));
				
				productBeanCategoryCount.setCount(rs.getInt("count"));
				productBeanCategoryCount.setReviewCount(rs.getInt("reviewCount"));
				
				orderByOrderList.add(productBeanCategoryCount);
				
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return orderByOrderList;
	}
	
}