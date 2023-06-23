package dao;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.TreeMap;
import dto.FundingHeartsDTO;
import dto.FundingOptionDTO;
import dto.FundingOrdersDTO;
import dto.FundingPostDTO;
import dto.FundingReplyDTO;
import dto.InquiryDTO;
import dto.MembersBean;
import dto.PageStatusDTO;

public class FundingDAO {

  Connection connection;
  private static FundingDAO fundingDAO;

  private FundingDAO() {}

  public static FundingDAO getInstance() {
    if (fundingDAO == null) {
      fundingDAO = new FundingDAO();
    }
    return fundingDAO;
  }

  public void setConnection(Connection connection) {
    this.connection = connection;
  }

  public int selectFundingListConut(PageStatusDTO pageStatusDTO) {
    int listCount = 0;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String sql = "select count(*) from fundingpost fundingpost ";
    sql += pageStatusDTO.getStatus();

    try {
      statement = connection.prepareStatement(sql);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        listCount = resultSet.getInt(1);
      }
    } catch (Exception e) {
      System.out.println(e);
    } finally {
      close(resultSet);
      close(statement);
    }

    return listCount;
  }

  public ArrayList<FundingPostDTO> selectFundingList(PageStatusDTO pageStatusDTO) {
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    ArrayList<FundingPostDTO> fundingList = new ArrayList<FundingPostDTO>();
    FundingPostDTO fundingBean = null;


    String sql = "select fundingpost.* , min(fundingoption.price) as price from fundingpost fundingpost , fundingoption fundingoption ";
    sql += pageStatusDTO.getStatus();
    sql += "group by  fundingpost.id ";
    sql += pageStatusDTO.getStatus2();
    sql += "limit ? , ? ";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, (pageStatusDTO.getPage() - 1) * pageStatusDTO.getLimit());
      statement.setInt(2, pageStatusDTO.getLimit());
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        fundingBean = new FundingPostDTO();
        fundingBean.setId(resultSet.getInt("id"));
        fundingBean.setSellerId(resultSet.getString("sellerId"));
        fundingBean.setCategory(resultSet.getString("category"));
        fundingBean.setTitle(resultSet.getString("title"));
        fundingBean.setTargetAmount(resultSet.getInt("targetAmount"));
        fundingBean.setStartDate(resultSet.getTimestamp("startDate"));
        fundingBean.setEndDate(resultSet.getTimestamp("endDate"));
        fundingBean.setReadCount(resultSet.getInt("readCount"));
        fundingBean.setThumbnail(resultSet.getString("thumbnail"));
        fundingBean.setStoryImage(resultSet.getString("storyImage"));
        fundingBean.setRewardsImage(resultSet.getString("rewardsImage"));
        fundingBean.setNewsImage(resultSet.getString("newsImage"));

        fundingList.add(fundingBean);

      }
    } catch (Exception e) {
      System.out.println(e);
    } finally {
      close(resultSet);
      close(statement);
    }
    return fundingList;
  }

  public TreeMap<String, String> selectSellerNicknameList(PageStatusDTO pageStatusDTO) {
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    TreeMap<String, String> sellerNicknameList = new TreeMap<String, String>();
    String sellerId = null;
    String sellerNickname = null;

    String sql = "select members.id , members.nickname "
        + "from members members "
        + "inner join (select fundingpost.sellerId from fundingpost fundingpost ";
    sql += pageStatusDTO.getStatus();
    sql += pageStatusDTO.getStatus2();
    sql += "limit ?,?) fundingpost on members.id = fundingpost.sellerId group by members.id";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, (pageStatusDTO.getPage() - 1) * pageStatusDTO.getLimit());
      statement.setInt(2, pageStatusDTO.getLimit());
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        sellerId = resultSet.getString("id");
        sellerNickname = resultSet.getString("nickname");
        sellerNicknameList.put(sellerId, sellerNickname);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return sellerNicknameList;
  }

  public TreeMap<Integer, FundingOptionDTO> selectFundingOptionList(PageStatusDTO pageStatusDTO) {
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    TreeMap<Integer, FundingOptionDTO> fundingOptionList = new TreeMap<Integer, FundingOptionDTO>();
    FundingOptionDTO fundingOptionBean = null;

    String sql = "select fundingoption.id , fundingoption.fundingId , fundingoption.`options` , min(fundingoption.price) as `price` , fundingoption.`limit` "
        + "from fundingoption fundingoption " 
        + "inner join (select fundingpost.id from fundingpost fundingpost ";
    sql += pageStatusDTO.getStatus();
    sql += pageStatusDTO.getStatus2();
    sql += "limit ?,?) fundingpost "
        + "on fundingoption.fundingId = fundingpost.id "
        + "group by fundingoption.fundingId "
        + "order by fundingoption.fundingId desc";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, (pageStatusDTO.getPage() - 1) * pageStatusDTO.getLimit());
      statement.setInt(2, pageStatusDTO.getLimit());
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        fundingOptionBean = new FundingOptionDTO();
        fundingOptionBean.setId(resultSet.getInt("id"));
        fundingOptionBean.setFundingId(resultSet.getInt("fundingId"));
        fundingOptionBean.setOptions(resultSet.getString("options"));
        fundingOptionBean.setPrice(resultSet.getInt("price"));
        fundingOptionBean.setLimit(resultSet.getInt("limit"));
        fundingOptionList.put(Integer.valueOf(fundingOptionBean.getFundingId()), fundingOptionBean);
      }
    } catch (Exception e) {
      System.out.println(e);
    } finally {
      close(resultSet);
      close(statement);
    }
    return fundingOptionList;
  }

  public TreeMap<Integer, FundingOrdersDTO> selectFundingCostList(PageStatusDTO pageStatusDTO) {
    TreeMap<Integer, FundingOrdersDTO> fundingCostList = new TreeMap<Integer, FundingOrdersDTO>();
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    FundingOrdersDTO fundingCost = null;

    String sql = "select fundingorders.fundingId , sum(fundingorders.cost) as cost "
        + "from fundingorders fundingorders "
        + "inner join (select fundingpost.id from fundingpost fundingpost ";
    sql += pageStatusDTO.getStatus();
    sql += pageStatusDTO.getStatus2();
    sql += "limit ?,?) fundingpost "
    + "on fundingorders.fundingId = fundingpost.id "
    + "group by fundingorders.fundingId "
    + "order by fundingorders.fundingId desc";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, (pageStatusDTO.getPage() - 1) * pageStatusDTO.getLimit());
      statement.setInt(2, pageStatusDTO.getLimit());
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        fundingCost = new FundingOrdersDTO();
        fundingCost.setFundingId(resultSet.getInt("fundingId"));
        fundingCost.setCost(resultSet.getInt("cost"));
        fundingCostList.put(Integer.valueOf(fundingCost.getFundingId()), fundingCost);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }
    return fundingCostList;
  }

  public int insertFunding(FundingPostDTO fundingBean) {
    int result = 0;
    PreparedStatement statement = null;

    String sql = "insert into fundingpost " + "(sellerId,category,title,targetAmount,endDate,"
        + "readCount,thumbnail,storyImage,rewardsImage,newsImage) " + "values (?,?,?,?,?,0,?,?,?,?)";

    try {
      statement = connection.prepareStatement(sql);
      statement.setString(1, fundingBean.getSellerId());
      statement.setString(2, fundingBean.getCategory());
      statement.setString(3, fundingBean.getTitle());
      statement.setInt(4, fundingBean.getTargetAmount());
      statement.setString(5, String.valueOf(fundingBean.getEndDate()));
      statement.setString(6, fundingBean.getThumbnail());
      statement.setString(7, fundingBean.getStoryImage());
      statement.setString(8, fundingBean.getRewardsImage());
      statement.setString(9, fundingBean.getNewsImage());

      result = statement.executeUpdate();
      System.out.println(statement.toString());
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(statement);
    }

    return result;
  }

  public int selectLastFunding() {
    int fundingId = 0;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select max(id) as id from fundingpost";

    try {
      statement = connection.prepareStatement(sql);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        fundingId = resultSet.getInt("id");
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return fundingId;
  }

  public int insertFundingOption(FundingOptionDTO fundingOptionBean) {
    int result = 0;
    PreparedStatement statement = null;

    String sql = "insert into fundingoption " + "(fundingId , options , price , `limit`) " + "values (?,?,?,?)";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingOptionBean.getFundingId());
      statement.setString(2, fundingOptionBean.getOptions());
      statement.setInt(3, fundingOptionBean.getPrice());
      statement.setInt(4, fundingOptionBean.getLimit());
      result = statement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(statement);
    }

    return result;
  }

  public int updateFundingReadCount(int id) {
    int updateCount = 0;
    PreparedStatement statement = null;

    String sql = "update fundingpost set readCount = readCount+1 where id = ?";
    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, id);
      updateCount = statement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(statement);
    }
    return updateCount;
  }

  public FundingPostDTO selectFundingDetail(int id) {
    FundingPostDTO fundingPostBean = null;

    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from fundingpost where id = ?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, id);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        fundingPostBean = new FundingPostDTO();
        fundingPostBean.setId(resultSet.getInt("id"));
        fundingPostBean.setSellerId(resultSet.getString("sellerId"));
        fundingPostBean.setCategory(resultSet.getString("category"));
        fundingPostBean.setTitle(resultSet.getString("title"));
        fundingPostBean.setTargetAmount(resultSet.getInt("targetAmount"));
        fundingPostBean.setStartDate(resultSet.getTimestamp("startDate"));
        fundingPostBean.setEndDate(resultSet.getTimestamp("endDate"));
        fundingPostBean.setReadCount(resultSet.getInt("readCount"));
        fundingPostBean.setThumbnail(resultSet.getString("thumbnail"));
        fundingPostBean.setStoryImage(resultSet.getString("storyImage"));
        fundingPostBean.setRewardsImage(resultSet.getString("rewardsImage"));
        fundingPostBean.setNewsImage(resultSet.getString("newsImage"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return fundingPostBean;
  }

  public String selectNicknameById(String id) {
    String Nickname = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select nickname from members where id = ?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setString(1, id);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        Nickname = resultSet.getString("nickname");
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return Nickname;
  }

  public TreeMap<Integer, FundingOrdersDTO> getFundingCost(int fundingId) {
    TreeMap<Integer, FundingOrdersDTO> fundingOrdersList = new TreeMap<Integer, FundingOrdersDTO>();
    FundingOrdersDTO fundingOrdersBean = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql =
        "select optionsId , sum(orderAmount) as orderAmount , sum(cost) as cost from fundingorders where fundingId = ? group by optionsId";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingId);
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        fundingOrdersBean = new FundingOrdersDTO();
        fundingOrdersBean.setOptionsId(resultSet.getInt("optionsId"));
        fundingOrdersBean.setCost(resultSet.getInt("cost"));
        fundingOrdersBean.setOrderAmount(resultSet.getInt("orderAmount"));
        fundingOrdersList.put(Integer.valueOf(fundingOrdersBean.getOptionsId()), fundingOrdersBean);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return fundingOrdersList;
  }

  public TreeMap<Integer, FundingOptionDTO> getFundingDetailOption(int fundingId) {
    TreeMap<Integer, FundingOptionDTO> fundingOptionList = new TreeMap<Integer, FundingOptionDTO>();
    FundingOptionDTO optionBean = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from fundingoption where fundingId = ?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingId);
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        optionBean = new FundingOptionDTO();
        optionBean.setId(resultSet.getInt("id"));
        optionBean.setFundingId(resultSet.getInt("fundingId"));
        optionBean.setOptions(resultSet.getString("options"));
        optionBean.setPrice(resultSet.getInt("price"));
        optionBean.setLimit(resultSet.getInt("limit"));
        fundingOptionList.put(Integer.valueOf(optionBean.getId()), optionBean);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }
    return fundingOptionList;
  }

  public MembersBean findMembersbyId(String id) {
    MembersBean membersBean = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from members where id = ?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setString(1, id);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        membersBean = new MembersBean();
        membersBean.setId(resultSet.getString("id"));
        membersBean.setPw(resultSet.getString("pw"));
        membersBean.setName(resultSet.getString("name"));
        membersBean.setNickname(resultSet.getString("nickname"));
        membersBean.setBirthday(resultSet.getString("birthday"));
        membersBean.setTel(resultSet.getString("tel"));
        membersBean.setAddress1(resultSet.getString("address1"));
        membersBean.setAddress2(resultSet.getString("address2"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return membersBean;
  }

  public int insertFundingOrderList(FundingOrdersDTO fundingOrdersBean) {
    int result = 0;
    PreparedStatement statement = null;

    String sql =
        "insert into fundingorders (memberId , fundingId , optionsId , orderAmount , address , cost) values (?,?,?,?,?,?)";

    try {
      statement = connection.prepareStatement(sql);
      statement.setString(1, fundingOrdersBean.getMemberId());
      statement.setInt(2, fundingOrdersBean.getFundingId());
      statement.setInt(3, fundingOrdersBean.getOptionsId());
      statement.setInt(4, fundingOrdersBean.getOrderAmount());
      statement.setString(5, fundingOrdersBean.getAddress());
      statement.setInt(6, fundingOrdersBean.getCost());

      result = statement.executeUpdate();

    } catch (Exception e) {
      e.printStackTrace();
    }

    return result;
  }

  public TreeMap<String, FundingHeartsDTO> selectfundingHearts(int fundingId) {
    TreeMap<String, FundingHeartsDTO> heartsList = new TreeMap<String, FundingHeartsDTO>();
    FundingHeartsDTO fundingHeartsBean = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from fundinghearts where postId = ?";
    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingId);

      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        fundingHeartsBean = new FundingHeartsDTO();
        fundingHeartsBean.setPostId(resultSet.getInt("postId"));
        fundingHeartsBean.setMemberId(resultSet.getString("memberId"));
        fundingHeartsBean.setDate(resultSet.getTimestamp("date"));
        heartsList.put(fundingHeartsBean.getMemberId(), fundingHeartsBean);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return heartsList;
  }

  public int selectFundingHearts(int postId, String memberId) {
    int result = 0;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from fundinghearts where postId = ? and memberId = ?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, postId);
      statement.setString(2, memberId);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        result = postId;
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return result;
  }

  public int insertFundingHearts(int postId, String memberId) {
    int result = 0;
    PreparedStatement statement = null;

    String sql = "insert into fundinghearts (postId , memberId) values (?,?)";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, postId);
      statement.setString(2, memberId);
      result = statement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(statement);
    }

    return result;
  }

  public int deleteFundingHearts(int postId, String memberId) {
    int result = 0;
    PreparedStatement statement = null;

    String sql = "delete from fundinghearts where postId = ? and memberId = ?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, postId);
      statement.setString(2, memberId);
      result = statement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(statement);
    }

    return result;
  }

  public TreeMap<Integer, FundingReplyDTO> selectFundingReplyList(int fundingId) {
    TreeMap<Integer, FundingReplyDTO> replyList = new TreeMap<Integer, FundingReplyDTO>(Collections.reverseOrder());
    FundingReplyDTO fundingreplyBean = null;

    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from fundingreply "
        + "inner join("
        + "select members.id as membersId2 , members.nickname , members.profileImage "
        + "from members) members "
        + "on fundingreply.memberId = membersId2"
        + " where fundingId = ? order by date desc";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingId);
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        fundingreplyBean = new FundingReplyDTO();
        fundingreplyBean.setId(resultSet.getInt("id"));
        fundingreplyBean.setFundingId(resultSet.getInt("fundingId"));
        fundingreplyBean.setMemberId(resultSet.getString("memberId"));
        fundingreplyBean.setDate(resultSet.getTimestamp("date"));
        fundingreplyBean.setContents(resultSet.getString("contents"));
        
        MembersBean membersBean = new MembersBean();
        membersBean.setNickname(resultSet.getString("nickname"));
        membersBean.setProfileImage(resultSet.getString("profileImage"));
        fundingreplyBean.setMembersBean(membersBean);
        
        replyList.put(Integer.valueOf(fundingreplyBean.getId()), fundingreplyBean);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return replyList;
  }

  public int FundingReplyWrite(FundingReplyDTO fundingreplyBean) {
    int result = 0;

    PreparedStatement statement = null;

    String sql = "insert into fundingreply (fundingId , memberId , contents) values (?,?,?)";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingreplyBean.getFundingId());
      statement.setString(2, fundingreplyBean.getMemberId());
      statement.setString(3, fundingreplyBean.getContents());
      result = statement.executeUpdate();
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(statement);
    }

    return result;
  }

  public ArrayList<InquiryDTO> selectInquiryList(PageStatusDTO pageStatusDTO) {
    ArrayList<InquiryDTO> inquiryList = new ArrayList<InquiryDTO>();
    InquiryDTO inquiryBean = null;

    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select * from inquiry order by id desc limit ?,?";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, (pageStatusDTO.getPage() - 1) * pageStatusDTO.getLimit());
      statement.setInt(2, pageStatusDTO.getLimit());
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        inquiryBean = new InquiryDTO();
        inquiryBean.setId(resultSet.getInt("id"));
        inquiryBean.setMemberId(resultSet.getString("memberId"));
        inquiryBean.setTitle(resultSet.getString("title"));
        inquiryBean.setContents(resultSet.getString("contents"));
        inquiryBean.setDate(resultSet.getTimestamp("date"));
        inquiryList.add(inquiryBean);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }


    return inquiryList;
  }

  public int getInquiryListCount() {
    int listCount = 0;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select count(*) as `count` from inquiry";

    try {
      statement = connection.prepareStatement(sql);
      resultSet = statement.executeQuery();

      if (resultSet.next()) {
        listCount = resultSet.getInt("count");
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return listCount;
  }

  public TreeMap<String, String> selectInquiryNicknameList(PageStatusDTO pageStatusDTO) {
    TreeMap<String, String> nicknameList = new TreeMap<String, String>();
    String id = null;
    String nickname = null;

    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select a.id , a.nickname " + "from members as a "
        + "inner join (select * from inquiry order by id desc limit ?,?) as b " + "on a.id = b.memberId "
        + "group by a.id";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, (pageStatusDTO.getPage() - 1) * pageStatusDTO.getLimit());
      statement.setInt(2, pageStatusDTO.getLimit());
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        id = resultSet.getString("id");
        nickname = resultSet.getString("nickname");
        nicknameList.put(id, nickname);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return nicknameList;
  }

  public TreeMap<String, String> selectFundingReplyNicknameList(int fundingId) {
    TreeMap<String, String> nicknameList = new TreeMap<String, String>();
    String id = null;
    String nickname = null;

    PreparedStatement statement = null;
    ResultSet resultSet = null;

    String sql = "select members.id , members.nickname from members "
        + "inner join (select fundingreply.* from fundingreply where fundingreply.fundingId = ?) as fundingreply "
        + "on members.id = fundingreply.memberId group by members.id";

    try {
      statement = connection.prepareStatement(sql);
      statement.setInt(1, fundingId);
      resultSet = statement.executeQuery();

      while (resultSet.next()) {
        id = resultSet.getString("id");
        nickname = resultSet.getString("nickname");
        nicknameList.put(id, nickname);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      close(resultSet);
      close(statement);
    }

    return nicknameList;
  }

}
