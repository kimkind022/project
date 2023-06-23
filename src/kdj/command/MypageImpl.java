package kdj.command;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.MembersDAO;
import dao.NoticeDAO;
import dto.StoryPostsDTO;
import dto.CReplyDTO;
import dto.FundingOptionDTO;
import dto.FundingOrdersDTO;
import dto.FundingPostDTO;
import dto.GongguDTO;
import dto.HeartBean;
import dto.MembersBean;
import dto.NoticeDTO;
import dto.OrderBean;
import dto.PageInfo;
import dto.ProductBean;
import kdj.model.MemberInfoModel;
import svc.CFollowService;
import svc.CHeartListService;
import util.Dateutil;

// action
public class MypageImpl implements CommandInter{

	static MypageImpl impl = new MypageImpl();

	public static MypageImpl instance(){
		return impl;
	}
	
	public int selectFollower(String memberId) {
		Connection con = getConnection();
		MembersDAO membersDAO = MembersDAO.getInstance();
		membersDAO.setCon(con);
		int follower = membersDAO.selectFollowerCount(memberId);
		close(con);
		return follower;
	}
	
	public int selectFollowing(String memberId) {
		Connection con = getConnection();
		MembersDAO membersDAO = MembersDAO.getInstance();
		membersDAO.setCon(con);
		int following = membersDAO.selectFollowingCount(memberId);
		close(con);
		return following;
	}

	public MembersBean selectMember (String memberId) {
		
		MemberInfoModel model = MemberInfoModel.instance();		
		MembersBean member = (MembersBean) model.selectMember(memberId);
		
		return member;
	}
	
