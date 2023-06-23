package dto;

public class FundingOptionDTO {
  private Integer id;
  private Integer fundingId;
  private String options;
  private Integer price;
  private Integer limit;

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

  public String getOptions() {
    return options;
  }

  public void setOptions(String options) {
    this.options = options;
  }

  public Integer getPrice() {
    return price;
  }

  public void setPrice(Integer price) {
    this.price = price;
  }

  public Integer getLimit() {
    return limit;
  }

  public void setLimit(Integer limit) {
    this.limit = limit;
  }

}
