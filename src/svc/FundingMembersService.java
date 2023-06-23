package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.FundingDAO;
import dto.MembersBean;

public class FundingMembersService {

  // 아이디로 단일 회원 select
  public MembersBean findMembersbyId(String id) {
    MembersBean membersBean = null;
    Connection connection = getConnection();
    FundingDAO fundingDAO = FundingDAO.getInstance();
    fundingDAO.setConnection(connection);

    membersBean = fundingDAO.findMembersbyId(id);

    close(connection);

    return membersBean;
  }

}
