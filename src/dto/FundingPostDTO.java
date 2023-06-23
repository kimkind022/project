package dto;

import java.util.Date;

public class FundingPostDTO {
  private Integer id;
  private String sellerId;
  private String category;
  private String title;
  private Integer targetAmount;
  private Date startDate;
  private Date endDate;
  private Integer readCount;
  private String thumbnail;
  private String storyImage;
  private String rewardsImage;
  private String newsImage;
  private String status;
  private String status2;
  private Integer minPrice;
  private Integer sumCost;
  private MembersBean sellersBean;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getSellerId() {
    return sellerId;
  }

  public void setSellerId(String sellerId) {
    this.sellerId = sellerId;
  }

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public Integer getTargetAmount() {
    return targetAmount;
  }

  public void setTargetAmount(Integer targetAmount) {
    this.targetAmount = targetAmount;
  }

  public Date getStartDate() {
    return startDate;
  }

  public void setStartDate(Date startDate) {
    this.startDate = startDate;
  }

  public Date getEndDate() {
    return endDate;
  }

  public void setEndDate(Date endDate) {
    this.endDate = endDate;
  }

  public Integer getReadCount() {
    return readCount;
  }

  public void setReadCount(Integer readCount) {
    this.readCount = readCount;
  }

  public String getThumbnail() {
    return thumbnail;
  }

  public void setThumbnail(String thumbnail) {
    this.thumbnail = thumbnail;
  }

  public String getStoryImage() {
    return storyImage;
  }

  public void setStoryImage(String storyImage) {
    this.storyImage = storyImage;
  }

  public String getRewardsImage() {
    return rewardsImage;
  }

  public void setRewardsImage(String rewardsImage) {
    this.rewardsImage = rewardsImage;
  }

  public String getNewsImage() {
    return newsImage;
  }

  public void setNewsImage(String newsImage) {
    this.newsImage = newsImage;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getStatus2() {
    return status2;
  }

  public void setStatus2(String status2) {
    this.status2 = status2;
  }

  public Integer getMinPrice() {
    return minPrice;
  }

  public void setMinPrice(Integer minPrice) {
    this.minPrice = minPrice;
  }

  public Integer getSumCost() {
    return sumCost;
  }

  public void setSumCost(Integer sumCost) {
    this.sumCost = sumCost;
  }

  public MembersBean getSellersBean() {
    return sellersBean;
  }

  public void setSellersBean(MembersBean sellersBean) {
    this.sellersBean = sellersBean;
  }

}
