package svc;

import java.sql.Connection;
import dao.BoardDAO;
import dto.BoardBean;
import static db.JdbcUtil.*;

public class BoardWriteProService {

  public boolean registReview(BoardBean boardBean) throws Exception {

    boolean isWriteSuccess = false;
    Connection con = getConnection();
    BoardDAO boardDAO = BoardDAO.getInstance();
    boardDAO.setConnection(con);
    int insertCount = boardDAO.insertReview(boardBean);

    if (insertCount > 0) {
      commit(con);
      isWriteSuccess = true;
    } else {
      rollback(con);
    }

    close(con);
    return isWriteSuccess;
  }
}
