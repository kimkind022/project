<%@page import="dto.GongguDTO"%>
<%@page import="dto.ProductBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.CReplyDTO"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%pageContext.setAttribute("ENTER","\n"); %>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>



<%
	// 글 내용
	GongguDTO article = (GongguDTO) request.getAttribute("article");

	// 팔로우 정보
	int follow = (int) request.getAttribute("follow");

	// 상품 정보
	ProductBean product = (ProductBean) request.getAttribute("product");

	// 참여자 정보
	ArrayList<GongguDTO> personnelList = (ArrayList<GongguDTO>) request.getAttribute("personnelList");

	// 댓글 정보
	CReplyDTO replyArticle = (CReplyDTO) request.getAttribute("replyarticle");
	String nowPage = request.getParameter("page");

	// 좋아요 정보
	String isMemberLiked = (String) request.getAttribute("isMemberLiked");
	int heartCount = (int) request.getAttribute("heartCount");

	// 댓글 페이지 정보
	ArrayList<CReplyDTO> replyList = (ArrayList<CReplyDTO>) request.getAttribute("replyList");
	PageInfo replyPageInfo = (PageInfo) request.getAttribute("replyPageInfo");

	int rListCount = replyPageInfo.getListCount();
	int rNowPage = replyPageInfo.getPage();
	int rMaxPage = replyPageInfo.getMaxPage();
	int rStartPage = replyPageInfo.getStartPage();
	int rEndPage = replyPageInfo.getEndPage();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공동구매</title>
</head>
<link href="styles/communityGonggu.css" rel="stylesheet" type="text/css">
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>


