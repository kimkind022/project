package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.FundingDAO;
import dto.FundingOrdersDTO;

public class FundingOrderService {

  // 펀딩 주문 insert
  public int insertFundingOrderList(FundingOrdersDTO fundingOrders2Bean) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.insertFundingOrderList(fundingOrders2Bean);

    if (result == 0) {
      rollback(connection);
    } else {
      commit(connection);
    }

    close(connection);

    return result;
  }

}
