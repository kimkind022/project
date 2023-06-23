package controller;
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


}



