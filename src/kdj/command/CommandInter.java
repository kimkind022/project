package kdj.command;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;



public interface CommandInter {
	String selectOneMember(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String updateMember(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String updatePassword(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectStory(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectGonggu(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectReply(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectWriteGonggu(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectParticipateGonggu(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectNotice(HttpServletRequest request, HttpServletResponse response);
	String selectOrder(HttpServletRequest request, HttpServletResponse response);
	String selectFunding(HttpServletRequest request, HttpServletResponse response);
	String selectHeartsPdt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectHeartsStory(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectHeartsGonggu(HttpServletRequest request, HttpServletResponse response) throws Exception;
	String selectHeartsFunding(HttpServletRequest request, HttpServletResponse response);


}



