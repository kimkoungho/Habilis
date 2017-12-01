package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.TaskDAO;

public class InsertTaskAction implements Action
{

   @Override
   public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception
   {
      request.setCharacterEncoding("utf-8");
      
      
      TaskDAO task_dao=new TaskDAO();
      
      ActionForward forward=new ActionForward();
      
      String user_dept = request.getParameter("dept_id");
      String value=request.getParameter("value");
      
      String cmd=request.getParameter("cmd");
      
      if(cmd==null)cmd="";
      
      if(value == null)
      {
         value="";
      }
      int user_id = 1;
         
      boolean result=false;
      
      try
      {
         String task_title = request.getParameter("task_title");         
         String task_date = request.getParameter("task_date");         
         String task_rank = request.getParameter("task_rank");
         String task_state = request.getParameter("task_state");
         String task_writer = request.getParameter("task_manager");
         String task_content = request.getParameter("task_content");
         String task_color = request.getParameter("color");
         String writer_name = request.getParameter("task_manager");
         HttpSession session=request.getSession(); 
         
         //별도의 처리가 필요함
         
         HashMap<String, Object> task=new HashMap<String, Object>();
         //제목
         //task.put("task_id", 401);
         task.put("task_title", task_title);
         //내용
         task.put("task_content", task_content);
         //글쓴이 아이디
         task.put("task_writer",user_id);
         //진행 상태
         task.put("task_state", task_state);
         task.put("task_date", task_date);
         //글쓴이 부서
         task.put("task_dept",user_dept);
         //글등급
         task.put("level", task_rank);
         task.put("dept_seq", 1);
         task.put("task_color", task_color);
         task.put("writer_name", writer_name);
//         System.out.println(task_color);
         result=task_dao.insertWork(task);                  
      }
      catch(Exception e)
      {
         e.printStackTrace();
      }
      
      if(!result)
      {
         System.out.println("업무 insert 실패");
         return null;
      }
      else
      {      
         TaskListAction action=new TaskListAction();
         return action.executeAction(request, response);
      }
   }

}