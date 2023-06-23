package dto;

import java.sql.Timestamp;


public class GongguDTO {
  int Id;
  int productId;
  String memberId;
  Timestamp date;
  String title;
  String contents;
  int readCount;
  
  String sido_code;
  String sigoon_code;
  String dong_code;
  String lee_code;
  int personnel;
  int personnelval;

  String nickname;
  String personnelId;
  String profileImage;
  
  int replyCount;
  int heartCount;
  String isMemberLiked;
  Timestamp endDate;
  
  String dateTrans;
  String endDateTrans;
  String endDate2;
  ProductBean productBean;
  
  
  
  
  public ProductBean getProductBean() {
    return productBean;
  }
  public void setProductBean(ProductBean productBean) {
    this.productBean = productBean;
  }
  public String getProfileImage() {
    return profileImage;
  }
  public void setProfileImage(String profileImage) {
    this.profileImage = profileImage;
  }
  public String getDateTrans() {
    return dateTrans;
  }
  public void setDateTrans(String dateTrans) {
    this.dateTrans = dateTrans;
  }
  public String getEndDateTrans() {
    return endDateTrans;
  }
  public void setEndDateTrans(String endDateTrans) {
    this.endDateTrans = endDateTrans;
  }
  public Timestamp getEndDate() {
    return endDate;
  }
  public void setEndDate(Timestamp endDate) {
    this.endDate = endDate;
  }
  public String getIsMemberLiked() {
    return isMemberLiked;
  }
  public void setIsMemberLiked(String isMemberLiked) {
    this.isMemberLiked = isMemberLiked;
  }
  public int getReplyCount() {
    return replyCount;
  }
  public void setReplyCount(int replyCount) {
    this.replyCount = replyCount;
  }
  public int getHeartCount() {
    return heartCount;
  }
  public void setHeartCount(int heartCount) {
    this.heartCount = heartCount;
  }
  public String getPersonnelId() {
    return personnelId;
  }
  public void setPersonnelId(String personnelId) {
    this.personnelId = personnelId;
  }
  public int getPersonnelval() {
    return personnelval;
  }
  public void setPersonnelval(int personnelval) {
    this.personnelval = personnelval;
  }
  public String getNickname() {
    return nickname;
  }
  public void setNickname(String nickname) {
    this.nickname = nickname;
  }
  public String getSido_code() {
    return sido_code;
  }
  public void setSido_code(String sido_code) {
    this.sido_code = sido_code;
  }
  public String getSigoon_code() {
    return sigoon_code;
  }
  public void setSigoon_code(String sigoon_code) {
    this.sigoon_code = sigoon_code;
  }
  public String getDong_code() {
    return dong_code;
  }
  public void setDong_code(String dong_code) {
    this.dong_code = dong_code;
  }
  public String getLee_code() {
    return lee_code;
  }
  public void setLee_code(String lee_code) {
    this.lee_code = lee_code;
  }
  
  
  public int getPersonnel() {
    return personnel;
  }
  public void setPersonnel(int personnel) {
    this.personnel = personnel;
  } 
  public int getId() {
    return Id;
  }
  public void setId(int id) {
    Id = id;
  }
  public int getProductId() {
    return productId;
  }
  public void setProductId(int productId) {
    this.productId = productId;
  }
  public String getMemberId() {
    return memberId;
  }
  public void setMemberId(String memberId) {
    this.memberId = memberId;
  }
  public Timestamp getDate() {
    return date;
  }
  public void setDate(Timestamp date) {
    this.date = date;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContents() {
    return contents;
  }
  public void setContents(String contents) {
    this.contents = contents;
  }
  public int getReadCount() {
    return readCount;
  }
  public void setReadCount(int readCount) {
    this.readCount = readCount;
  }
  
  public String getEndDate2() {
    return endDate2;
  }
  public void setEndDate2(String endDate2) {
    this.endDate2 = endDate2;
  }
  
  
}
