package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

import dto.BasketBean;
import dto.BoardBean;

public class BasketDAO {

  DataSource ds;
  Connection con;
  private static BasketDAO basketDAO;

  private BasketDAO() {}

  public static BasketDAO getInstance() {
    if (basketDAO == null) {
      basketDAO = new BasketDAO();
    }
    return basketDAO;
  }

  public void setConnection(Connection con) {
    this.con = con;
  }

  // storeBasket에서 가격, 수량 부분 보여줄 때 사용, Basket테이블에서 내가 장바구니에 담은적이 있는 것을
  // memberId를 조건으로 다 뽑아서 담아온 ArrayList
  public ArrayList<BasketBean> selectArticleAddedInBasket(String memberId) {
    System.out.println("위치: selectArticleAddedInBasket 상태: " + memberId);
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String board_list_sql = " select * from storeBasket where memberId = ? order by addedDate asc ";
    ArrayList<BasketBean> basketList = new ArrayList<BasketBean>();
    BasketBean basket = null;

    try {
      pstmt = con.prepareStatement(board_list_sql);
      pstmt.setString(1, memberId);
      rs = pstmt.executeQuery();

      while (rs.next()) {
        basket = new BasketBean();
        basket.setMemberId(rs.getString(1));
        basket.setProductId(rs.getInt("productId"));
        basket.setPrice(rs.getInt("price"));;
        basket.setAmount(rs.getInt("amount"));

        basketList.add(basket);
      }

    } catch (Exception ex) {
      System.out.println(ex);
    } finally {
      close(rs);
      close(pstmt);
    }
    return basketList;
  }

  public int insertItem(BasketBean basketBean) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
   
    String sql = "";
    int insertCount = 0;

    try {
      sql = "select * from storeBasket where memberId=? and productId=?";
      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, basketBean.getMemberId());
      pstmt.setInt(2, basketBean.getProductId());
      rs = pstmt.executeQuery();

      if (rs.next()) {
        System.out.println("장바구니에 이미 해당상품 존재하면 update수행");
        sql = "UPDATE storeBasket SET amount= (select amount from (select amount from storeBasket where memberId=? and productId=?) as kk)+? "
                + "WHERE memberId=? and productId=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, basketBean.getMemberId());
        pstmt.setInt(2, basketBean.getProductId());
        pstmt.setInt(3, basketBean.getAmount());
        pstmt.setString(4, basketBean.getMemberId());
        pstmt.setInt(5, basketBean.getProductId());

        insertCount = pstmt.executeUpdate();

      } 
      
      else {
        System.out.println("장바구니에 해당상품 존재하지 않으면 insert수행");
        sql = "insert into storeBasket (memberId, productId, price, amount, addedDate) values(?,?,?,?,now())";
        pstmt = con.prepareStatement(sql);
        System.out.println("insert들어감");

        pstmt.setString(1, basketBean.getMemberId());
        pstmt.setInt(2, basketBean.getProductId());
        pstmt.setInt(3, basketBean.getPrice());
        pstmt.setInt(4, basketBean.getAmount());

        insertCount = pstmt.executeUpdate();
      }

    } catch (Exception ex) {
      System.out.println(ex);
    } finally {
      close(rs);
      close(pstmt);
    }
    return insertCount;
  }

  // 장바구니에서 아이템을 삭제할때 들어오는 메소드.
  public int deleteItem(String memberId, int productId) {
    int deleteCount = 0;
    PreparedStatement pstmt = null;
    String sql = "";

    try {
      sql = "delete from storeBasket where memberId=? and productId=?;";
      pstmt = con.prepareStatement(sql);
      pstmt.setString(1, memberId);
      pstmt.setInt(2, productId);

      deleteCount = pstmt.executeUpdate(); // 반환되는 int는 실행되는 갯수가 숫자로 반환됨. 0이 아니면 됐다는 얘기

    } catch (Exception ex) {
      System.out.println(ex);
    } finally {
      close(pstmt);
    }

    return deleteCount;
  }



}
