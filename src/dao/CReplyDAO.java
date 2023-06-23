package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;

import dto.GongguDTO;
import dto.CReplyDTO;
import util.Dateutil;

public class CReplyDAO {
	DataSource ds;
	Connection con;
	private static CReplyDAO cReplyDAO;

	private CReplyDAO() {
	}

	public static CReplyDAO getInstance() { // 싱글톤 패턴 : 객체를 한 번만 호출해도 됨
		if (cReplyDAO == null) {
			cReplyDAO = new CReplyDAO();
		}
		return cReplyDAO;
	}

	public void setConnection(Connection con) {
		this.con = con;
	}
	
	
	public String selectNick(String memberId) {
		String nickname=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
		try {
			pstmt=con.prepareStatement("select * from members where id='"+ memberId +"';");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				nickname= rs.getString("nickname");
			}
		}catch (Exception e){
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
	
	
	public ArrayList<CReplyDTO> selectArticleList(String postType, int postId, int page, int limit) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String reply_list_sql = "select * from "+postType+"Reply where postId=? order by id desc limit ?,10";
		ArrayList<CReplyDTO> replyList = new ArrayList<CReplyDTO>();
		CReplyDTO reply = null;
		int startrow = (page - 1) * 10;
		
		try {
			pstmt = con.prepareStatement(reply_list_sql);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, startrow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				reply = new CReplyDTO();
				reply.setId(rs.getInt("id"));
				reply.setPostId(rs.getInt("postId"));
				reply.setMemberId(rs.getString("memberId"));
				reply.setContents(rs.getString("contents"));

				Timestamp date = rs.getTimestamp("date");
				String dateTrans = Dateutil.txtDate(date);
				reply.setDate(dateTrans);

				reply.setNickname(selectNick(rs.getString("memberId")));
				reply.setProfileImage(selectProfileImg(rs.getString("memberId")));
				reply.setHeartCount(selectReplyHeartCount(postType, rs.getInt("id")));
				
				replyList.add(reply);
			}

		} catch (Exception e) {
			System.out.println(e);
			
		} finally {
			close(rs);
			close(pstmt);
		}

		return replyList;

	}

	public int selectListCount(String postType, int id) {

		int listCount= 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			pstmt=con.prepareStatement("select count(*) from "+postType+"Reply where postId=?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()){
				listCount=rs.getInt(1);
			}
		}catch(Exception ex){

		}finally{
			close(rs);
			close(pstmt);
		}
		
		return listCount;

	}
	
	public int insertArticle(String postType, CReplyDTO article){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql=null;
		int insertCount=0;

		if(postType.equals("gonggu")) {
			try{
				sql="insert into gongguReply (postId, memberId, contents) values(?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, article.getPostId());
				pstmt.setString(2, article.getMemberId());
				pstmt.setString(3, article.getContents());
				
				insertCount=pstmt.executeUpdate();
	
			}catch(Exception ex){
			}finally{
				close(rs);
				close(pstmt);
			}
		}
		else if(postType.equals("story")) {
			try{
				sql="insert into storyReply (postId, memberId, contents) values(?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, article.getPostId());
				pstmt.setString(2, article.getMemberId());
				pstmt.setString(3, article.getContents());
				
				insertCount=pstmt.executeUpdate();
	
			}catch(Exception ex){
			}finally{
				close(rs);
				close(pstmt);
			}
		}
		return insertCount;

	}
	
	// 댓글 좋아요
	public String isMemberLikeReply (String postType, int replyId, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String isMemberLiked = null;
		String heart_list_sql = "select memberId from cReplyHearts where postType=? and replyId = ?";
		
		try {
			pstmt = con.prepareStatement(heart_list_sql);
			pstmt.setString(1, postType);
			pstmt.setInt(2, replyId);
			rs = pstmt.executeQuery();
			
			boolean b = true;
			
			
			if(rs==null) {
				isMemberLiked="2";
			}
			while (rs.next() && b) {
				if(loginId.equals(rs.getString("memberId"))) {
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

	public int selectReplyHeartCount (String postType, int replyId) {
		int Count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = con.prepareStatement("select count(memberId) from cReplyHearts where postType=? and replyId = ?");
			pstmt.setString(1, postType);
			pstmt.setInt(2, replyId);
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
