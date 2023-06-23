package dao;

import static db.JdbcUtil.close;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.sql.DataSource;
import dto.BoardBean;
import dto.OrderBean;

public class OrderDAO {
	DataSource ds;
	Connection con;
	private static OrderDAO orderDao;

	private OrderDAO() {}

	public static OrderDAO getInstance() {
		if (orderDao == null) {
			orderDao = new OrderDAO();
		}
		return orderDao;
	}

	public void setConnection(Connection con) {
		this.con = con;
	}

	public ArrayList<OrderBean> dataOrdersList(String memberId) {
		System.out.println("8. 위치: OrderDAO의 dataOrdersList메소드 들어옴. 상태: orders테이블에서 memberId를 조건으로 모든정보를 뽑기 전");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String board_list_sql = "select * from orders where memberId = ? order by orderDate desc limit 0, 5";
		ArrayList<OrderBean> orderList = new ArrayList<OrderBean>();
		OrderBean orders = null;

		try {
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orders = new OrderBean();
				orders.setOrderId(rs.getInt("orderId"));
				orders.setMemberId(rs.getString(1));
				orders.setProductId(rs.getInt("productId"));
				orders.setOrderDate(rs.getString("orderDate"));;
				orders.setOrderAmount(rs.getInt("orderAmount"));
				orders.setAddress(rs.getString("address"));

				orderList.add(orders);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}

		return orderList;
	}

	public int checkAlreadyWritten(String orderId) {
		int checkAlreadyWritten = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String board_list_sql = "select * from order where orderId = ?; ";
		OrderBean orders = null;

		try {
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setString(1, orderId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				checkAlreadyWritten = (rs.getInt(1));
			}

		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			close(rs);
			close(pstmt);
		}

		return checkAlreadyWritten;


	}


}
