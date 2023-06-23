package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import dto.MembersBean;

public class MembersDAO {
  Connection conn = null;
  Statement stmt = null;
  ArrayList<MembersBean> arr = new ArrayList<MembersBean>();



  public void Con() {
    try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/todaymk?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false", "root",
          "1234");
      stmt = conn.createStatement();
    } catch (Exception e) {
      System.out.println(e);
    }
  }

  public void Close() {
    try {
      stmt.close();
    } catch (Exception e) {
    }
    try {
      conn.close();
    } catch (Exception e) {
    }
  }



  public int Insert(MembersBean dto) {

    Con();

    String id = dto.getId();
    String pw = dto.getPw();
    String name = dto.getName();
    String nickname = dto.getNickname();
    String birthday = dto.getBirthday();
    String tel = dto.getTel();
    String address1 = dto.getAddress1();
    String address2 = dto.getAddress2();
    String push = dto.getPush();

    int rowNum = 0;

    try {
      String command = String.format("insert into members (id , pw , name , nickname , birthday , tel , address1 , address2 , push) values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s' , '%s');", id,
          pw, name, nickname, birthday, tel, address1, address2 , push);
      rowNum = stmt.executeUpdate(command);
      
      if (rowNum < 1) {
        conn.rollback();
      }

    } catch (Exception e) {
      System.out.println(e + "1234");
    }
    Close();

    return rowNum;
  }


  public MembersBean Member(String id) {
    MembersBean dto = new MembersBean();
    try {
      Con();
      ResultSet rs = stmt.executeQuery("select * from members where id='" + id + "'");

      if (rs.next()) {

        dto.setId(rs.getString(1));
        dto.setPw(rs.getString(2));
        dto.setNickname(rs.getString(4));
        dto.setProfileImage(rs.getString(9));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    Close();
    return dto;
  }



  public String SelectLogin(String id, String pw) {
    String loginRs = null;
    // ArrayList<String> member = new ArrayList<String>();
    System.out.println("id: " + id + "\n" + "pw: " + pw);
    if (id == " ") {
      loginRs = "idN";
    } else if (pw == " ") {
      loginRs = "pwN";
    }
    try {
      Con();

      ResultSet rs = stmt.executeQuery("select * from members;");

      boolean b = true;
      while (rs.next() && b) {
        String idGet = rs.getString(1);
        String pwGet = rs.getString(2);

        if (id.equals(idGet)) {
          if (pw.equals(pwGet)) {
            loginRs = "ok";
            b = false;
          } else {
            loginRs = "pwE";
            b = false;
          }
        } else {
          loginRs = "idE";
        }
      }
    } catch (Exception e) {
      System.out.println(e);
    }
    return loginRs;
  }


}
