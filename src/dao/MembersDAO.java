package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;
import dto.MembersBean;
import dto.StoryPostsDTO;
import util.Dateutil;

public class MembersDAO {
	DataSource ds;
	static Connection con;
	private static MembersDAO membersDAO;

	private MembersDAO() {
	}

	public static MembersDAO getInstance() { // 싱글톤 패턴 : 객체를 한 번만 호출해도 됨
		if (membersDAO == null) {
			membersDAO = new MembersDAO();
		}
		return membersDAO;
	}

	public static void setCon(Connection con) {
		MembersDAO.con = con;
	}

	public static String selectNick(String memberId) {
		String nickname = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select * from members where id='" + memberId + "';");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				nickname = rs.getString("nickname");
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return nickname;
	}

	public static MembersBean selectAddress(String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MembersBean membersBean = null;

		String sql = "select * from members where id= ?;";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				membersBean = new MembersBean();
				membersBean.setAddress1(rs.getString("address1"));
				membersBean.setAddress2(rs.getString("address2"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return membersBean;
	}

	public static ArrayList<MembersBean> selectBestMember() {
		PreparedStatement pstmt = null;
		
		String sql = "select id,followerCount, storycount, profileImage from members left outer join ("
				+"select follow.memberId , count(*) followerCount "
				+"from follow group by follow.memberId ) follow "
				+ "  on members.id = follow.memberId "
				+ "left outer join ("
				+"select storyposts.memberId , count(*) storyCount "
				+"from storyposts "
				+"group by storyposts.memberId ) storyposts "
				+"on members.id = storyposts.memberId "
				+"order by followerCount desc, storyCount desc;";

		
		ResultSet rs = null;
		ArrayList<MembersBean> articleList = new ArrayList<MembersBean>();
		MembersBean member = null;
		String id= null;

		try {
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				member = new MembersBean();
				id=rs.getString("id");
				member.setId(id);
				member.setProfileImage(rs.getString("profileImage"));
				member.setNickname(selectNick(id));
				member.setStoryCount(selectStoryCount(id));
				member.setFollowerCount(selectFollowerCount(id));
				articleList.add(member);
			}

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}
		return articleList;
	}

	public static int selectStoryCount(String memberId) {
		int Count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select count(*) from storyPosts where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Count = rs.getInt(1);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return Count;
	}

	public static int selectFollowerCount(String memberId) {
		int Count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select count(*) from follow where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Count = rs.getInt(1);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return Count;
	}
	
	
	//10.21 추가
	public static int isMemberFollowing(String memberId, String followerId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int isfollowing = 0;
		String heart_list_sql = "select followerId from follow where memberId = ?";

		try {
			pstmt = con.prepareStatement(heart_list_sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			boolean b = true;

			if (rs == null) {
				isfollowing = 2;
			}
			while (rs.next() && b) {
				if (followerId.equals(rs.getString("followerId"))) {
					isfollowing = 1;
					b = false;
				} else {
					isfollowing = 0;
				}
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return isfollowing;
	}
	
	public static int selectFollowingCount(String memberId) {
		int Count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select count(*) from follow where followerId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Count = rs.getInt(1);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return Count;
	}
}
