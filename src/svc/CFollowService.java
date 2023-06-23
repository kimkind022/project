package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;

import dao.MembersDAO;

public class CFollowService {
	public int isMemberFollowing(String memberId, String followerId) throws Exception {

		int follow = 0;
		Connection con = getConnection();

		MembersDAO membersDAO = MembersDAO.getInstance();
		membersDAO.setCon(con);
		follow = membersDAO.isMemberFollowing(memberId, followerId);

		close(con);

		return follow;
	}

	public int getfollowingCount(String memberId) throws Exception {
		int following = 0;
		Connection con = getConnection();

		MembersDAO membersDAO = MembersDAO.getInstance();
		membersDAO.setCon(con);
		following = membersDAO.selectFollowingCount(memberId);

		close(con);
		return following;
	}

	public int getfollowerCount(String memberId) throws Exception {
		int follower = 0;
		Connection con = getConnection();

		MembersDAO membersDAO = MembersDAO.getInstance();
		membersDAO.setCon(con);
		follower = membersDAO.selectFollowerCount(memberId);
		close(con);
		return follower;
	}
}
