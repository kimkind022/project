package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.TreeMap;

import dao.FundingDAO;
import dto.FundingHeartsDTO;

public class FundingHeartsService {

  // 단일 펀딩 좋아요 리스트 select
  public TreeMap<String, FundingHeartsDTO> selectfundingHearts(int fundingId) {
    TreeMap<String, FundingHeartsDTO> heartsList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    heartsList = fundingDAO.selectfundingHearts(fundingId);

    close(connection);

    return heartsList;
  }

  // 단일 펀딩 좋아요 select
  public int selectFundingHeartsService(int postId, String memberId) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.selectFundingHearts(postId, memberId);

    close(connection);

    return result;
  }

  // 단일 펀딩 좋아요 insert
  public void insertFundingHeartsService(int postId, String memberId) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.insertFundingHearts(postId, memberId);

    if (result == 0) {
      rollback(connection);
    } else {
      commit(connection);
    }

    close(connection);
  }

  // 단일 펀딩 좋아요 delete
  public void deleteFundingHeartsService(int postId, String memberId) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.deleteFundingHearts(postId, memberId);

    if (result == 0) {
      rollback(connection);
    } else {
      commit(connection);
    }

    close(connection);

  }

}
