//package controller;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import action.StoreMainSelectAction;
//
//public class StoreController extends HttpServlet{
//
//  @Override
//  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    String command = request.getParameter("command");
//    CommandInterface inter = null;
//    String viewName = "";
//    
//    try {
//      if(command.equals("storeMain")){
//        System.out.println("1. 컨트롤러, mybatis - controller - storeMain들어옴");
//        inter = StoreMainSelectAction.instance();
////        inter = StoreMainReviewSelectAction.instance();
//        viewName = inter.showData(request, response); 
//        
////        viewName = "view/"+viewName;
//        request.getRequestDispatcher(viewName).forward(request, response);
//      }
//    }catch (Exception e) {
//        System.out.println(e);
//    
//    }
//  }
//}
