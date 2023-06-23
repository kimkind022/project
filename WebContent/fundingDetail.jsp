<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  response.setContentType("text/html; charset=utf-8");
  response.setCharacterEncoding("utf-8");
  request.setCharacterEncoding("utf-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear">
  <fmt:formatDate value="${now}" pattern="yyyy-MM-dd hh:mm:ss" />
</c:set>

<jsp:useBean id="Dateutil" class="util.Dateutil" />
<c:set var="Dateutil" value="${Dateutil}" />
<c:set var="endDate" value="${Dateutil.txtDate(fundingPost.getEndDate())}" />

<c:choose>
  <c:when test="${fundingPost.getEndDate() < now}">
    <input type="hidden" name=isproceeding value="false">
  </c:when>
  <c:otherwise>
    <input type="hidden" name=isproceeding value="true">
  </c:otherwise>
</c:choose>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/fundingDetail.js"></script>
<link href="styles/fundingDetail.css" rel="stylesheet" type="text/css">

<body>
  <form onsubmit="return submitCheck()" method="post" action="fundingOrder.fd">
    <!--헤더-->
    <jsp:include page="header.jsp"></jsp:include>
    <div class="wrap0">
      <section>
        <div class="postTop">
          <div class="postThumbnail">
            <img src=images/funding/${fundingPost.getThumbnail()}
              onerror="this.onerror=null; this.src='images/common/noimg.png';"
            >
          </div>
          <div class="postSummary">
            <div class="title">${fundingPost.getTitle()}</div>
            <input type="hidden" name=fundingId value="${fundingPost.getId()}">
            <div>
              <div>
                <c:set var="result" value="0" />
                <c:forEach var="fundingOption" items="${fundingOptionList}" varStatus="status">
                  <c:set var="result" value="${result +fundingOrdersList.get(fundingOption.key).getCost()}" />
                </c:forEach>
                <fmt:formatNumber value="${result}" pattern="###,###,###,###,###,###" />
              </div>
              <div>원 펀딩</div>
            </div>
            <div>
              <c:set var="gage" value="${100 * result div fundingPost.getTargetAmount()}"></c:set>
              <div>
                <fmt:formatNumber value="${gage}" pattern="##################" />
              </div>
              <div>% 달성</div>
            </div>
            <div>

              <div>
                <c:choose>
                  <c:when test="${fn:contains(endDate, '후')}">
            ${Dateutil.txtDate(fundingPost.getEndDate())}
                  </c:when>
                  <c:otherwise>
                    <input type="hidden" name="isEnd" value="proceeding">
                  </c:otherwise>
                </c:choose>
              </div>
              <div>마감</div>
            </div>
            <div>
              <select class="rewardChoose" name="rewardChoose">
                <option selected="selected" value="0">리워드 선택</option>
                <c:forEach var="fundingOption" items="${fundingOptionList}" varStatus="status">
                  <c:set var="stock"
                    value="${fundingOption.value.getLimit() - fundingOrdersList.get(fundingOption.key).getOrderAmount()}"
                  />
                  <fmt:formatNumber var="optionPrice" value="${fundingOption.value.getPrice()}"
                    pattern="###,###,###,###,###,###"
                  />
                  <option class="${fundingOption.value.getId()}" value="${fundingOption.value.getId()}"
                    value2="${fundingOption.value.getOptions()}" value3="${optionPrice}"
                    value4="${stock}"
                  >${fundingOption.value.getOptions()}(${optionPrice}원)-${stock}개남음</option>
                </c:forEach>
              </select>
            </div>
            <div>
              <ul class="selectedReward"></ul>
            </div>
            <div class="allRewardCost" style="visibility: hidden;">
              <label>총 결제금액</label>
              <label id="totalPriceDisplay">0</label>
              <label>원</label>
            </div>
            <div class="button">
              <button type="button" class="like">
                <c:choose>
                  <c:when test="${!empty ID && heartsList.containsKey(ID)}">
                    <img class="likeIcon" src="images/common/heart3.png">
                  </c:when>
                  <c:otherwise>
                    <img class="likeIcon" src="images/common/heart2.png">
                  </c:otherwise>
                </c:choose>
                <div>${heartsList.size()}명</div>
              </button>
              <input type="submit" value="펀딩 참여하기" class="buyButton">
            </div>
            <div></div>
            <div></div>
            <div>이 펀딩은 '${sellerNickname}' 업체가 진행합니다</div>

          </div>
        </div>
        <div class="postNav">
          <ul>
            <li>스토리</li>
            <li>리워드</li>
            <li>소식</li>
            <li>후기</li>
          </ul>
        </div>

        <div class="postBottom">
          <div class="postContents">
            <div>
              <img src=images/funding/${fundingPost.getStoryImage()}
                onerror="this.onerror=null; this.src='images/common/noimg.png';"
              >
            </div>
            <div>
              <img src=images/funding/${fundingPost.getRewardsImage()}
                onerror="this.onerror=null; this.src='images/common/noimg.png';"
              >
            </div>
            <div>
              <img src=images/funding/${fundingPost.getNewsImage()}
                onerror="this.onerror=null; this.src='images/common/noimg.png';"
              >
            </div>
            <div class="reply">
              <div class="replyTitle">
                <div>댓글</div>
                <div style="color: #F15F5F;">${fundingReplyList.size()}</div>
              </div>
              <div class="replyAdd">
                <div class="small_profilePic">
                  <img src="images/profileImages/${PROFILEIMG}"
                    onerror="this.onerror=null; this.src='images/common/emptyMember.png';"
                  >
                </div>
                <input type="text" name="replyContents">
                <input type="button" name="replyWrite" value="입력">
              </div>

              <div class="replysDIv">
                <c:choose>
                  <c:when test="${fundingReplyList.size() != 0}">
                    <c:forEach var="fundingReply" items="${fundingReplyList}" varStatus="status">
                      <div class="replyList">
                        <input type="hidden" name="replyId" value="${fundingReply.value.getId()}">
                        <div class="small_profilePic" style="margin-top: 3px;">
                          <img src="images/profileImages/${PROFILEIMG}"
                            onerror="this.onerror=null; this.src='images/common/emptyMember.png';"
                          >
                        </div>
                        <div class="replyContents">
                          <div>${fundingReply.value.getMembersBean().getNickname()}</div>
                          <div>${fundingReply.value.getContents()}</div>
                          <div class="replyExtra">
                            <div>${Dateutil.txtDate(fundingReply.value.getDate())}</div>
                            <c:choose>
                              <c:when test="${fundingReply.value.getMemberId() eq ID}">
                                <div>ᆞ</div>
                                <input type="button" class="replyBtn" name="replyUpdateBtn" value="수정 ">
                                <div>ᆞ</div>
                                <input type="button" class="replyBtn" name="replyDeleteBtn" value="삭제 ">
                              </c:when>
                              <c:otherwise>
                                <div>ᆞ</div>
                                <input type="button" class="replyBtn" name="replyDeleteBtn" value="쪽지쓰기">
                              </c:otherwise>
                            </c:choose>
                          </div>
                        </div>

                      </div>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <div class="replyList">
                      <div></div>
                      <div>등록된 리뷰가 없습니다</div>
                      <div></div>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
          <div class="postOption">
            <div>리워드 선택</div>
            <c:forEach var="fundingOption" items="${fundingOptionList}" varStatus="status">
              <c:set var="stock"
                value="${fundingOption.value.getLimit() - fundingOrdersList.get(fundingOption.value.getId()).getOrderAmount()}"
              ></c:set>
              <div class="rewardsSummary" id="${fundingOption.value.getId()}">
              <fmt:formatNumber var="optionPrice" value="${fundingOption.value.getPrice()}"
                    pattern="###,###,###,###,###,###"
                  />
                <div>${optionPrice}원</div>
                <div>${fundingOption.value.getOptions()}</div>
                <div>
                  제한수량 ${fundingOption.value.getLimit()}개 중 현재
                  <c:out value=" ${stock}"></c:out>
                  개 남음!
                </div>
                <p class="displayNone">이 리워드 펀딩하기</p>
              </div>
            </c:forEach>
          </div>
        </div>
      </section>
    </div>
    <!--풋터-->
    <jsp:include page="footer.jsp"></jsp:include>
  </form>
</body>
</html>