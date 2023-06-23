package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.GongguDeleteProAction;
import action.GongguDetailAction;
import action.GongguListAction;
import action.GongguUpdateFormAction;
import action.GongguUpdateProAction;
import action.GongguWriteFormAction;
import action.GongguWriteProAction;
import action.GongguWriteSelectAction;
import action.PersonnelInsertAction;
import action.StoryDetailAction;
import action.StoryListAction;
import action.StoryUpdateFormAction;
import action.StoryUpdateProAction;
import action.StoryWriteProAction;
import action.cMainAction;
import action.StoryDeleteProAction;
import action.CReplyWriteAction;
import dto.ActionForward;


@WebServlet("*.cm")

public class CFrontController extends javax.servlet.http.HttpServlet 
{
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String RequestURI=request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=RequestURI.substring(contextPath.length());
		ActionForward forward=null;
		Action action=null;

		if(command.equals("/communityMain.cm")){
			action = new cMainAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		//스토리
		else if(command.equals("/storyList.cm")){
			action = new StoryListAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/storyDetail.cm")){
			action = new StoryDetailAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/storyWriteForm.cm")){
			forward=new ActionForward();
			forward.setPath("/cStoryWrite.jsp");
		}
		else if(command.equals("/storyWritePro.cm")){
			action  = new StoryWriteProAction();
			try {
				forward=action.execute(request, response );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/storyDeletePro.cm")){
			action = new StoryDeleteProAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/storyReplyWrite.cm")){
			action = new CReplyWriteAction();
			try {
				forward=action.execute(request, response );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/storyUpdateForm.cm")){
			action = new StoryUpdateFormAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/storyUpdatePro.cm")){
			action = new StoryUpdateProAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		
		// 공구
		else if(command.equals("/gongguWriteSelect.cm")){
			action = new GongguWriteSelectAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/gongguWriteForm.cm")){
			action = new GongguWriteFormAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/gongguWritePro.cm")){
			action  = new GongguWriteProAction();
			try {
				forward=action.execute(request, response );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/gongguList.cm")){
			action = new GongguListAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/gongguDetail.cm")){
			action = new GongguDetailAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/gongguUpdateForm.cm")){
			action = new GongguUpdateFormAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}else if(command.equals("/gongguUpdatePro.cm")){
			action = new GongguUpdateProAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}else if(command.equals("/gongguDeletePro.cm")){
			action = new GongguDeleteProAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/gongguReplyWrite.cm")){
			action = new CReplyWriteAction();
			try {
				forward=action.execute(request, response );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/personnelInsert.cm")){
			action = new PersonnelInsertAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(forward != null){
			
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher=
						request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
			
		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	}  	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	}   
	
}