package controller;
import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import kdj.command.CommandInter;
import kdj.command.MypageImpl;


public class ControllerServlet extends HttpServlet{

	@Override

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		CommandInter inter = null;
		String viewName = "";

		
		try {
			// 프로필
			if(command.equals("notice")){
				inter = MypageImpl.instance();
				viewName = inter.selectNotice(request, response);
				viewName = "mNotice.jsp";
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myStory")){
				inter = MypageImpl.instance();
				viewName = inter.selectStory(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myGonggu")){
				inter = MypageImpl.instance();
				viewName = inter.selectGonggu(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myGonggu_writed")){
				inter = MypageImpl.instance();
				viewName = inter.selectWriteGonggu(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myGonggu_participated")){
				inter = MypageImpl.instance();
				viewName = inter.selectParticipateGonggu(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myReply")){
				inter = MypageImpl.instance();
				viewName = inter.selectReply(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myHeart_products")){
				inter = MypageImpl.instance();
				viewName = inter.selectHeartsPdt(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myHeart_story")){
				inter = MypageImpl.instance();
				viewName = inter.selectHeartsStory(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myHeart_gonggu")){
				inter = MypageImpl.instance();
				viewName = inter.selectHeartsGonggu(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("myHeart_funding")){
				inter = MypageImpl.instance();
				viewName = inter.selectHeartsFunding(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			
			// 설정
			else if(command.equals("editUserInfo")){
				inter = MypageImpl.instance();
				viewName = inter.selectOneMember(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
				// 리턴값이 파일명(jsp)인 경우
			} 
			else if(command.equals("updateUserInfo")){
				inter = MypageImpl.instance();
				viewName = inter.updateMember(request, response);
				response.sendRedirect(viewName);
				// 리턴값이 커맨드인 경우
			} 
			else if(command.equals("editPush")){
				viewName = "mPush.jsp";
				request.getRequestDispatcher(viewName).forward(request, response);
			}
			else if(command.equals("editPassword")){
				viewName = "mPassword.jsp";
				request.getRequestDispatcher(viewName).forward(request, response);;
			}
			else if(command.equals("updatePassword")){
				inter = MypageImpl.instance();
				viewName = inter.updatePassword(request, response);
				response.sendRedirect(viewName);
			}
			
			else if(command.equals("recipe")){
				inter = MypageImpl.instance();
				viewName = inter.selectGonggu(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			
			
			// 주문조회
			else if(command.equals("myOrder")){
				inter = MypageImpl.instance();
				viewName = inter.selectOrder(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			else if(command.equals("myFunding")){
				inter = MypageImpl.instance();
				viewName = inter.selectFunding(request, response);
				request.getRequestDispatcher(viewName).forward(request, response);
			} 
			
			else {
				viewName = "error.html";
				response.sendRedirect(viewName);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}



