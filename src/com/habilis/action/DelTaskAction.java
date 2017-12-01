package com.habilis.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.TaskDAO;
import java.util.ArrayList;

public class DelTaskAction implements Action
{

   @Override
   public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      request.setCharacterEncoding("utf-8");
      
      TaskDAO task_dao=new TaskDAO();
      
      ActionForward forward=new ActionForward();
      
      HttpSession session=request.getSession();
      boolean result=false;
      
      try
      {         
         int task_id = Integer.parseInt(request.getParameter("task_id"));   
         result=task_dao.delTask(task_id);      
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      
      if(!result)
      {
         System.out.println("delete 실패");
         return null;
      }
      else
      {
         //forward.setRedirect(true);
         //forward.setPath("jsp/CardManage.jsp");
         
         CardListAction action=new CardListAction();
         
         return action.executeAction(request, response);
      }
   }
   
   
}