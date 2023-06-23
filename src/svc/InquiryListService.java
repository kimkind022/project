package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.TreeMap;

import dao.FundingDAO;
import dto.InquiryDTO;
import dto.PageStatusDTO;

public class InquiryListService {

  public ArrayList<InquiryDTO> selectInquiryList(PageStatusDTO pageStatusDTO) {
    ArrayList<InquiryDTO> inquiryList = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    inquiryList = fundingDAO.selectInquiryList(pageStatusDTO);

    close(connection);

    return inquiryList;
  }

  public int getInquiryListCount() {
    int listCount = 0;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    listCount = fundingDAO.getInquiryListCount();

    close(connection);

    return listCount;
  }

  public TreeMap<String, String> selectInquiryNicknameList(PageStatusDTO pageStatusDTO) {
    TreeMap<String, String> NicknameList = new TreeMap<String, String>();
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    NicknameList = fundingDAO.selectInquiryNicknameList(pageStatusDTO);

    close(connection);

    return NicknameList;
  }

}
