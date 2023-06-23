package dto;

public class PageStatusDTO {
  private Integer page;
  private Integer limit;
  private String status;
  private String status2;
  private String status3;

  public Integer getPage() {
    return page;
  }

  public void setPage(Integer page) {
    this.page = page;
  }

  public Integer getLimit() {
    return limit;
  }

  public void setLimit(Integer limit) {
    this.limit = limit;
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

  public String getStatus3() {
    return status3;
  }

  public void setStatus3(String status3) {
    this.status3 = status3;
  }

}
