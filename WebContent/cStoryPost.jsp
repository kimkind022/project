<%@page import="dto.StoryPostsDTO"%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="dto.PageInfo"%>
<%@page import="dto.CReplyDTO"%>
<%@page import="dto.StoryProductsDTO"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%pageContext.setAttribute("ENTER","\n"); %>
<%
	response.setContentType("text/html; charset=utf-8");
	response.setCharacterEncoding("utf-8");
	request.setCharacterEncoding("utf-8");
%>

<%
	// 글 내용
	StoryPostsDTO article = (StoryPostsDTO) request.getAttribute("article");
	ArrayList<StoryProductsDTO> products = (ArrayList<StoryProductsDTO>) request.getAttribute("products");

	// 팔로우 정보
	int follow = (int) request.getAttribute("follow");
	
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
<meta charset="utf-8">
<title>스토리</title>
</head>

<link href="styles/communityStory.css" rel="stylesheet" type="text/css">
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="script/community.js"></script>

<body>
	<!--헤더-->
	<jsp:include page="header.jsp"></jsp:include>
	<div class="wrap1">
		<div class="wrap770">
				<div id="quickmenu">
					<div>
						<div class="quickIcon1">
							<div id="postHeart">
								<c:set var="isMemberLiked" value="<%=isMemberLiked %>" />
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
					<a href="#foot_profileTxt" id="quickReply">
						<div class="quickIcon1">
							<div>
								<img src="images/common/comment2.png">
							</div>
						</div>
						<div><%=rListCount%></div>
					</a> 
					<a href="storyList.cm?page=<%=nowPage%>">
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
						<div class="postSubTitle"><%=article.getCategory()%></div>
						<div class="postTitle"><%=article.getTitle()%></div>
						<div id="profileContainer">
							<div id="profileImg">
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
									<li style="font-size: 11pt; color: gray;"><%=article.getDateTrans() %></li>
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
												onClick="storyDelete()"></li>
											<li>|</li>
											<li><a href="storyUpdateForm.cm?id=<%=article.getId()%>&page=<%=nowPage%>"><input
													type="button" value="수정"></a></li>
										</ul>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</header>
					<div id="postcontainer">
						<div class="postImg"><img src="images/community/<%=article.getThumbnail()%>"></div>
						
						<!-- 스토리에 사용된 상폼 목록 -->
						<%if (products.size()!=0) { %>
						<div class="storyProducts">
						<div>이 스토리에 사용된 상품</div>
						<%
								for (int i = 0; i < products.size(); i++) {
						%>
							<a href="storeProductDetail.pd?id=<%=products.get(i).getProductId()%>">
							<div class="productsImg"><img src="images/store/<%=products.get(i).getProductThumbnail()%>"></div>
							</a>
						<%
								}
						%>
						
						</div>
						<%
						}
						%>				
						
						
						<div class="postTxt">
						 <c:set var="contents" value="<%=article.getContents() %>"/>
							${fn:replace(contents, ENTER,"<br/>")}
						</div>
					</div>
					<footer id="postfooter">
						<div id="foot_viewCount">
							<ul class="txtleft">
								<li>좋아요 <%=heartCount%></li>
								<li>댓글 <%=rListCount%></li>
								<li>조회수<%=article.getReadCount()%></li>
							</ul>
						</div>
						<hr />
						<div id="foot_profileContainer">
							<a href="vege.user?command=myStory&id=<%=article.getMemberId() %>">
								<div id="big_profileImg">
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
									<li><a href="vege.user?command=myStory&id=<%=article.getMemberId() %>"><%=article.getNickname()%></a></li>
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
						<hr />
					</footer>

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

								<form name="storyReplyForm" action="storyReplyWrite.cm"
									method="post">

									<input type="hidden" value="story" name="postType"> 
									<input type="hidden" value="${ID}" name="memberId"> 
									<input type="hidden" value="<%=article.getId()%>" name="postId">
									<input type="hidden" value="<%=nowPage%>" name="nowPage">
									<input type="hidden" value="<%=article.getMemberId() %>" name="writerId">
									<input type="hidden" value=<%=request.getQueryString() %> name="nowQuery">
									
									<div id="small_profileImg" style="margin-top: 3px;">
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
							<div id="small_profileImg" style="margin-top: 3px;">
								<c:set var="profileImg"
									value="<%=replyList.get(i).getProfileImage()%>" />
								<c:choose>
									<c:when test="${empty profileImg}">
										<img src="images/common/emptyMember.png">
									</c:when>
									<c:otherwise>
										<img src="images/profileImages/<%=replyList.get(i).getProfileImage()%>">
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
										</c:choose>
									</li>
								</ul>
							</form>
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
					</div>		
				</div>
			</section>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>