	@Override	// 스토리 목록
	public String selectStory (HttpServletRequest request, HttpServletResponse response) throws Exception {
		String memberId = null;
		int isfollow=0;
		
		HttpSession session = request.getSession();
		if(request.getParameter("id")==null) {
			memberId = (String)session.getAttribute("ID");
		}
		else {
			memberId = request.getParameter("id");
			CFollowService cFollowService = new CFollowService();
			isfollow = cFollowService.isMemberFollowing(memberId, (String)session.getAttribute("ID"));
		}
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<StoryPostsDTO> list = (ArrayList<StoryPostsDTO>) model.selectStory(memberId);
		
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				int postId = list.get(i).getId();
				CHeartListService cHeartListService = new CHeartListService();
				String isMemberLiked;
				isMemberLiked = cHeartListService.isHeartExist("story", postId, memberId);
				list.get(i).setIsMemberLiked(isMemberLiked);

				int heartCount = 0;
				heartCount = model.selectHeartCount(postId, "story");
				list.get(i).setHeartCount(heartCount);

				int replyCount = 0;
				replyCount =  model.selectReplyCount(postId, "story");
				list.get(i).setReplyCount(replyCount);
			}
		}
		
		
		int follower = selectFollower(memberId);
		int following = selectFollowing(memberId);
		
		MembersBean member = selectMember(memberId);
		
		request.setAttribute("isfollow", isfollow);
		request.setAttribute("member", member);
		request.setAttribute("data", list);
		request.setAttribute("follower", follower);
		request.setAttribute("following", following);
		return "mStory.jsp";
	}
	
	@Override	// 공동구매 목록
	public String selectGonggu (HttpServletRequest request, HttpServletResponse response) throws Exception {
		String memberId = null;
		int isfollow=0;
		
		HttpSession session = request.getSession();
		if(request.getParameter("id")==null) {
			memberId = (String)session.getAttribute("ID");
		}
		else {
			memberId = request.getParameter("id");
			CFollowService cFollowService = new CFollowService();
			isfollow = cFollowService.isMemberFollowing(memberId, (String)session.getAttribute("ID"));
		}
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<GongguDTO> list = (ArrayList<GongguDTO>) model.selectWriteGonggu(memberId);
		ArrayList<GongguDTO> list2 = (ArrayList<GongguDTO>) model.selectParticipateGonggu(memberId);
		
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				String nickname = model.selectNickname(memberId);
				list.get(i).setNickname(nickname);

				Timestamp endDate = (Timestamp) list.get(i).getEndDate();
				String endDateTrans = Dateutil.txtDate(endDate);
				list.get(i).setEndDateTrans(endDateTrans);

				Timestamp date = (Timestamp) list.get(i).getDate();
				String dateTrans = Dateutil.txtDate(date);
				list.get(i).setDateTrans(dateTrans);

				int postId = list.get(i).getId();
				CHeartListService cHeartListService = new CHeartListService();
				String isMemberLiked;
				isMemberLiked = cHeartListService.isHeartExist("gonggu", postId, memberId);
				list.get(i).setIsMemberLiked(isMemberLiked);

				int heartCount = 0;
				heartCount = model.selectHeartCount(postId, "gonggu");
				list.get(i).setHeartCount(heartCount);

				int replyCount = 0;
				replyCount =  model.selectReplyCount(postId, "gonggu");
				list.get(i).setReplyCount(replyCount);

				ProductBean product = new ProductBean();
				product =  model.selectProduct(list.get(i).getProductId());
				list.get(i).setProductBean(product);
			}
		}
		if (list2.size()>0) {
			for (int i = 0; i < list2.size(); i++) {
				String nickname = model.selectNickname(memberId);
				list2.get(i).setNickname(nickname);

				Timestamp endDate = (Timestamp) list2.get(i).getEndDate();
				String endDateTrans = Dateutil.txtDate(endDate);
				list2.get(i).setEndDateTrans(endDateTrans);

				Timestamp date = (Timestamp) list2.get(i).getDate();
				String dateTrans = Dateutil.txtDate(date);
				list2.get(i).setDateTrans(dateTrans);

				int postId = list2.get(i).getId();
				CHeartListService cHeartListService = new CHeartListService();
				String isMemberLiked;
				isMemberLiked = cHeartListService.isHeartExist("gonggu", postId, memberId);
				list2.get(i).setIsMemberLiked(isMemberLiked);

				int heartCount = 0;
				heartCount = model.selectHeartCount(postId, "gonggu");
				list2.get(i).setHeartCount(heartCount);

				int replyCount = 0;
				replyCount =  model.selectReplyCount(postId, "gonggu");
				list2.get(i).setReplyCount(replyCount);

				ProductBean product = new ProductBean();
				product =  model.selectProduct(list2.get(i).getProductId());
				list2.get(i).setProductBean(product);
			}
		}
		int follower = selectFollower(memberId);
		int following = selectFollowing(memberId);
		MembersBean member = selectMember(memberId);
		
		request.setAttribute("isfollow", isfollow);
		request.setAttribute("member", member);
		request.setAttribute("data", list);		
		request.setAttribute("data2", list2);
		request.setAttribute("follower", follower);
		request.setAttribute("following", following);

		return "mGonggu.jsp";
	}
	
	@Override	// 공동구매 목록
	public String selectWriteGonggu (HttpServletRequest request, HttpServletResponse response) throws Exception {
		String memberId = null;
		
		int isfollow=0;
		
		HttpSession session = request.getSession();
		if(request.getParameter("id")==null) {
			memberId = (String)session.getAttribute("ID");
		}
		else {
			memberId = request.getParameter("id");
			CFollowService cFollowService = new CFollowService();
			isfollow = cFollowService.isMemberFollowing(memberId, (String)session.getAttribute("ID"));
		}
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<GongguDTO> list = (ArrayList<GongguDTO>) model.selectWriteGonggu(memberId);
		
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				String nickname = model.selectNickname(memberId);
				list.get(i).setNickname(nickname);

				Timestamp endDate = (Timestamp) list.get(i).getEndDate();
				String endDateTrans = Dateutil.txtDate(endDate);
				list.get(i).setEndDateTrans(endDateTrans);

				Timestamp date = (Timestamp) list.get(i).getDate();
				String dateTrans = Dateutil.txtDate(date);
				list.get(i).setDateTrans(dateTrans);

				int postId = list.get(i).getId();
				CHeartListService cHeartListService = new CHeartListService();
				String isMemberLiked;
				isMemberLiked = cHeartListService.isHeartExist("gonggu", postId, memberId);
				list.get(i).setIsMemberLiked(isMemberLiked);

				int heartCount = 0;
				heartCount = model.selectHeartCount(postId, "gonggu");
				list.get(i).setHeartCount(heartCount);

				int replyCount = 0;
				replyCount =  model.selectReplyCount(postId, "gonggu");
				list.get(i).setReplyCount(replyCount);

				ProductBean product = new ProductBean();
				product =  model.selectProduct(list.get(i).getProductId());
				list.get(i).setProductBean(product);
			}
		}
		int follower = selectFollower(memberId);
		int following = selectFollowing(memberId);
		MembersBean member = selectMember(memberId);
		
		request.setAttribute("isfollow", isfollow);
		request.setAttribute("member", member);
		request.setAttribute("data", list);
		request.setAttribute("follower", follower);
		request.setAttribute("following", following);
		return "mGongguWrite.jsp";
	}
	
	@Override	// 공동구매 목록
	public String selectParticipateGonggu (HttpServletRequest request, HttpServletResponse response) throws Exception {
		String memberId = null;
		int isfollow=0;
		
		HttpSession session = request.getSession();
		if(request.getParameter("id")==null) {
			memberId = (String)session.getAttribute("ID");
		}
		else {
			memberId = request.getParameter("id");
			CFollowService cFollowService = new CFollowService();
			isfollow = cFollowService.isMemberFollowing(memberId, (String)session.getAttribute("ID"));
		}
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<GongguDTO> list = (ArrayList<GongguDTO>) model.selectParticipateGonggu(memberId);
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				String nickname = model.selectNickname(memberId);
				list.get(i).setNickname(nickname);

				Timestamp endDate = (Timestamp) list.get(i).getEndDate();
				String endDateTrans = Dateutil.txtDate(endDate);
				list.get(i).setEndDateTrans(endDateTrans);

				Timestamp date = (Timestamp) list.get(i).getDate();
				String dateTrans = Dateutil.txtDate(date);
				list.get(i).setDateTrans(dateTrans);

				int postId = list.get(i).getId();
				CHeartListService cHeartListService = new CHeartListService();
				String isMemberLiked;
				isMemberLiked = cHeartListService.isHeartExist("gonggu", postId, memberId);
				list.get(i).setIsMemberLiked(isMemberLiked);

				int heartCount = 0;
				heartCount = model.selectHeartCount(postId, "gonggu");
				list.get(i).setHeartCount(heartCount);

				int replyCount = 0;
				replyCount =  model.selectReplyCount(postId, "gonggu");
				list.get(i).setReplyCount(replyCount);

				ProductBean product = new ProductBean();
				product =  model.selectProduct(list.get(i).getProductId());
				list.get(i).setProductBean(product);
			}
		}
		int follower = selectFollower(memberId);
		int following = selectFollowing(memberId);
		MembersBean member = selectMember(memberId);
		
		request.setAttribute("isfollow", isfollow);
		request.setAttribute("member", member);
		request.setAttribute("data", list);
		request.setAttribute("follower", follower);
		request.setAttribute("following", following);
		return "mGongguParticipate.jsp";
	}
	
	
	@Override	// 댓글 목록
	public String selectReply (HttpServletRequest request, HttpServletResponse response) throws Exception {
		String memberId = null;
		int isfollow=0;
		
		HttpSession session = request.getSession();
		if(request.getParameter("id")==null) {
			memberId = (String)session.getAttribute("ID");
		}
		else {
			memberId = request.getParameter("id");
			CFollowService cFollowService = new CFollowService();
			isfollow = cFollowService.isMemberFollowing(memberId, (String)session.getAttribute("ID"));
		}
		
		String command = request.getParameter("command");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<CReplyDTO> list = (ArrayList<CReplyDTO>) model.selectReply(memberId);
		
		int follower = selectFollower(memberId);
		int following = selectFollowing(memberId);
		MembersBean member = selectMember(memberId);
		
		request.setAttribute("isfollow", isfollow);
		request.setAttribute("member", member);
		request.setAttribute("follower", follower);
		request.setAttribute("following", following);
		request.setAttribute("data", list);
		
		String returnVal = null;
		
		if(command.equals("myReply")) {
			returnVal= "mReply.jsp";	
		}
		else if(command.equals("myReply")) {
			returnVal= "mReply.jsp";	
		}
		
		return returnVal;
	}
	
	
	// 좋아요 - 상품
	@Override
	public String selectHeartsPdt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<ProductBean> list = (ArrayList<ProductBean>) model.selectLikedPdt(memberId);
		
		request.setAttribute("data", list);
		
		return"mHeartProducts.jsp";
	}
	
	// 좋아요 - 스토리
	@Override	
	public String selectHeartsStory (HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<StoryPostsDTO> list = (ArrayList<StoryPostsDTO>) model.selectLikedStory(memberId);

		if (list.size()!=0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setNickname(model.selectNickname(list.get(i).getMemberId()));
				list.get(i).setProfileImage(model.selectProfileImage(list.get(i).getMemberId()));
			}
		}
		request.setAttribute("data", list);
		return "mHeartStory.jsp";
	}
	
	// 좋아요 - 공구
	@Override	
	public String selectHeartsGonggu (HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<GongguDTO> list = (ArrayList<GongguDTO>) model.selectLikedGonggu(memberId);
	
		if (list.size()!=0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setNickname(model.selectNickname(list.get(i).getMemberId()));
				list.get(i).setProfileImage(model.selectProfileImage(list.get(i).getMemberId()));
				
				ProductBean product = new ProductBean();
				product =  model.selectProduct(list.get(i).getProductId());
				list.get(i).setProductBean(product);
				
				Timestamp endDate = (Timestamp) list.get(i).getEndDate();
				String endDateTrans = Dateutil.txtDate(endDate);
				list.get(i).setEndDateTrans(endDateTrans);
			}
		}
		request.setAttribute("data", list);
		return "mHeartGonggu.jsp";
	}
	@Override
	public String selectHeartsFunding(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<FundingPostDTO> list = (ArrayList<FundingPostDTO>) model.selectLikedFunding(memberId);
		
		request.setAttribute("data", list);
		return "mHeartFunding.jsp";
	}
	
	
	
	@Override	//회원정보수정 - 정보 불러오기
	public String selectOneMember (HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		MembersBean membersBean = (MembersBean) model.selectMember(memberId);
		
		request.setAttribute("data", membersBean);
		return "mUserInfo.jsp";
	}
	
	@Override	//회원정보수정 - 정보 수정
	public String updateMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		ServletContext context = request.getServletContext();
		String imagePath=context.getRealPath("/images/profileImages");
		
		int size = 1*1024*1024 ;
		String filename="";

		MultipartRequest multi=	new MultipartRequest(request, imagePath, size, "UTF-8",
								new DefaultFileRenamePolicy());
			
		Enumeration files=multi.getFileNames();
			
		String file =(String)files.nextElement();
		filename=multi.getFilesystemName(file);


		
		MembersBean membersBean = new MembersBean();
		membersBean.setId(memberId);
		membersBean.setName(multi.getParameter("name"));
		membersBean.setNickname(multi.getParameter("nickname"));
		membersBean.setTel(multi.getParameter("tel"));
		membersBean.setAddress1(multi.getParameter("address"));
		membersBean.setAddress2(multi.getParameter("addressInfo"));
		membersBean.setProfileImage(filename);
		request.setAttribute("data", membersBean);
		
		MemberInfoModel model = MemberInfoModel.instance();		
		model.updateMember(request, response);
		session.setAttribute("NICKNAME", multi.getParameter("nickname"));
		session.setAttribute("PROFILEIMG", filename);
		return "vege.user?command=editUserInfo";
	}
	
	@Override	// 비밀번호 수정
	public String updatePassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MembersBean membersBean = new MembersBean();
		membersBean.setId(memberId);
		membersBean.setPw(request.getParameter("pw"));
		
		request.setAttribute("data", membersBean);
		
		MemberInfoModel model = MemberInfoModel.instance();		
		model.updatePassword(request, response);
		return "vege.user?command=editPassword";
	}


	@Override
	public String selectNotice(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		int page = 1;
		int limit = 7;
		
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			// 페이지가 null이 아니라면. page = url 상의 page
		}
		
		
		Map<String,Object> map= new HashMap<String, Object>();
		map.put("page", page);
		map.put("memberId", memberId);
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<NoticeDTO> list =  (ArrayList<NoticeDTO>) model.selectNotice(map);
		int listCount =  model.selectNoticeCount(memberId);
		
		int maxPage = (int) ((double) listCount / limit + 0.95);
		int startPage = (((int) ((double) page / 7 + 0.9)) - 1) * 7 + 1;
		int endPage = startPage + 7 - 1;

		if (endPage > maxPage)
			endPage = maxPage;

		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				Timestamp date = (Timestamp) list.get(i).getCreatedTime();
				String dateTrans = Dateutil.txtDate(date);
				list.get(i).setDateTrans(dateTrans);
			}
		}
		
		int follower = selectFollower(memberId);
		int following = selectFollowing(memberId);
		
		request.setAttribute("data", list);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("follower", follower);
		request.setAttribute("following", following);
		return "mUserInfo.jsp";
	}


	@Override
	public String selectOrder(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<OrderBean> list = (ArrayList<OrderBean>) model.selectOrder(memberId);
		
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				ProductBean product = new ProductBean();
				product =  model.selectProduct(list.get(i).getProductId());
				list.get(i).setProductBean(product);
			}
		}
		
		request.setAttribute("data", list);
		return "mOrders.jsp";
	}


	@Override
	public String selectFunding(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("ID");
		
		MemberInfoModel model = MemberInfoModel.instance();		
		ArrayList<FundingOrdersDTO> list = (ArrayList<FundingOrdersDTO>) model.selectFunding(memberId);
		
		if (list.size()>0) {
			for (int i = 0; i < list.size(); i++) {
				FundingOptionDTO option = new FundingOptionDTO();
				option =  model.selectFundingOption(list.get(i).getOptionsId());
				list.get(i).setOption(option);
				
				FundingPostDTO post = new FundingPostDTO();
				post =  model.selectFundingPost(list.get(i).getFundingId());
				list.get(i).setPost(post);
			}
		}
		
		request.setAttribute("data", list);
		return "mFunding.jsp";
	}

}