package com.habilis.action;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.habilis.DAO.TaskDAO;

public class ModifyTaskAction implements Action
{

   @Override
   public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
      request.setCharacterEncoding("utf-8");
      
      ActionForward forward=new ActionForward();
      
      String cmd=request.getParameter("cmd");
      if(cmd==null)
         cmd="";
      String value=request.getParameter("value");
      if(value==null)
         value="";
      
      int dept_id=Integer.parseInt(request.getParameter("dept_id"));
//      int page=Integer.parseInt(request.getParameter("page"));
      
      boolean result=false;
      try
      {
         TaskDAO task_dao=new TaskDAO();
         
         int task_id=Integer.parseInt(request.getParameter("task_id"));
         String task_title = request.getParameter("task_title");
         String task_content=request.getParameter("task_content");
         String task_state=request.getParameter("task_state");
         String task_date=request.getParameter("task_date");
         int task_rank=Integer.parseInt(request.getParameter("task_rank"));
         String task_color=request.getParameter("color");
         result = task_dao.modifyTask(task_id, task_title, task_content, task_state, task_rank, task_color,task_date);
         
         
      }catch(Exception e)
      {
         e.printStackTrace();
      }
      
      if(result==false)
      {
         System.out.println("modify 실패");
         return null;
      }
      else
      {
         TaskListAction action=new TaskListAction();
         return action.executeAction(request, response);
      }
   }

}