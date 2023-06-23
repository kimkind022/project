package svc;

import static db.JdbcUtil.*;


import java.sql.Connection;
import java.util.TreeMap;

import dao.FundingDAO;
import dto.FundingOptionDTO;
import dto.FundingOrdersDTO;
import dto.FundingPostDTO;

public class FundingDetailService {

  // 단일 펀딩 조회수 1증가 update
  public int updateFundingReadCount(int fundingId) {
    int result = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    result = fundingDAO.updateFundingReadCount(fundingId);

    if (result == 0) {
      rollback(connection);
    } else {
      commit(connection);
    }
    close(connection);

    return result;
  }

  // 단일 펀딩 select
  public FundingPostDTO selectFunding(int fundingId) {
    FundingPostDTO fundingPost2Bean = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    fundingPost2Bean = fundingDAO.selectFundingDetail(fundingId);

    close(connection);

    return fundingPost2Bean;
  }

  // 단일 펀딩 옵션 리스트 select
  public TreeMap<Integer, FundingOptionDTO> selectFundingOption(int fundingId) {
    TreeMap<Integer, FundingOptionDTO> fundingOptionList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    fundingOptionList = fundingDAO.getFundingDetailOption(fundingId);

    close(connection);

    return fundingOptionList;
  }

  // 단일 펀딩 옵션별 주문량 리스트 select
  public TreeMap<Integer, FundingOrdersDTO> selectFundingCost(int fundingId) {
    TreeMap<Integer, FundingOrdersDTO> fundingOrdersList = new TreeMap<Integer, FundingOrdersDTO>();
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    fundingOrdersList = fundingDAO.getFundingCost(fundingId);

    close(connection);

    return fundingOrdersList;
  }

}
