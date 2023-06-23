package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;

import dto.GongguDTO;
import dto.GongguHeartsDTO;
import dto.ProductBean;
import dto.ProductsDTO;
import dto.StoryPostsDTO;
import util.Dateutil;

public class GongguDAO {
	DataSource ds;
	Connection con;
	private static GongguDAO gongguDAO;

	private GongguDAO() {
	}

	public static GongguDAO getInstance() { // 싱글톤 패턴 : 객체를 한 번만 호출해도 됨
		if (gongguDAO == null) {
			gongguDAO = new GongguDAO();
		}
		return gongguDAO;
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

	public int selectListCount(String status1, String status2) {

		int listCount = 0;
		String[] loca = null;
		if(status2!="---") {
			loca = status2.split("-");
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String gonggu_list_sql = "";

		if (status1 == "empty" && status2=="empty") {
			gonggu_list_sql = "select * from gonggu;";
		} 
		else if (status1 == "empty" && status2!="empty") {
			if(loca.length==1) {
				gonggu_list_sql = "select count(*) from gonggu where sido_code='"+ loca[0]+"';";
			}else if(loca.length==2) {
				gonggu_list_sql = "select count(*) from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]+"';";
			}else if(loca.length==3) {
				gonggu_list_sql = "select count(*) from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]+"';";
			}else if(loca.length==4) {
				gonggu_list_sql = "select count(*) from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"'and lee_code='"+ loca[3]+"';";
			}
		} 
		else if (status1 != "empty" && status2=="empty") {
			gonggu_list_sql = "select count(*) from gonggu where productId in("
					+ "select products.id from products where category='" + status1 + "');";
		}
		else if (status1 != "empty" && status2!="empty") {
			
			if(loca.length==1) {
				gonggu_list_sql = "select count(*) from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"';";
			}else if(loca.length==2) {
				gonggu_list_sql = "select count(*) from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]+"';";
			}else if(loca.length==3) {
				gonggu_list_sql = "select count(*) from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]+"';";
			}else if(loca.length==4) {
				gonggu_list_sql = "select count(*) from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"'and lee_code='"+ loca[3]+"';";
			}
		}
		try {
			pstmt = con.prepareStatement(gonggu_list_sql);
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

	public ArrayList<GongguDTO> selectArticleList(int page, int limit, String status1, String status2) {
		
		String[] loca = null;
		if(status2!="---") {
			loca = status2.split("-");
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String gonggu_list_sql = "";

		if (status1 == "empty" && status2=="empty") {
			gonggu_list_sql = "select * from gonggu order by id desc limit ?,10;";
		} 
		else if (status1 == "empty" && status2!="empty") {
			if(loca.length==1) {
				gonggu_list_sql = "select * from gonggu where sido_code='"+ loca[0]
						+"' order by id desc limit ?,10;";
			}else if(loca.length==2) {
				gonggu_list_sql = "select * from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"' order by id desc limit ?,10;";
			}else if(loca.length==3) {
				gonggu_list_sql = "select * from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"' order by id desc limit ?,10;";
			}else if(loca.length==4) {
				gonggu_list_sql = "select * from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"'and lee_code='"+ loca[3]
						+"' order by id desc limit ?,10;";
			}
		} 
		else if (status1 != "empty" && status2=="empty") {
			gonggu_list_sql = "select * from gonggu where productId in("
					+ "select products.id from products where category='" + status1 + "') "
					+ "order by id desc limit ?,10;";
		}
		else if (status1 != "empty" && status2!="empty") {
			
			if(loca.length==1) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]
						+"' order by id desc limit ?,10;";
			}else if(loca.length==2) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"' order by id desc limit ?,10;";
			}else if(loca.length==3) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"' order by id desc limit ?,10;";
			}else if(loca.length==4) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"'and lee_code='"+ loca[3]
						+"' order by id desc limit ?,10;";
			}
		}

		ArrayList<GongguDTO> articleList = new ArrayList<GongguDTO>();
		GongguDTO gonggu = null;
		int startrow = (page - 1) * 10;

		try {
			pstmt = con.prepareStatement(gonggu_list_sql);
			pstmt.setInt(1, startrow);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				gonggu = new GongguDTO();
				gonggu.setId(rs.getInt("id"));
				gonggu.setProductId(rs.getInt("productId"));
				gonggu.setMemberId(rs.getString("memberId"));

				gonggu.setTitle(rs.getString("title"));
				gonggu.setContents(rs.getString("contents"));
				gonggu.setReadCount(rs.getInt("readCount"));
				gonggu.setSido_code(rs.getString("sido_code"));
				gonggu.setSigoon_code(rs.getString("sigoon_code"));
				gonggu.setDong_code(rs.getString("dong_code"));
				gonggu.setLee_code(rs.getString("lee_code"));
				gonggu.setPersonnel(rs.getInt("personnel"));
				gonggu.setPersonnelval(rs.getInt("personnelval"));

				Timestamp endDate = rs.getTimestamp("endDate");
				String endDateTrans = Dateutil.txtDate(endDate);
				gonggu.setEndDate(endDate);
				gonggu.setEndDateTrans(endDateTrans);

				Timestamp date = rs.getTimestamp("date");
				String dateTrans = Dateutil.txtDate(date);
				gonggu.setDateTrans(dateTrans);

				int id = rs.getInt("id");
				gonggu.setNickname(selectNick(rs.getString("memberId")));

				gonggu.setHeartCount(selectHeartCount(id));
				gonggu.setReplyCount(selectListCount(id));

				articleList.add(gonggu);
			}

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}
		return articleList;

	}

	public ArrayList<GongguDTO> selectMarkerList(String status1, String status2) {
		String[] loca = null;
		if(status2!="---") {
			loca = status2.split("-");
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String gonggu_list_sql = "";

		if (status1 == "empty" && status2=="empty") {
			gonggu_list_sql = "select * from gonggu;";
		} 
		else if (status1 == "empty" && status2!="empty") {
			if(loca.length==1) {
				gonggu_list_sql = "select * from gonggu where sido_code='"+ loca[0]+"';";
			}else if(loca.length==2) {
				gonggu_list_sql = "select * from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]+"';";
			}else if(loca.length==3) {
				gonggu_list_sql = "select * from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]+"';";
			}else if(loca.length==4) {
				gonggu_list_sql = "select * from gonggu where sido_code='"
						+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"'and lee_code='"+ loca[3]+"';";
			}
		} 
		else if (status1 != "empty" && status2=="empty") {
			gonggu_list_sql = "select * from gonggu where productId in("
					+ "select products.id from products where category='" + status1 + "');";
		}
		else if (status1 != "empty" && status2!="empty") {
			
			if(loca.length==1) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"';";
			}else if(loca.length==2) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]+"';";
			}else if(loca.length==3) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]+"';";
			}else if(loca.length==4) {
				gonggu_list_sql = "select * from gonggu where productId in("
						+ "select products.id from products where category='" + status1 + "') "
						+"and sido_code='"+ loca[0]+"'and sigoon_code='"+ loca[1]
						+"'and dong_code='"+ loca[2]
						+"'and lee_code='"+ loca[3]+"';";
			}
		}
		ArrayList<GongguDTO> articleList = new ArrayList<GongguDTO>();
		GongguDTO gonggu = null;

		try {
			pstmt = con.prepareStatement(gonggu_list_sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				gonggu = new GongguDTO();
				gonggu.setId(rs.getInt("id"));
				gonggu.setProductId(rs.getInt("productId"));
				gonggu.setMemberId(rs.getString("memberId"));

				gonggu.setTitle(rs.getString("title"));
				gonggu.setSido_code(rs.getString("sido_code"));
				gonggu.setSigoon_code(rs.getString("sigoon_code"));
				gonggu.setDong_code(rs.getString("dong_code"));
				gonggu.setLee_code(rs.getString("lee_code"));
				gonggu.setPersonnel(rs.getInt("personnel"));
				gonggu.setPersonnelval(rs.getInt("personnelval"));

				Timestamp endDate = rs.getTimestamp("endDate");
				String endDateTrans = Dateutil.txtDate(endDate);
				gonggu.setEndDateTrans(endDateTrans);

				Timestamp date = rs.getTimestamp("date");
				String dateTrans = Dateutil.txtDate(date);
				gonggu.setDateTrans(dateTrans);

				int id = rs.getInt("id");
				gonggu.setNickname(selectNick(rs.getString("memberId")));

				articleList.add(gonggu);
			}

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}
		return articleList;

	}

	public GongguDTO selectArticle(int id) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GongguDTO gonggu = null;

		try {
			pstmt = con.prepareStatement("select * from gonggu where id = ?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				gonggu = new GongguDTO();
				gonggu.setId(rs.getInt("id"));
				gonggu.setProductId(rs.getInt("productId"));
				gonggu.setMemberId(rs.getString("memberId"));

				gonggu.setTitle(rs.getString("title"));
				gonggu.setContents(rs.getString("contents"));
				gonggu.setReadCount(rs.getInt("readCount"));
				gonggu.setSido_code(rs.getString("sido_code"));
				gonggu.setSigoon_code(rs.getString("sigoon_code"));
				gonggu.setDong_code(rs.getString("dong_code"));
				gonggu.setLee_code(rs.getString("lee_code"));
				gonggu.setPersonnel(rs.getInt("personnel"));
				gonggu.setPersonnelval(rs.getInt("personnelval"));

				Timestamp endDate = rs.getTimestamp("endDate");
				String endDateTrans = Dateutil.txtDate(endDate);
				gonggu.setEndDateTrans(endDateTrans);
				Timestamp date = rs.getTimestamp("date");
				String dateTrans = Dateutil.txtDate(date);
				gonggu.setDateTrans(dateTrans);

				gonggu.setNickname(selectNick(rs.getString("memberId")));
				gonggu.setProfileImage(selectProfileImg(rs.getString("memberId")));
			}
		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}
		return gonggu;

	}

	public int insertArticle(GongguDTO article) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int insertCount = 0;

		try {

			sql = "insert into gonggu (productId, memberId, personnel,";
			sql += "title, contents, readCount," + "sido_code,sigoon_code,dong_code,"
					+ "lee_code, endDate) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, article.getProductId());
			pstmt.setString(2, article.getMemberId());
			pstmt.setInt(3, article.getPersonnel());
			pstmt.setString(4, article.getTitle());
			pstmt.setString(5, article.getContents());
			pstmt.setInt(6, 0);
			pstmt.setString(7, article.getSido_code());
			pstmt.setString(8, article.getSigoon_code());
			pstmt.setString(9, article.getDong_code());
			pstmt.setString(10, article.getLee_code());
			pstmt.setString(11, article.getEndDate2()+" 23:59:59");
			insertCount = pstmt.executeUpdate();

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;

	}

	public int updateReadCount(int id) {

		PreparedStatement pstmt = null;
		int updateCount = 0;
		String sql = "update gonggu set readCount = " + "readCount+1 where id = " + id;

		try {
			pstmt = con.prepareStatement(sql);
			updateCount = pstmt.executeUpdate();
		} catch (SQLException ex) {
		} finally {
			close(pstmt);

		}

		return updateCount;

	}

	public int deleteArticle(int postId) {
		PreparedStatement pstmt = null;
		String board_delete_sql = "delete from gonggu where id=?";
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
		String heart_delete_sql = "delete from gongguHearts where PostId=?";
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
		String reply_delete_sql = "delete from gongguReply where PostId=?";
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

	public int deleteAllPersonnel(int postId) {
		PreparedStatement pstmt = null;
		String personnel_delete_sql = "delete from gongguPersonnels where PostId=?";
		int deleteCount = 0;

		try {
			pstmt = con.prepareStatement(personnel_delete_sql);
			pstmt.setInt(1, postId);
			deleteCount = pstmt.executeUpdate();

		} catch (Exception ex) {
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}

	public boolean isArticleBoardWriter(int postId, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String gonggu_sql = "select memberId from gonggu where id=?";
		boolean isWriter = false;

		try {
			pstmt = con.prepareStatement(gonggu_sql);
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

	public int updateArticle(GongguDTO article) {

		int updateCount = 0;
		PreparedStatement pstmt = null;

		String sql = "update gonggu set title=?, contents=? where id=?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getContents());
			pstmt.setInt(3, article.getId());
			updateCount = pstmt.executeUpdate();
			System.out.println(updateCount);
		} catch (Exception ex) {
		} finally {
			close(pstmt);
		}

		return updateCount;

	}

	///////// personnel

	public ArrayList<GongguDTO> selectPersonnelList(int postId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String personnel_list_sql = "select * from gongguPersonnels where postId = ?";
		ArrayList<GongguDTO> personnelList = new ArrayList<GongguDTO>();
		GongguDTO personnel = null;

		try {
			pstmt = con.prepareStatement(personnel_list_sql);
			pstmt.setInt(1, postId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				personnel = new GongguDTO();
				personnel.setPersonnelId(rs.getString("personnelId"));
				personnel.setNickname(selectNick(rs.getString("personnelId")));

				personnelList.add(personnel);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}

		return personnelList;
	}

	public int updatePersonnel(int postId) {
		int updateCount = 0;
		PreparedStatement pstmt = null;
		String sql = "Update gonggu set personnelval=personnelval+1 where id=?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, postId);
			updateCount = pstmt.executeUpdate();
		} catch (Exception ex) {
		} finally {
			close(pstmt);
		}

		return updateCount;

	}

	public int insertPersonnel(GongguDTO article) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int insertCount = 0;

		try {
			sql = "insert into gongguPersonnels values(?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, article.getId());
			pstmt.setString(2, article.getPersonnelId());

			insertCount = pstmt.executeUpdate();

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;

	}

	/////////// heart

	public String isMemberLikeGonggu(int postId, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String isMemberLiked = "2";
		String heart_list_sql = "select memberId from gongguHearts where postId = ?";

		try {
			pstmt = con.prepareStatement(heart_list_sql);
			pstmt.setInt(1, postId);
			rs = pstmt.executeQuery();

			boolean b = true;

			while (rs.next()) {
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
			pstmt = con
					.prepareStatement("select ifnull(count(memberId),0) memberId from gongguHearts where postId = ?");
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

	public int selectListCount(int id) {

		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement("select count(*) from gongguReply where postId=?");
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

//////////// products

	public ArrayList<ProductBean> selectAllProduct(int productId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String product_list_sql = "select id, imageNo1, name, price from products where id=?";
		ArrayList<ProductBean> articleList = new ArrayList<ProductBean>();
		ProductBean products = null;

		try {
			pstmt = con.prepareStatement(product_list_sql);
			pstmt.setInt(1, productId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				products = new ProductBean();
				products.setId(rs.getInt("id"));
				products.setName(rs.getString("name"));
				products.setPrice(rs.getInt("price"));
				products.setImageNo1(rs.getString("imageNo1"));

				articleList.add(products);
			}

		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}

		return articleList;

	}

	public ProductBean selectProduct(int productId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean article = null;

		try {
			pstmt = con.prepareStatement("select id, imageNo1, name, price, discountRate from products where id=?");
			pstmt.setInt(1, productId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				article = new ProductBean();
				article.setId(rs.getInt("id"));
				article.setName(rs.getString("name"));
				article.setPrice(rs.getInt("price"));
				article.setDiscountRate(rs.getInt("discountRate"));
				article.setImageNo1(rs.getString("imageNo1"));
			}
		} catch (Exception ex) {
		} finally {
			close(rs);
			close(pstmt);
		}
		return article;
	}

}
