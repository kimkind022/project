package kdj.model;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import org.apache.ibatis.session.SqlSessionFactory;

import dto.CReplyDTO;
import dto.FundingOptionDTO;
import dto.FundingOrdersDTO;
import dto.FundingPostDTO;
import dto.GongguDTO;
import dto.MembersBean;
import dto.NoticeDTO;
import dto.OrderBean;
import dto.ProductBean;
import dto.StoryPostsDTO;
import mybatis.SqlMapConfig;
import svc.CHeartListService;
import util.Dateutil;

//model == service
public class MemberInfoModel {

	static MemberInfoModel model = new MemberInfoModel();

	public static MemberInfoModel instance() {
		return model;
	}

	private SqlSessionFactory factory = SqlMapConfig.getSqlSession();

	public String selectNickname(String memberId) {
		String nickname = null;
		SqlSession sqlSession = factory.openSession();
		nickname = sqlSession.selectOne("cm.selectNickname", memberId);
	
		sqlSession.close();
		return nickname;
	}
	
	public String selectProfileImage(String memberId) {
		String img = null;
		SqlSession sqlSession = factory.openSession();
		img = sqlSession.selectOne("cm.selectProfileImage", memberId);
	
		sqlSession.close();
		return img;
	}

	public List<StoryPostsDTO> selectStory(String memberId) {

		List<StoryPostsDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageStory", memberId);

		sqlSession.close();
		return list;
	}

	// 작성한 공동구매
	public List<GongguDTO> selectWriteGonggu(String memberId) throws Exception {

		List<GongguDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectWriteGonggu", memberId);

		sqlSession.close();
		return list;
	}

	// 참여한 공동구매
	public List<GongguDTO> selectParticipateGonggu(String memberId) throws Exception {

		List<GongguDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectParticipateGonggu", memberId);
	
		sqlSession.close();
		return list;
	}

	public int selectHeartCount(int postId, String postType) {

		int heartCount = 0;

		SqlSession sqlSession = factory.openSession();
		if("gonggu".equals(postType))
			heartCount = sqlSession.selectOne("cm.selectGHeartCount", postId);
		else if("story".equals(postType))
			heartCount = sqlSession.selectOne("cm.selectSHeartCount", postId);
		
		sqlSession.close();
		return heartCount;
	}

	public int selectReplyCount(int postId, String postType) {

		int replyCount = 0;

		SqlSession sqlSession = factory.openSession();
		if("gonggu".equals(postType))
			replyCount = sqlSession.selectOne("cm.selectGReplyCount", postId);
		else if("story".equals(postType))
			replyCount = sqlSession.selectOne("cm.selectSReplyCount", postId);
		
		sqlSession.close();
		return replyCount;
	}

	public ProductBean selectProduct(int productId) {

		ProductBean productBean = null;

		SqlSession sqlSession = factory.openSession();
		productBean = sqlSession.selectOne("cm.selectProduct", productId);

		sqlSession.close();
		return productBean;
	}

	public List<CReplyDTO> selectReply(String memberId) {

		List<CReplyDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageReply", memberId);

		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
//				Timestamp date = (Timestamp) list.get(i).getDate();
//				String dateTrans = Dateutil.txtDate(date);
//				list.get(i).setDateTrans(dateTrans);

				int postId = list.get(i).getPostId();
				String postType = "gonggu";

				CHeartListService cHeartListService = new CHeartListService();
				String isMemberLiked;
				try {
					isMemberLiked = cHeartListService.isReplyHeartExist(postType, postId, memberId);
					list.get(i).setIsMemberLiked(isMemberLiked);
				} catch (Exception e) {
					e.printStackTrace();
				}

//				int heartCount = 0;
				// heartCount = sqlSession.selectOne("selectHeartCount", postId);
				// //System.out.println(heartCount);

				// list.get(i).setHeartCount(heartCount);

			}
		}

		sqlSession.close();
		return list;
	}

	public MembersBean selectMember(String memberId) {

		MembersBean membersBean = null;

		SqlSession sqlSession = factory.openSession();
		membersBean = sqlSession.selectOne("cm.selectMypageMember", memberId);

		sqlSession.close();
		return membersBean;
	}

	public void updateMember(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MembersBean membersBean = (MembersBean) request.getAttribute("data");

		SqlSession sqlSession = factory.openSession();
		sqlSession.insert("cm.updateMypageMember", membersBean);

		sqlSession.commit();
		sqlSession.close();
	}

	public void updatePassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MembersBean membersBean = (MembersBean) request.getAttribute("data");

		SqlSession sqlSession = factory.openSession();
		sqlSession.insert("cm.updateMypagePw", membersBean);

		sqlSession.commit();
		sqlSession.close();
	}

	public int selectNoticeCount(String memberId) {
		int count=0;

		SqlSession sqlSession = factory.openSession();
		count = sqlSession.selectOne("cm.selectNoticeCount", memberId);

		sqlSession.close();
		return count;
	}
	
	public List<NoticeDTO> selectNotice(Map<String, Object> map) {
		List<NoticeDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectNotice", map);

		sqlSession.close();
		return list;
	}

	public List<OrderBean> selectOrder(String memberId) {
		List<OrderBean> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageOrder", memberId);

		sqlSession.close();
		return list;
	}
	
	public List<FundingOrdersDTO> selectFunding(String memberId) {
		List<FundingOrdersDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageFunding", memberId);

		sqlSession.close();
		return list;
	}
	
	public FundingOptionDTO selectFundingOption(int id) {
		FundingOptionDTO list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectOne("cm.selectMypageFundingOptions", id);

		sqlSession.close();
		return list;
	}
	
	public FundingPostDTO selectFundingPost(int id) {
		FundingPostDTO list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectOne("cm.selectMypageFundingPost", id);

		sqlSession.close();
		return list;
	}

	public List<ProductBean> selectLikedPdt(String memberId) {
		List<ProductBean> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageLikedPdt", memberId);

		sqlSession.close();
		return list;
	}

	public List<StoryPostsDTO> selectLikedStory(String memberId) {
		List<StoryPostsDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageLikedStory", memberId);
		
		sqlSession.close();
		return list;
	}
	
	public List<GongguDTO> selectLikedGonggu(String memberId) {
		List<GongguDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageLikedGonggu", memberId);
		
		sqlSession.close();
		return list;
	}
	
	public List<FundingPostDTO> selectLikedFunding(String memberId) {
		List<FundingPostDTO> list = null;

		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("cm.selectMypageLikedFunding", memberId);
		
		sqlSession.close();
		return list;
	}
}
