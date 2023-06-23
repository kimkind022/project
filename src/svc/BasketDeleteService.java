package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.BasketDAO;
import dao.ProductDAO;
import dto.ProductBean;

public class BasketDeleteService {
  public boolean getDelete(String memberId, int productId) throws Exception {
    boolean isDeleteSuccess = false;

    Connection con = getConnection();
    BasketDAO basketDAO = BasketDAO.getInstance();
    basketDAO.setConnection(con);

    int deleteCheck = basketDAO.deleteItem(memberId, productId);
    System.out.println("deleteCheck : " + deleteCheck);

    if (deleteCheck > 0) {
      commit(con);
      isDeleteSuccess = true;
    } else {
      rollback(con);
    }

    close(con);
    return isDeleteSuccess;

  }
}
