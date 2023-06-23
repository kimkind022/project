package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MembersDAO;
import dto.MembersBean;


public class MemberListService {
	public ArrayList<MembersBean> getArticleList() throws Exception{ // 회원 데이터 가져오기
		
		ArrayList<MembersBean> articleList = null;
		Connection con = getConnection();
		MembersDAO membersDAO = MembersDAO.getInstance();
		membersDAO.setCon(con);
		articleList = membersDAO.selectBestMember();
		close(con);
		return articleList;
		
	}
}
