package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.Action;
import action.FundingDetailAction;
import action.FundingOrderAction;
import action.FundingReplyAction;
import action.FundingWriteProAction;
import action.FundingheartstoggleAction;
import action.InquiryListAction;
import dto.ActionForward;
import lhj.funding.*;
import lhj.inquiry.*;
import lhj.members.*;
import lhj.periodproduct.*;

@SuppressWarnings("serial")
public class FundingController extends javax.servlet.http.HttpServlet {
  protected void doProcess(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    String RequestURI = request.getRequestURI();
    String contextPath = request.getContextPath();
    String command = RequestURI.substring(contextPath.length());
    ActionForward forward = null;
    Action action = null;
    
    if (command.equals("/fundingMain.fd")) {
      action = new MainPage();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/fundingList.fd")) {
      action = new SelectList();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/fundingWriteForm.fd")) {
      forward = new ActionForward();
      forward.setPath("/fundingWrite.jsp");
    } else if (command.equals("/fundingWritePro.fd")) {
      action = new FundingWriteProAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/fundingDetail.fd")) {
      action = new FundingDetailAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/fundingOrder.fd")) {
      action = new FundingOrderAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/fundingheartstoggle.fd")) {
      action = new FundingheartstoggleAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/fundingReplyWrite.fd")) {
      action = new FundingReplyAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/inquiryList.fd")) {
      action = new InquiryListAction();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/inquiryWriteFrom.fd")) {
      forward = new ActionForward();
      forward.setPath("/fInquiryWrite.jsp");
    } else if (command.equals("/inquiryWrite.fd")) {
      action = new Insert();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/inquiryUpdatePro.fd")) {
      action = new UpdatePro();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/inquiryUpdate.fd")) {
      action = new Update();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/inquiryDelete.fd")) {
      action = new Delete();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/editPushFrom.fd")) {
      action = new SelectById();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/pushToggle.fd")) {
      action = new PushToggle();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/priceComparison.fd")) {
      forward = new ActionForward();
      forward.setPath("/priceComparison.jsp");
    } else if (command.equals("/selectItemCodeList.fd")) {
      action = new SelectItemCodeList();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else if (command.equals("/selectPeriodproduct.fd")) {
      action = new SelectPeriodproduct();
      try {
        forward = action.execute(request, response);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    
    else {
      forward = new ActionForward();
      forward.setPath("/fAlert.jsp");
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