<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap1">
			<div class="wrap770">

				<!-- 퀵메뉴, 글 작성 클릭 시 로그인 확인 -->
				<div id="quickmenu">
					<div>
						<div class="quickIcon1">
							<div id="postHeart">
								<c:set var="isMemberLiked" value="<%=isMemberLiked%>" />
								<c:choose>
									<c:when test="${isMemberLiked == '1'}">
										<span onClick="heartDel(0)"> <img
											src="images/common/heart3.png">
										</span>
									</c:when>
									<c:otherwise>
										<span onClick="heartAdd(0)"> <img
											src="images/common/heart2.png">
										</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div><%=heartCount%></div>
					</div>
					<a href="#header1">
						<div class="quickIcon1">
							<div>
								<img src="images/common/mail2.png">
							</div>
						</div>
						<div>0</div>
					</a> <a href="#replyList" id="quickReply">
						<div class="quickIcon1">
							<div>
								<img src="images/common/comment2.png">
							</div>
						</div>
						<div><%=rListCount%></div>
					</a> <a href="gongguList.cm?page=<%=nowPage%>">
						<div class="quickIcon2">
							<div>
								<img src="images/common/menu2.png" style="width: 30px;" />
							</div>
						</div>
					</a>
				</div>

				<section id="storySection">
					<div class="detailSection">
					<header id="postHeader">
						<div class="postSubTitle">
							<img src="images/common/location2.png" style="width: 25px;">
							<%=article.getSido_code()%>&nbsp;
							<%=article.getSigoon_code()%>&nbsp;
							<%=article.getDong_code()%>&nbsp;
							<%
								if (!article.getLee_code().equals("0")) {
									out.println(article.getLee_code());
								} else {
							%>
							&nbsp;
							<%
								}
							%>


						</div>
						<div class="postTitle"><%=article.getTitle()%></div>
						<div id="profileContainer">
							<div id="profilePic">
								<c:set var="profileImg" value="<%=article.getProfileImage()%>" />
								<c:choose>
									<c:when test="${empty profileImg}">
										<img src="images/common/emptyMember.png">
									</c:when>
									<c:otherwise>
										<img src="images/profileImages/<%=article.getProfileImage()%>">
									</c:otherwise>
								</c:choose>
							</div>
							<div id="profileTxt">
								<ul class="txtleft">
									<li style="font-weight: bold;"><%=article.getNickname()%></li>
									<li style="font-size: 11pt; color: gray;"><%=article.getDateTrans()%></li>
								</ul>
							</div>
							
							
							
							
							<c:set var="postNick" value="<%=article.getNickname()%>" />
							<c:set var="follow" value="<%=follow %>" />
							<c:choose>
								<c:when test="${NICKNAME != postNick}">
									<c:choose>
										<c:when test="${follow==1}">
											<div class="followBtn" onclick="unfollow(0)">팔로잉</div>
										</c:when>
										<c:otherwise>
											<div class="followBtn2" onclick="follow(0)">+ 팔로우</div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div class="updel">
										<ul>
											<li><input type="button" value="삭제"
												onClick="gongguDelete()"></li>
											<li>|</li>
											<li><a
												href="gongguUpdateForm.cm?id=<%=article.getId()%>&page=<%=nowPage%>"><input
													type="button" value="수정"></a></li>
											<li>|</li>
											<li><input type="button" name="personnelSettingBtn"
												value="참여자 관리"></li>
										</ul>
									</div>
								</c:otherwise>
							</c:choose>
						</div>

						<!-- 참여자 목록, 참여자 삭제 -->
						<div class="personnelSetting">
							<form name="personnelset">
								<%
									if (personnelList != null) {
										for (int i = 0; i < personnelList.size(); i++) {
								%>
								<div>
									<!-- 참여자 아이디 -->
									<input type="hidden" name="personnelId"
									
										value="<%=personnelList.get(i).getPersonnelId()%>">
									<!-- 게시글 아이디 -->
									<input type="hidden" name="postId" value="<%=article.getId()%>">
									<span><%=personnelList.get(i).getNickname()%></span> <input
										type="button" class="xBtn" value="X"
										onclick="personnelDel(<%=i%>)"><br>
								</div>
								<%
									}
									} else {
								%>
								참여자가 없습니다.
								<%
									}
								%>
								<br> <input type="button" name="personnelcloseBtn" class="closeBtn"
									value="닫기">
							</form>
						</div>

					</header>

					<div id="postcontainer">
						<div class="detailProductInfo">
							<div class="detailThumbnail">
								<img src="images/store/<%=product.getImageNo1()%>">
							</div>
							<div class="postTxt">
								<ul>
									<li><%=product.getName() %></li>
									
									<c:set var="discount" value="<%=product.getDiscountRate() %>"/>
									<c:choose>
										<c:when test="${discount eq 0}">
											<b><fmt:formatNumber value="<%=product.getPrice() %>" pattern="###,###,###,###,###,###" /> 원</b> <br> 
										</c:when>
										<c:otherwise>
											<li><font color="F05D23"><%=product.getDiscountRate()%>%</font> 
												<fmt:formatNumber value="<%=product.getPrice() %>" pattern="###,###,###,###,###,###" /> 원 <br> 
												<span class="pdtnonsale"><%=product.getPrice() %></span></li>
										</c:otherwise>
									</c:choose>
									
									<li><span class="progressValue">▶ <%=article.getPersonnel() + 1%>명
											구매 시 <fmt:formatNumber value="<%=product.getPrice() / (article.getPersonnel() + 1)%>" pattern="###,###,###,###,###,###" /> 원
									</span></li>
									<li>&nbsp;</li>

									<li><font color="gray"> <%=article.getEndDateTrans()%>
											마감
									</font></li>


									<!-- progress, 마감 시 회색 -->
									<%
										if (article.getPersonnelval() == article.getPersonnel() || article.getEndDateTrans().contains("전")) {
									%>
									<li><progress class="progressEnd"
											value="<%=article.getPersonnelval()%>" min="0"
											max="<%=article.getPersonnel()%>"></progress></li>
									<li><span class="progressEndValue"><%=article.getPersonnelval()%>/<%=article.getPersonnel()%>
											마감된 공동구매입니다. <%
										} else {
									%>

									<li>
										<progress class="progress" value="<%=article.getPersonnelval()%>" min="0" max="<%=article.getPersonnel()%>"></progress>
									</li>
									<li>
										<span class="progressValue"><%=article.getPersonnelval()%>/<%=article.getPersonnel()%>모집중 </span>
									</li> 
									<%
									 	}
									%>
								</ul>
							</div>
						</div>
						<div class="postTxt">
							<c:set var="contents" value="<%=article.getContents() %>"/>
							${fn:replace(contents, ENTER,"<br/>")}
						</div>
					</div>

					<footer id="postfooter">
						<div id="foot_replyCount">
							<ul class="txtleft">
								<li>좋아요 <%=heartCount%></li>
								<li>댓글 <%=rListCount%></li>
								<li>쪽지</li>
								<li>조회수<%=article.getReadCount()%></li>
							</ul>
						</div>
						<hr />
						<div id="foot_profileContainer">
							<a href="vege.user?command=profile&id=<%=article.getMemberId() %>">
								<div id="big_profilePic">
									<c:set var="profileImg" value="<%=article.getProfileImage()%>" />
									<c:choose>
										<c:when test="${empty profileImg}">
											<img src="images/common/emptyMember.png">
										</c:when>
										<c:otherwise>
											<img src="images/profileImages/<%=article.getProfileImage()%>">
										</c:otherwise>
									</c:choose>
								</div>
							</a>
							<div id="foot_profileTxt">
								<ul style="font-size: 13pt; font-weight: bold;" class="txtleft">
									<li><a href="vege.user?command=profile&id=<%=article.getMemberId() %>"><%=article.getNickname()%></a></li>
									<li style="color: lightgray;">|</li>
									<li>
									<c:choose>
										<c:when test="${follow==1}">
											<span style="color:gray;" onclick="unfollow(0)">팔로잉</span>
										</c:when>
										<c:otherwise>
											<span style="color:rgb(240, 93, 35);" onclick="follow(0)">팔로우</span>
										</c:otherwise>
									</c:choose>									
									</li>
								</ul>
							</div>
						</div>

					</footer>
					<hr />
					<div id="replyList">

						<!-- 댓글 입력 -->
						<div id="replyInsert">
							<div style="margin-bottom: 16px;">
								<ul style="font-size: 13pt; font-weight: bold;" class="txtleft">
									<li class="leftlist2">댓글</li>
									<li style="color: #F15F5F;" class="leftlist2"><%=rListCount%>
									</li>
								</ul>
							</div>
							<div style="position: relative;" onClick="replyLogin()">

								<form name="gongguReplyForm" action="gongguReplyWrite.cm"
									method="post">

									<input type="hidden" value="gonggu" name="postType"> 
									<input type="hidden" value="${ID}" name="memberId"> 
									<input type="hidden" value="<%=article.getId()%>" name="postId">
									<input type="hidden" value="<%=nowPage%>" name="nowPage">
									<input type="hidden" value="<%=article.getMemberId() %>" name="writerId">
									<input type="hidden" value=<%=request.getQueryString() %> name="nowQuery">

									<div id="small_profilePic" style="margin-top: 3px;">
										<c:choose>
											<c:when test="${empty PROFILEIMG}">
												<img src="images/common/emptyMember.png">
											</c:when>
											<c:otherwise>
												<img src="images/profileImages/${PROFILEIMG}">
											</c:otherwise>
										</c:choose>
									</div>
									<input type="text" name="contents" class="replyInput"
										placeholder="댓글 입력하기">
									<div class="replyInsertBtn">
										<c:if test="${!empty ID}">
											<input type="submit" name="replyBtn" value="입력">
										</c:if>
									</div>

								</form>

							</div>
						</div>

						<!-- 댓글 리스트 -->
						<%
							if (replyList != null && rListCount > 0) {
								for (int i = 0; i < replyList.size(); i++) {
						%>
						<div class="reply">
							<a href="vege.user?command=profile&id=<%=replyList.get(i).getMemberId() %>">
							<div id="small_profilePic" style="margin-top: 3px;">
								<c:set var="profileImg"
									value="<%=replyList.get(i).getProfileImage()%>" />
								<c:choose>
									<c:when test="${empty profileImg}">
										<img src="images/common/emptyMember.png">
									</c:when>
									<c:otherwise>
										<img
											src="images/profileImages/<%=replyList.get(i).getProfileImage()%>">
									</c:otherwise>
								</c:choose>
							</div>
							</a>
							<form id="replyUpDel">
								<!-- 참여자 아이디 -->
								<input type="hidden" name="replyMemberId"
									value="<%=replyList.get(i).getMemberId()%>">
								<!-- 게시글 아이디 -->
								<input type="hidden" name="postId" value="<%=article.getId()%>">


								<ul>
									<li style="font-weight: bold;"><span><%=replyList.get(i).getNickname()%></span>
									</li>

									<!-- 댓글 내용 -->
									<li>
										<div class="replyContentsWrap">
											<div class="replyContents"><%=replyList.get(i).getContents()%></div>
										</div>
									</li>

									<!-- 하단 메뉴(좋아요 수정삭제 등) -->
									<li class="replyMenu"><span><%=replyList.get(i).getDate()%>
											ᆞ </span> <input type="hidden" name="replyId"
										value="<%=replyList.get(i).getId()%>"> <!--  댓글 좋아요(0보다 많으면 '좋아요', 아니면 갯수 표시) -->
										<div id="replyHeart">
											<c:set var="isMemberLiked"
												value="<%=replyList.get(i).getIsMemberLiked()%>" />
											<c:choose>
												<c:when test="${isMemberLiked == '1'}">
													<span class="replyBtn" onclick="replyHeartDel(<%=i%>)">
														<img src="images/common/heart3.png" style="width: 20px;">
														<%=replyList.get(i).getHeartCount()%>
													</span>
												</c:when>

												<c:otherwise>
													<span class="replyBtn" onclick="replyHeartAdd(<%=i%>)">
														<img src="images/common/heart2.png" style="width: 20px;">
														<%
															if (replyList.get(i).getHeartCount() > 0) {
														%> <%=replyList.get(i).getHeartCount()%>
														<%
															} else {
																				out.println("좋아요");
																			}
														%>
													</span>
												</c:otherwise>
											</c:choose>
										</div> <span> ᆞ </span> <c:set var="replyId"
											value="<%=replyList.get(i).getMemberId()%>" /> <c:choose>

											<c:when test="${ID == replyId}">
												<span class="updateBtnWrap"> <input type="button"
													class="replyBtn" name="replyUpdateBtn" value="수정 "
													onclick="replyUpd(<%=i%>)">
												</span>
												<span> ᆞ </span>
												<input type="button" class="replyBtn" name="replyDeleteBtn"
													value="삭제 " onclick="replyDel(<%=i%>)">
											</c:when>
											<c:otherwise>
												<input type="button" class="replyBtn" name="replyDeleteBtn"
													value="쪽지쓰기">
											</c:otherwise>
										</c:choose></li>
								</ul>
							</form>

							<!-- 참여자 추가 -->
							<c:set var="postNick" value="<%=article.getNickname()%>" />
							<c:set var="replyNick" value="<%=replyList.get(i).getNickname()%>" />
							<c:if test="${NICKNAME == postNick}">
								<!-- 로그인 회원 == 게시글 작성자 -->
								<c:if test="${NICKNAME != replyNick}">
									<!-- 로그인 회원 != 댓글 작성자 -->
									<%
										if (article.getPersonnelval() != article.getPersonnel() && !article.getEndDateTrans().contains("전")) {
									%>
											<div class="personnel">
											<input type="button" class="plusBtn" name="personnelval"
												value="+" onclick="personnelAdd(<%=i%>)">
											<p class="arrow_box">참여자 추가하기</p>
										</div>
									<%
										}
									%>
								</c:if>
							</c:if>

						</div>

						<!-- 댓글이 없을때 화면에 표시됨 -->
						<%
							}
							} else {
						%>
						<section id="emptyArea">
							등록된 댓글이 없습니다. <br> 첫 댓글을 남겨보세요 :)
						</section>
						<%
							}
						%>

						<!-- 댓글 페이지 -->
						<div id="page">
							<span> <%
 	if (rNowPage <= 1) {
 %> [이전]&nbsp; <%
 	} else {
 %> <a href="gongguList.cm?page=<%=rNowPage - 1%>">[이전]</a>&nbsp;
								<%
									}
								%> <%
 	for (int a = rStartPage; a <= rEndPage; a++) {
 		if (a == rNowPage) {
 %> [<%=a%>] <%
 	} else {
 %> <a href="gongguList.cm?page=<%=a%>">[<%=a%>]
							</a>&nbsp; <%
 	}
 %> <%
 	}
 %> <%
 	if (rNowPage >= rMaxPage) {
 %> [다음] <%
 	} else {
 %> <a href="gongguList.cm?page=<%=nowPage + 1%>">[다음]</a> <%
 	}
 %>
							</span>
						</div>
					</div>
					</div>
				</section>
			</div>
	</div>
	<!--풋터-->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>