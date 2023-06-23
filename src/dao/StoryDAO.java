package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;

import dto.StoryPostsDTO;
import dto.StoryProductsDTO;
import util.Dateutil;

public class StoryDAO {
	DataSource ds;
	Connection con;
	private static StoryDAO storyDAO;

	private StoryDAO() {
	}

	public static StoryDAO getInstance() { // 싱글톤 패턴 : 객체를 한 번만 호출해도 됨
		if (storyDAO == null) {
			storyDAO = new StoryDAO();
		}
		return storyDAO;
	}

	public void setConnection(Connection con) {
		this.con = con;
	}

	public String selectNick(String memberId) {
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

	public String selectProfileImg(String memberId) {
		String filename = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select * from members where id='" + memberId + "';");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				filename = rs.getString("profileImage");
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return filename;
	}

	public int selectProductId(int postId) {
		int productId = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select * from storyProducts where postId=" + postId + ";");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				productId = rs.getInt("productId");
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return productId;

	}

	public ArrayList<StoryProductsDTO> selectProductList(int postId) {
		
		//int productId = selectProductId(postId);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String story_list_sql = "select * from products where id in(select productId from storyProducts where postId=?)";
		ArrayList<StoryProductsDTO> articleList = new ArrayList<StoryProductsDTO>();
		StoryProductsDTO product = null;

		try {
			pstmt = con.prepareStatement(story_list_sql);
			pstmt.setInt(1, postId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				product = new StoryProductsDTO();
				product.setProductId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setProductThumbnail(rs.getString("imageNo1"));
				articleList.add(product);
			}

		} catch (Exception e) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return articleList;
	}

	public int selectListCount(String status1) {

		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			if (status1=="empty") {
				pstmt = con.prepareStatement("select count(*) from storyPosts");
			}
			else {
				pstmt = con.prepareStatement("select count(*) from storyPosts where category='"+status1+"'");
			}
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (Exception ex) {

		} finally {
			close(rs);
			close(pstmt);
		}

		return listCount;

	}

	public ArrayList<StoryPostsDTO> selectArticleList(int page, int limit, String status1, String status2) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String story_list_sql= "";

		if (status1=="empty" &&status2=="empty") {
			story_list_sql = "select * from storyPosts order by id desc limit ?,10";
		}
		else if(status1!="empty" &&status2=="empty"){
			story_list_sql = "select * from storyPosts where category='"+status1+"' order by id desc limit ?,10";
		}
		else if("empty".equals(status1) && !"empty".equals(status2)){
			story_list_sql = "select * from storyPosts order by "+status2+" desc, id desc limit ?,10";
			if ("replyCount".equals(status2)) {
				story_list_sql = "select * from storyposts left outer join ("
				+ "select storyreply.postId , count(*) replyCount "
				+ "from storyreply "
				+ "group by storyreply.postId ) storyreply "
				+ "on storyposts.id = storyreply.postId "
				+ "order by replyCount desc limit ?,10";
			}
			else if (status2.equals("heartCount")) {
				story_list_sql = "select * from storyposts left outer join ("
				+ "select storyhearts.postId , count(*) heartCount "
				+ "from storyhearts "
				+ "group by storyhearts.postId ) storyhearts "
				+ "on storyposts.id = storyhearts.postId "
				+ "order by heartCount desc limit ?,10";
			}
		}
		else if(status1!="empty" &&status2!="empty"){
			story_list_sql = "select * from storyPosts where category='"+status1+"' order by "+status2+" desc, id desc limit ?,10";
			if (status2.equals("replyCount")) {
				story_list_sql = "select * from storyposts left outer join ("
				+ "select storyreply.postId , count(*) replyCount "
				+ "from storyreply "
				+ "group by storyreply.postId ) storyreply "
				+ "on storyposts.id = storyreply.postId where storyposts.category='"+status1
				+ "' order by replyCount desc limit ?,10";
			}
			else if (status2.equals("heartCount")) {
				story_list_sql = "select * from storyposts left outer join ("
				+ "select storyhearts.postId , count(*) heartCount "
				+ "from storyhearts "
				+ "group by storyhearts.postId ) storyhearts "
				+ "on storyposts.id = storyhearts.postId where storyposts.category='"+status1
				+ "' order by heartCount desc limit ?,10";
			}
			
			
			
		}
		
		ArrayList<StoryPostsDTO> articleList = new ArrayList<StoryPostsDTO>();
		StoryPostsDTO story = null;
		int startrow = (page - 1) * 10;

		try {
			pstmt = con.prepareStatement(story_list_sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				story = new StoryPostsDTO();
				story.setId(rs.getInt("id"));
				story.setMemberId(rs.getString("memberId"));
				story.setCategory(rs.getString("category"));
				story.setTitle(rs.getString("title"));
				story.setContents(rs.getString("contents"));
				story.setThumbnail(rs.getString("thumbnail"));
				story.setReadCount(rs.getInt("readCount"));

				Timestamp date = rs.getTimestamp("date");
				String dateTrans = Dateutil.txtDate(date);
				story.setDateTrans(dateTrans);

				int id = rs.getInt("id");
				story.setNickname(selectNick(rs.getString("memberId")));
				story.setProfileImage(selectProfileImg(rs.getString("memberId")));

				story.setHeartCount(selectHeartCount(id));
				story.setReplyCount(selectReplyCount(id));

				articleList.add(story);
			}

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return articleList;

	}

	public StoryPostsDTO selectArticle(int id) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StoryPostsDTO storyDTO = null;

		try {
			pstmt = con.prepareStatement("select * from storyPosts where id = ?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				storyDTO = new StoryPostsDTO();
				storyDTO.setId(rs.getInt("id"));
				storyDTO.setMemberId(rs.getString("memberId"));
				storyDTO.setCategory(rs.getString("category"));
				storyDTO.setTitle(rs.getString("title"));
				storyDTO.setContents(rs.getString("contents"));
				storyDTO.setReadCount(rs.getInt("readCount"));
				storyDTO.setThumbnail(rs.getString("thumbnail"));

				Timestamp date = rs.getTimestamp("date");
				String dateTrans = Dateutil.txtDate(date);
				storyDTO.setDateTrans(dateTrans);

				storyDTO.setNickname(selectNick(rs.getString("memberId")));
				storyDTO.setProfileImage(selectProfileImg(rs.getString("memberId")));
			}
		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return storyDTO;

	}

	public int updateReadCount(int id) {

		PreparedStatement pstmt = null;
		int updateCount = 0;
		String sql = "update storyPosts set readCount = " + "readCount+1 where id = " + id;

		try {
			pstmt = con.prepareStatement(sql);
			updateCount = pstmt.executeUpdate();
		} catch (SQLException ex) {
		} finally {
			close(pstmt);

		}

		return updateCount;

	}

	public boolean isArticleBoardWriter(int postId, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String story_sql = "select memberId from storyPosts where id=?";
		boolean isWriter = false;

		try {
			pstmt = con.prepareStatement(story_sql);
			pstmt.setInt(1, postId);
			rs = pstmt.executeQuery();
			rs.next();

			if (memberId.equals(rs.getString("memberId"))) {
				isWriter = true;
			}
		} catch (SQLException ex) {
		} finally {
			close(pstmt);
		}

		return isWriter;
	}

	public int deleteArticle(int postId) {
		PreparedStatement pstmt = null;
		String board_delete_sql = "delete from storyPosts where id=?";
		int deleteCount = 0;

		try {
			pstmt = con.prepareStatement(board_delete_sql);
			pstmt.setInt(1, postId);
			deleteCount = pstmt.executeUpdate();
		} catch (Exception ex) {
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}

	public int deleteAllHeart(int postId) {
		PreparedStatement pstmt = null;
		String heart_delete_sql = "delete from storyHearts where PostId=?";
		int deleteCount = 0;

		try {
			pstmt = con.prepareStatement(heart_delete_sql);
			pstmt.setInt(1, postId);
			deleteCount = pstmt.executeUpdate();
		} catch (Exception ex) {
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}

	public int deleteAllReply(int postId) {
		PreparedStatement pstmt = null;
		String reply_delete_sql = "delete from storyReply where PostId=?";
		int deleteCount = 0;

		try {
			pstmt = con.prepareStatement(reply_delete_sql);
			pstmt.setInt(1, postId);
			deleteCount = pstmt.executeUpdate();
		} catch (Exception ex) {
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}

	public int insertArticle(StoryPostsDTO article) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int insertCount = 0;

		try {
			sql = "insert into storyPosts (memberId, title, category, contents, readCount, thumbnail)"
					+ "values(?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getMemberId());
			pstmt.setString(2, article.getTitle());
			pstmt.setString(3, article.getCategory());
			pstmt.setString(4, article.getContents());
			pstmt.setInt(5, 0);
			pstmt.setString(6, article.getThumbnail());
			insertCount = pstmt.executeUpdate();

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;

	}
	
	
	public int updateArticle(StoryPostsDTO article){

		int updateCount = 0;
		PreparedStatement pstmt = null;
		
		String sql="update storyposts set title=?,category=?,contents=? where id=?";

		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getCategory());
			pstmt.setString(3, article.getContents());
			pstmt.setInt(4, article.getId());
			updateCount = pstmt.executeUpdate();
		}catch(Exception ex){
		}finally{
			close(pstmt);
		}

		return updateCount;

	}
	
	
	
	
	

	public String isMemberLikeStory(int postId, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String isMemberLiked = null;
		String heart_list_sql = "select memberId from storyHearts where postId = ?";

		try {
			pstmt = con.prepareStatement(heart_list_sql);
			pstmt.setInt(1, postId);
			rs = pstmt.executeQuery();

			boolean b = true;

			if (rs == null) {
				isMemberLiked = "2";
			}
			while (rs.next() && b) {
				if (loginId.equals(rs.getString("memberId"))) {
					isMemberLiked = "1";
					b = false;
				} else {
					isMemberLiked = "0";
				}
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}
		return isMemberLiked;
	}

	public int selectHeartCount(int postId) {
		int Count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select count(memberId) from storyHearts where postId = ?");
			pstmt.setInt(1, postId);
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

	public int selectReplyCount(int id) {

		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select count(*) from storyreply where postId=?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (Exception ex) {

		} finally {
			close(rs);
			close(pstmt);
		}
		return listCount;

	}
	
	

}
