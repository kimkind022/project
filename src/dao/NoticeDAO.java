package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;

import dto.MembersBean;
import dto.NoticeDTO;
import util.Dateutil;

public class NoticeDAO {
	static Connection conn = null;
	static Statement stmt = null;
	ArrayList<MembersBean> arr = new ArrayList<MembersBean>();

	public static void Con() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false",
					"root", "1234");
			stmt = conn.createStatement();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public static void Close() {
		try {
			stmt.close();
		} catch (Exception e) {
		}
		try {
			conn.close();
		} catch (Exception e) {
		}
	}

	public static int insertArticle(NoticeDTO article) {
		int rowNum = 0;
		try {
			Con();
			String command = String.format(
					"insert into notice (memberId, sendId, url, data, readCount) values('%s','%s','%s','%s',0);",
					article.getMemberId(), article.getSendId(), article.getUrl(), article.getData());
			rowNum = stmt.executeUpdate(command);

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			Close();
		}

		return rowNum;

	}

	public int selectListCount(String memberId) {

		int listCount = 0;
		PreparedStatement pstmt = null;
		String sql = "select count(*) from notice where memberId='" + memberId + "' and readCount=0;" ;

		try {
			Con();
			ResultSet rs = stmt.executeQuery(sql);

			if (rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (Exception ex) {

		} finally {
			Close();
		}
		return listCount;

	}

	public ArrayList<NoticeDTO> selectArticleList(String memberId, int postId, int page, int limit) {
		int startrow = (page - 1) * 10;
		String sql = "select * from notice where memberId='" + postId + "' order by id desc limit " + startrow + ",10";
		ArrayList<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		NoticeDTO notice = null;

		try {
			Con();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				notice = new NoticeDTO();
				notice.setId(rs.getInt("id"));
				notice.setMemberId(rs.getString("memberId"));
				notice.setSendId(rs.getString("memberId"));
				notice.setUrl(rs.getString("contents"));
				notice.setData(rs.getString("data"));

				Timestamp date = rs.getTimestamp("createdTime");
				String dateTrans = Dateutil.txtDate(date);
				notice.setDateTrans(dateTrans);
				notice.setReadCount(rs.getInt("readCount"));

				noticeList.add(notice);
			}

		} catch (Exception e) {
			System.out.println(e);

		} finally {
			Close();
		}

		return noticeList;

	}
}
