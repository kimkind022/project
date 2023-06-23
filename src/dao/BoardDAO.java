package dao;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.sql.DataSource;
import dto.BoardBean;
import dto.MembersBean;
import dto.ProductBean;

public class BoardDAO {

  DataSource ds;
  Connection con;
  private static BoardDAO boardDAO;

  private BoardDAO() {}

  public static BoardDAO getInstance() {
    if (boardDAO == null) {
      boardDAO = new BoardDAO();
    }
    return boardDAO;
  }

  public void setConnection(Connection con) {
    this.con = con;
  }

  public int selectListCount(int id) {

    int listCount = 0;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String board_list_sql = "select count(*) from reviews where productId = ?"; //

    try {
      pstmt = con.prepareStatement(board_list_sql);
      pstmt.setInt(1, id);
      rs = pstmt.executeQuery();

      if (rs.next()) {
        listCount = rs.getInt(1);
      }
    } catch (Exception ex) {
      System.out.println(ex);

    } finally {
      close(rs);
      close(pstmt);
    }
    System.out.println(id);
    return listCount;
  }

  // 리뷰갯수 가져오는 메소드
  public int selectListCountWhere(int productId) {

    int listCountWhere = 0;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String board_list_sql = "select count(*) from reviews where productId= ?";
    try {
      pstmt = con.prepareStatement(board_list_sql);
      pstmt.setInt(1, productId);
      rs = pstmt.executeQuery();

      if (rs.next()) {
        listCountWhere = rs.getInt(1);
      }
    } catch (Exception ex) {
      System.out.println(ex);

    } finally {
      close(rs);
      close(pstmt);
    }

    return listCountWhere;

  }

  public ArrayList<BoardBean> selectArticleList(int page, int limit, int productId) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String board_list_sql = "select * from reviews where productid=? order by id desc limit ?,?";
    ArrayList<BoardBean> reviewList = new ArrayList<BoardBean>();
    BoardBean board = null;
    int startrow = (page - 1) * 5;

    try {
      pstmt = con.prepareStatement(board_list_sql);
      pstmt.setInt(1, productId);
      pstmt.setInt(2, startrow);
      pstmt.setInt(3, limit);
      rs = pstmt.executeQuery();

      while (rs.next()) {
        board = new BoardBean();
        board.setId(rs.getInt("id"));
        board.setOrderId(rs.getString("orderId"));
        board.setProductId(rs.getInt(1));
        board.setContents(rs.getString("contents"));;
        board.setDate(rs.getString("date"));
        board.setRating(rs.getInt("rating"));
        board.setFile(rs.getString("file"));


        reviewList.add(board);
      }

    } catch (Exception ex) {
      // System.out.println(ex);
    } finally {
      close(rs);
      close(pstmt);
    }

