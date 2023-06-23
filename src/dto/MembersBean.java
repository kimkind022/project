package dto;

public class MembersBean {
  private String id;
  private String pw;
  private String name;
  private String nickname;
  private String birthday;
  private String tel;
  private String address1;
  private String address2;
  private String profileImage;
  private String push;

  private int followerCount;
  private int followCount;
  private int storyCount;
  private int gongguCount;
  private int isFollow;



  
  public int getIsFollow() {
    return isFollow;
  }

  public void setIsFollow(int isFollow) {
    this.isFollow = isFollow;
  }

  public int getFollowerCount() {
    return followerCount;
  }

  public void setFollowerCount(int followerCount) {
    this.followerCount = followerCount;
  }

  public int getFollowCount() {
    return followCount;
  }

  public void setFollowCount(int followCount) {
    this.followCount = followCount;
  }

  public int getStoryCount() {
    return storyCount;
  }

  public void setStoryCount(int storyCount) {
    this.storyCount = storyCount;
  }

  public int getGongguCount() {
    return gongguCount;
  }

  public void setGongguCount(int gongguCount) {
    this.gongguCount = gongguCount;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getPw() {
    return pw;
  }

  public void setPw(String pw) {
    this.pw = pw;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }

  public String getBirthday() {
    return birthday;
  }

  public void setBirthday(String birthday) {
    this.birthday = birthday;
  }

  public String getTel() {
    return tel;
  }

  public void setTel(String tel) {
    this.tel = tel;
  }

  public String getAddress1() {
    return address1;
  }

  public void setAddress1(String address1) {
    this.address1 = address1;
  }

  public String getAddress2() {
    return address2;
  }

  public void setAddress2(String address2) {
    this.address2 = address2;
  }

  public String getProfileImage() {
    return profileImage;
  }

  public void setProfileImage(String profileImage) {
    this.profileImage = profileImage;
  }

  public String getPush() {
    return push;
  }

  public void setPush(String push) {
    this.push = push;
  }

}
