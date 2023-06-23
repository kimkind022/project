package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.TreeMap;

import dao.FundingDAO;
import dto.FundingOptionDTO;
import dto.FundingOrdersDTO;
import dto.FundingPostDTO;
import dto.PageStatusDTO;

public class FundingListService {

  // 펀딩 수량 select
  public int getListCount(PageStatusDTO pageStatusDTO) throws Exception {
    int listCount = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    listCount = fundingDAO.selectFundingListConut(pageStatusDTO);

    close(connection);

    return listCount;
  }

  // 펀딩 리스트 select
  public ArrayList<FundingPostDTO> getFundingList(PageStatusDTO pageStatusDTO) throws Exception {
    ArrayList<FundingPostDTO> fundingList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    fundingList = fundingDAO.selectFundingList(pageStatusDTO);

    close(connection);

    return fundingList;
  }

  // 펀딩 옵션 리스트 select
  public TreeMap<Integer, FundingOptionDTO> getFundingOptionList(PageStatusDTO pageStatusDTO) throws Exception {
    TreeMap<Integer, FundingOptionDTO> fundingOptionList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    fundingOptionList = fundingDAO.selectFundingOptionList(pageStatusDTO);

    close(connection);

    return fundingOptionList;
  }

  // 펀딩 옵션별 주문량 select
  public TreeMap<Integer, FundingOrdersDTO> getFundingCostList(PageStatusDTO pageStatusDTO) throws Exception {
    TreeMap<Integer, FundingOrdersDTO> fundingCostList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    fundingCostList = fundingDAO.selectFundingCostList(pageStatusDTO);

    close(connection);

    return fundingCostList;
  }

  public TreeMap<String, String> getSellerNicknameList(PageStatusDTO pageStatusDTO) {
    TreeMap<String, String> sellerNicknameList = new TreeMap<String, String>();
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    sellerNicknameList = fundingDAO.selectSellerNicknameList(pageStatusDTO);

    close(connection);

    return sellerNicknameList;
  }


}
