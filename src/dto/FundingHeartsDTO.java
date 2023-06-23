package dto;

import java.util.Date;

public class FundingHeartsDTO {
  private Integer postId;
  private String memberId;
  private Date date;

  public Integer getPostId() {
    return postId;
  }

  public void setPostId(Integer postId) { 
    this.postId = postId;
  }

  public String getMemberId() {
    return memberId;
  }

  public void setMemberId(String memberId) {
    this.memberId = memberId;
  }

  public Date getDate() {
    return date;
  }

  public void setDate(Date date) {
    this.date = date;
  }



}