    return reviewList;
  }

  public String checkAlreadyWritten(String memberId) {
    System.out.println("12. 위치: BoardDAO.java 상태 checkAlreadyWritten메소드로 들어옴.");

    String ReviewWrittenOrNot = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String board_list_sql =
        "select orderId from reviews where orderid in (select orderId from orders where memberId = ?)";

    ArrayList<BoardBean> reviewList = new ArrayList<BoardBean>();
    BoardBean board = null;


    try {
      pstmt = con.prepareStatement(board_list_sql);
      pstmt.setString(1, memberId);

      rs = pstmt.executeQuery();

      if (rs.next()) {
        ReviewWrittenOrNot = "reviewExist";
      } else {
        ReviewWrittenOrNot = "reviewDoesntExist";
      }

    } catch (Exception ex) {
      System.out.println(ex);

    } finally {
      close(rs);
      close(pstmt);
    }
    System.out.println("위치: BoardDAO,checkAlreadyWritten메소드. 상태: ReviewWrittenOrNot값 :" + ReviewWrittenOrNot);

    return ReviewWrittenOrNot;
  }

  public ArrayList<BoardBean> reviewCheck(String memberId) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql =
    	//주문한적이 있는 상품의 orderId가 리뷰테이블에 존재하면 그거를 뽑아. 	
        "select orderId from reviews where orderid in (select orderId from orders where memberId = ?)";
    ArrayList<BoardBean> reviewCheck = new ArrayList<BoardBean>();
    BoardBean board = null;

    try {
      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, memberId);

      rs = pstmt.executeQuery();

      while (rs.next()) {
        board = new BoardBean();
        // board.setId(rs.getInt("id"));
        board.setOrderId(rs.getString("orderId"));
        // board.setProductId(rs.getInt("productId"));
        // board.setContents(rs.getString("contents"));;
        // board.setDate(rs.getString("date"));
        // board.setRating(rs.getInt("rating"));
        // board.setFile(rs.getString("file"));

        reviewCheck.add(board);
      }
      System.out.println("? 잘들어갔는지 확인하는 법 : " + pstmt.toString());
    } catch (Exception ex) {
      // System.out.println(ex);
    } finally {
      close(rs);
      close(pstmt);
    }
    System.out.println("위치: BoardDAO 속 cheching메소드. 상태: reviewCheck값 :" + reviewCheck);
    return reviewCheck;
  }

  
  
  public BoardBean selectReview(String orderId, int productId) {
	  	System.out.println("BoardDAO 들어옴 selectReview메소드");
	  	BoardBean boardBean=null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "select * from reviews where orderId =? and productId=?";
	    
	    try {
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, orderId);
	        pstmt.setInt(2, productId);

	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	        	System.out.println("if문들어옴");
	        	boardBean = new BoardBean();
	        	boardBean.setContents(rs.getString("contents"));
	        	boardBean.setRating(rs.getInt("Rating"));
	        	boardBean.setFile(rs.getString("File"));
	        	
	        }
	        
	        System.out.println(pstmt.toString());
	       
	    } catch (Exception e) {
	    	System.out.println("BoardDAO selectReview 오류");
			System.out.println(e);
			System.out.println("BoardDAO selectReview 오류2");
		}
	    return boardBean;
  }
  
  
  
  public int insertReview(BoardBean boardbean) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int num = 0;
    String sql = "";
    int insertCount = 0;

    try {
      pstmt = con.prepareStatement("select max(id) from reviews");
      rs = pstmt.executeQuery();

      if (rs.next())
        num = rs.getInt(1) + 1;
      else
        num = 1;

      sql = "insert into reviews (id, orderId, productId, contents, date,";
      sql += "rating, file) values(?,?,?,?,now(),?,?)";
      System.out.println("dfsdf");
      pstmt = con.prepareStatement(sql);
      pstmt.setInt(1, num);
      pstmt.setString(2, boardbean.getOrderId());
      pstmt.setInt(3, boardbean.getProductId());
      pstmt.setString(4, boardbean.getContents());
      pstmt.setInt(5, boardbean.getRating());
      pstmt.setString(6, boardbean.getFile());

      insertCount = pstmt.executeUpdate();

    } catch (Exception ex) {
      System.out.println(ex);
    } finally {
      close(rs);
      close(pstmt);
    }
    
    return insertCount;

  }
  
 
  public int modifyReview(BoardBean boardbean) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String sql = "";
    int modifyCount = 0;

    try {
      pstmt = con.prepareStatement("select * from reviews");
      rs = pstmt.executeQuery();

      if (rs.next())
    	  System.out.println("작성된 리뷰가 이미 존재하면 update수행");
      	  sql = "UPDATE reviews SET contents = ?, rating = ?, file = ? WHERE orderId = ?"; 
   
	      System.out.println("dfsdf");
	      pstmt = con.prepareStatement(sql);
	      pstmt.setString(1, boardbean.getContents());
	      pstmt.setInt(2, boardbean.getRating());
	      pstmt.setString(3, boardbean.getFile());
	      pstmt.setString(4, boardbean.getOrderId());
	  
	      modifyCount = pstmt.executeUpdate();

    } catch (Exception ex) {
      System.out.println(ex);
    } finally {
      close(rs);
      close(pstmt);
    }
    
    return modifyCount;

  }
  
  

}
