package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.habilis.DAO.TaskDAO;
import com.habilis.DAO.UserDAO;

public class TaskListAction implements Action{

   @Override
   public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {

      request.setCharacterEncoding("utf-8");
      
      String cmd=request.getParameter("cmd");
      if(cmd==null)
         cmd="";
      String value=request.getParameter("value");
      if(value==null)
         value="";
      
      int dept_id= Integer.parseInt(request.getParameter("dept_id"));
      
      
      TaskDAO task_dao=new TaskDAO();
      
//      int total=task_dao.getTaskId();
      ArrayList<HashMap> list=task_dao.getTaskList(dept_id,cmd,value);//
      
      UserDAO user_dao=new UserDAO();
      ArrayList<String> user_names=new ArrayList<String>();
      
      for(int i=0; i<list.size(); i++)
      {
         HashMap<String, Object> user=user_dao.getUserInfo((Integer)list.get(i).get("task_writer"));
         user_names.add((String)user.get("user_name"));      
      }
      
      ActionForward forward=new ActionForward();
      
      
      request.setAttribute("task_list", list);
      request.setAttribute("user_names", user_names);
      
      forward.setRedirect(false);
      forward.setPath("jsp/TaskManage.jsp");
      
      return forward;
   }
}