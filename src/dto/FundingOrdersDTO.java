package dto;

import java.util.Date;

public class FundingOrdersDTO {
  private Integer id;
  private String memberId;
  private Integer fundingId;
  private Integer optionsId;
  private Integer orderAmount;
  private String address;
  private Date date;
  private Integer cost;
  private FundingOptionDTO option;
  private FundingPostDTO post;


  
  
  public FundingPostDTO getPost() {
    return post;
  }

  public void setPost(FundingPostDTO post) {
    this.post = post;
  }

  public FundingOptionDTO getOption() {
    return option;
  }

  public void setOption(FundingOptionDTO option) {
    this.option = option;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getMemberId() {
    return memberId;
  }

  public void setMemberId(String memberId) {
    this.memberId = memberId;
  }

  public Integer getFundingId() {
    return fundingId;
  }

  public void setFundingId(Integer fundingId) {
    this.fundingId = fundingId;
  }

  public Integer getOptionsId() {
    return optionsId;
  }

  public void setOptionsId(Integer optionsId) {
    this.optionsId = optionsId;
  }

  public Integer getOrderAmount() {
    return orderAmount;
  }

  public void setOrderAmount(Integer orderAmount) {
    this.orderAmount = orderAmount;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public Date getDate() {
    return date;
  }

  public void setDate(Date date) {
    this.date = date;
  }

  public Integer getCost() {
    return cost;
  }

  public void setCost(Integer cost) {
    this.cost = cost;
  }

}
