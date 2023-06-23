package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;

import dao.FundingDAO;
import dto.FundingOptionDTO;
import dto.FundingPostDTO;

public class FundingWriteProService {

  // 펀딩 insert
  public int registFunding(FundingPostDTO fundingBean) throws Exception {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);
    result = fundingDAO.insertFunding(fundingBean);
    if (result != 0) {
      commit(connection);
    } else {
      rollback(connection);
    }

    close(connection);

    return result;
  }

  // 마지막 펀딩 id select
  public int selectLastFunding() {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.selectLastFunding();

    close(connection);

    return result;
  }

  // 펀딩 옵션 insert
  public int registFundingOption(FundingOptionDTO fundingOption2Bean) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.insertFundingOption(fundingOption2Bean);

    if (result != 0) {
      commit(connection);
    } else {
      rollback(connection);
    }

    close(connection);

    return result;
  }

}
