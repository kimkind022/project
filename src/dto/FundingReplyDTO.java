package dto;

import java.util.Date;

public class FundingReplyDTO {
  private Integer id;
  private Integer fundingId;
  private String memberId;
  private Date date;
  private String contents;
  private MembersBean membersBean;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public Integer getFundingId() {
    return fundingId;
  }

  public void setFundingId(Integer fundingId) {
    this.fundingId = fundingId;
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

  public String getContents() {
    return contents;
  }

  public void setContents(String contents) {
    this.contents = contents;
  }

  public MembersBean getMembersBean() {
    return membersBean;
  }

  public void setMembersBean(MembersBean membersBean) {
    this.membersBean = membersBean;
  }

}
