package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.Action;
import action.BasketAction;
import action.BasketInsertAction;
import action.BasketDeleteAction;
import action.BasketInsertAction;
import action.BoardListAction;
import action.BoardWriteProAction;
import action.FrequentAction;
import action.HeartDataAction;
import action.HeartSelectAction;
import action.ProductAction;
import action.ReviewModifyAction;
import action.StoreCategoryDataAction;
import action.StoreCategoryDataOrderByAction;
import action.StoreCategoryShowMoreAction;
import action.StoreMainAction;
import action.BasketAction;
import dto.ActionForward;

@WebServlet("*.pd")
public class BoardFrontController extends javax.servlet.http.HttpServlet {
  protected void doProcess(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    String RequestURI = request.getRequestURI();
    String contextPath = request.getContextPath();
    String command = RequestURI.substring(contextPath.length());
    ActionForward forward = null;
    Action action = null;

    BoardListAction boardlistaction = null;
    FrequentAction frequentaction = null;
    BasketInsertAction basketInsertAction = null;
    BasketAction basketaction = null;
    ProductAction productaction = null;
    ReviewModifyAction reviewmodifyaction = null;
    ReviewModifyProAction reviewmodifyproaction = null;
    HeartSelectAction heartselectaction = null;
    HeartDataAction heartdataaction = null;
    StoreCategoryDataAction storeCategoryDataAction = null;
    StoreMainAction storeMainAction = null;
    StoreCategoryShowMoreAction storeCategoryShowMoreAction = null;
    StoreCategoryDataOrderByAction storeCategoryDataOrderByAction = null;

    if (command.equals("/storeFrequent.pd")) {
      System.out.println("1. 위치: BoardFrontController 상태: storeFrequent.jsp에서 자주구매 클릭해 controller로 storeFrequent.pd 찾아옴");
      action = new FrequentAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
      forward = new ActionForward();
      forward.setPath("/storeFrequent.jsp");
    } 
    
    else if (command.equals("/storeProductDetail.pd")) {
      System.out.println("1. 위치: BoardFrontController 상태: 이미지클릭하면 제품 상세페이지로 갈거야. ");
      action = new ProductAction();
      boardlistaction = new BoardListAction();
      heartselectaction = new HeartSelectAction();
//      heartdataaction = new HeartDataAction();
      try {
        forward = action.execute(request, response);
        forward = boardlistaction.execute(request, response);
//        forward = heartdataaction.execute(request, response);
        forward = heartselectaction.execute(request, response);
      } catch (Exception e) {
        System.out.println();
      }
      forward = new ActionForward();
      forward.setPath("/storeProductDetail.jsp");
   
      
    } 
    else if (command.equals("/reviewWrite.pd")) {
      System.out.println("마이리뷰에서 리뷰쓰기div를 눌렀을 때");
      forward = new ActionForward();
      forward.setPath("/reviewWrite.jsp");
    }
    
    
    
    else if (command.equals("/reviewWritePro.pd")) {
	    System.out.println("리뷰작성 페이지에서 서브밋 눌렀을때");
	    action = new BoardWriteProAction();
	    frequentaction = new FrequentAction();
	    try {
	      forward = action.execute(request, response);
	      forward = frequentaction.execute(request, response);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    forward = new ActionForward();
	    forward.setPath("/reviewModify.jsp");
	  }

    
    
    else if (command.equals("/reviewModify.pd")) {
    	System.out.println("마이리뷰에서 리뷰수정을 눌렀을때");
   
        reviewmodifyaction = new ReviewModifyAction();
        try {
  	      forward = reviewmodifyaction.execute(request, response);
  	    } catch (Exception e) {
  	      e.printStackTrace();
  	    }
  	    forward = new ActionForward();
        forward.setPath("/reviewModify.jsp");
    }
    
    
    else if (command.equals("/reviewModifyPro.pd")) {
	    System.out.println("리뷰수정 페이지에서 서브밋 눌렀을때");
	    reviewmodifyproaction = new ReviewModifyProAction();
	    frequentaction = new FrequentAction();
	    try {
	      forward = reviewmodifyproaction.execute(request, response);
	      forward = frequentaction.execute(request, response);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    forward = new ActionForward();
	    forward.setPath("/storeFrequent.jsp");
	  }
    
    
    else if (command.equals("/storeMain.pd")) {
      System.out.println("1. 위치: BoardFrontController 상태: storeMain.jsp에서 스토어 클릭해 controller로 storeMain.pd 찾아옴");
      storeMainAction = new StoreMainAction();
        try {
        forward = storeMainAction.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    else if (command.equals("/storeBasket.pd")) {
      System.out.println("1. 위치: BoardFrontController 상태: header의 장바구니 아이콘 클릭했을때 controller로 storeBasket.pd 찾아옴");
      action = new BasketAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
      forward = new ActionForward();
      forward.setPath("/storeBasket.jsp");
    }

    else if (command.equals("/basketInsertAction.pd")) {
      // System.out.println("위치: BoardFrontController, productId: " + request.getParameter("productId"));
      System.out.println("1. 위치: BoardFrontController, 장바구니버튼 눌렀을때");
      action = new BasketInsertAction();
      productaction = new ProductAction();
      boardlistaction = new BoardListAction();

      try {
        forward = action.execute(request, response);
        forward = productaction.execute(request, response);
        forward = boardlistaction.execute(request, response);

      } catch (Exception e) {
        e.printStackTrace();
      }
      forward = new ActionForward();
      forward.setPath("/storeProductDetail.pd");
    }

    else if (command.equals("/basketDeleteAction.pd")) {
	    System.out.println("1. 위치: BoardFrontController, 장바구니 페이지에서 휴지통 아이콘 눌러서 삭제시키기 위한.");
	    action = new BasketDeleteAction();
	    basketaction = new BasketAction();
	      try {
        forward = action.execute(request, response);
	       forward = basketaction.execute(request, response);
	    } catch (Exception e) {
	       e.printStackTrace();
	    }
	    forward = new ActionForward();
	    forward.setPath("/storeBasket.jsp");
    }
    
    else if (command.equals("/heartInsert.pd")) {
    	heartdataaction = new HeartDataAction();
    	try {
    		forward = heartdataaction.execute(request, response);
    	}
    	catch (Exception e) {
   		 e.printStackTrace();
        } 
    	forward = new ActionForward();
//          forward.setPath("/");
    }

//    	Ajax사용
    else if (command.equals("/heartData.pd")) {
    	 System.out.println("1. 위치: Controller, HeartDataAction으로 갈거야. ");
    	 heartdataaction = new HeartDataAction();
    	 try {
    		 forward = heartdataaction.execute(request, response);
    	 }catch (Exception e) {
    		 e.printStackTrace();
         }
    	 forward = new ActionForward();
    	 forward.setPath("/heartData.jsp"); 
    }
    
    
    else if (command.equals("/storeCategoryData.pd")) {
    	 System.out.println("1.mainpage에서 카테고리 아이콘을 클릭했을때 ");
    	 storeCategoryDataAction = new StoreCategoryDataAction();
    	 try {
    		 forward = storeCategoryDataAction.execute(request, response);
    	 }catch (Exception e) {
    		 e.printStackTrace();
    	 }
    	 forward = new ActionForward();
    	 forward.setPath("/storeCategoryData.jsp"); 
    }
    
    else if(command.equals("/storeCategoryShowMore.pd")) {
    	System.out.println("1. mainpage에서 카테고리별 더보기 버튼을 눌렀을때");
    	storeCategoryShowMoreAction = new StoreCategoryShowMoreAction();
    	try {
    		forward = storeCategoryShowMoreAction.execute(request, response);
    	}catch (Exception e) {
    		e.printStackTrace();
    	}  	
    }
    
    else if(command.equals("/storeCategoryDataOrderBy.pd")) {
    	System.out.println("1. 카테고리별 전체페이지에서 select박스의 옵션 선택했을때");
    	storeCategoryDataOrderByAction = new StoreCategoryDataOrderByAction();
    	try {
    		forward = storeCategoryDataOrderByAction.execute(request, response);
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
 
    
    
    
    


    if (forward != null) {
      if (forward.isRedirect()) {
        response.sendRedirect(forward.getPath());
      } else {
        RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
        dispatcher.forward(request, response);
      }
    }
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doProcess(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doProcess(request, response);
  }

}
