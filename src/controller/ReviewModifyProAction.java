package controller;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import dto.ActionForward;
import dto.BasketBean;
import dto.BoardBean;
import svc.BasketInsertService;
import svc.BoardWriteProService;
import svc.ReviewModifyService;

public class ReviewModifyProAction implements Action {
	
	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		    System.out.println("위치: ReviewModifyProAction 상태: execute메소드 들어옴");
		
			HttpSession session = request.getSession(); // 자바에서 세션을 쓰려면 이걸 해줘야한다.
		    ActionForward forward = null;
			BoardBean boardBean = null;
			String realFolder="";
			String saveFolder="/store";
			int fileSize=5*1024*1024; 	
			ServletContext context = request.getServletContext();
			realFolder=context.getRealPath(saveFolder);   		
			MultipartRequest multi=new MultipartRequest(request,realFolder,fileSize,
					"UTF-8",
					new DefaultFileRenamePolicy());
			
			//	이전 페이지reviewWrite.jsp에서 서브밋으로 넘긴 products테이블의 productId
		
			System.out.println(multi.getParameter("productId"));
			System.out.println(multi.getParameter("orderId"));
			System.out.println(multi.getParameter("contents"));
			System.out.println(multi.getParameter("rating"));
			System.out.println((String)multi.getFileNames().nextElement());

			
			//리뷰테이블 
			boardBean = new BoardBean();
			//id는 오토인크리먼트로 입력 x
			boardBean.setOrderId(multi.getParameter("orderId"));
			boardBean.setProductId(Integer.parseInt(multi.getParameter("productId")));
			boardBean.setContents(multi.getParameter("contents"));
			boardBean.setRating(Integer.parseInt(multi.getParameter("rating")));
			boardBean.setFile(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
			
			System.out.println("2번 BoardWriteProService 전까지 ok");
			
			ReviewModifyService reviewModifyService = new ReviewModifyService();
			boolean isModifySuccess = reviewModifyService.modifyReview(boardBean);
			//boardBean에 담고서 boardWriteProService의 registReview메소드로 호출 전달
			System.out.println("위치: ReviewModifyAction, 상태: isModifySuccess: " + isModifySuccess);
			
		    if(!isModifySuccess){
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('fail')");
				out.println("history.back();");
				out.println("</script>");
			}
			else{
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("StoreFrequent.pd");
			}

			return forward;
			
		}  	
		
	}