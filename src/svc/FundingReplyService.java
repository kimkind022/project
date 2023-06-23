package svc;

import static db.JdbcUtil.*;


import java.sql.Connection;
import java.util.TreeMap;

import dao.FundingDAO;
import dto.FundingReplyDTO;

public class FundingReplyService {

  // 펀딩 리플 insert
  public void fundingReplyWriteService(FundingReplyDTO fundingreplyBean) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.FundingReplyWrite(fundingreplyBean);

    if (result == 0) {
      rollback(connection);
    } else {
      commit(connection);
    }
    close(connection);
  }

  // 단일 펀딩 리플 리스트 select
  public TreeMap<Integer, FundingReplyDTO> selectFundingReplyList(int fundingId) {
    TreeMap<Integer, FundingReplyDTO> replyList = new TreeMap<Integer, FundingReplyDTO>();
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    replyList = fundingDAO.selectFundingReplyList(fundingId);

    close(connection);

    return replyList;
  }

  public TreeMap<String, String> selectFundingReplyNicknameList(int fundingId) {
    TreeMap<String, String> nicknameList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);
    
    nicknameList = fundingDAO.selectFundingReplyNicknameList(fundingId);
    
    close(connection);
    
    return nicknameList;
  }

}
