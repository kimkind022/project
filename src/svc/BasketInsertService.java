package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.BasketDAO;
import dao.BoardDAO;
import dto.BasketBean;
import dto.BoardBean;

public class BasketInsertService {
  public boolean registItemOnBasket(BasketBean basketBean) throws Exception {
    System.out.println("위치: BasketInsertService.java, 상태: registerItemOnBasket메소드 들어옴");
    System.out.println("basketBean : " + basketBean);

    boolean isInsertSuccess = false;
    Connection con = getConnection();
    BasketDAO basketDAO = BasketDAO.getInstance();
    basketDAO.setConnection(con);
    int insertCount = basketDAO.insertItem(basketBean);
    System.out.println("insertCount : " + insertCount);

    if (insertCount > 0) {
      commit(con);
      isInsertSuccess = true;
    } else {
      rollback(con);
    }

    close(con);
    return isInsertSuccess;
  }
}
