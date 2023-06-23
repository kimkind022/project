package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;
import dao.BoardDAO;
import dto.BoardBean;

public class BoardListService {

  // 리뷰페이징 부분
  public int getListCount(int id) throws Exception {
    int listCount = 0;
    Connection con = getConnection();
    BoardDAO boardDAO = BoardDAO.getInstance();
    boardDAO.setConnection(con);
    listCount = boardDAO.selectListCount(id);
    System.out.println("위치: BoardListService, listCount 리뷰쓰여진 갯수 : " + listCount);
    close(con);
    return listCount;
  }

  // 리뷰갯수 가져오는 메소드
  public int getListCountWhere(int productId) throws Exception {
    int listCountWhere = 0;
    Connection con = getConnection();
    BoardDAO boardDAO = BoardDAO.getInstance();
    boardDAO.setConnection(con);
    listCountWhere = boardDAO.selectListCountWhere(productId);
    close(con);
    return listCountWhere;
  }

  // 해당상품 리스트 가져오는 메소드
  public ArrayList<BoardBean> getArticleList(int page, int limit, int productId) throws Exception {
    ArrayList<BoardBean> reviewList = null;

    Connection con = getConnection();
    BoardDAO boardDAO = BoardDAO.getInstance();
    boardDAO.setConnection(con);
    reviewList = boardDAO.selectArticleList(page, limit, productId);
    close(con);

    return reviewList;
  }

}
