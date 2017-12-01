package com.habilis.DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class TaskDAO extends DAO
{

   public String getTaskId()
   {
      connectSQL();
      
      String id="";
      try
      {
         String query="select max(task_id) from task";
         
         stmt=conn.createStatement();
         rs=stmt.executeQuery(query);
         
         int r_id=1;
         if(rs.next())
            r_id=rs.getInt(1)+1;

         id=String.format("%010d", r_id);
         
      }
      catch(SQLException e)
      {
         e.printStackTrace();
      }
      finally
      {
         closeSQL();
      }
      
      return id;
   }   
   public ArrayList<HashMap> getTaskList(Integer dept_id, String cmd, String value)
   {
      connectSQL();
      
      ArrayList<HashMap> list=new ArrayList<HashMap>();
      try
      {
         String query="";
         if(cmd.equals("state"))
         {
            query="select * from task where task_dept like '"+dept_id+"%' and task_state ='"+value+"'";
         }
         else if(cmd.equals("user"))
         {         
            query="select * from task where task_dept like '"+dept_id+"%' and task_writer ='"+value+"'";      
         }
         else
         {
            query="select * from task where task_dept like '"+dept_id+"%'";
//            query ="select * from task as A inner join user as b on '"+
         }
         
         pstmt=conn.prepareStatement(query);
         rs=pstmt.executeQuery();
         
         while(rs.next())
         {         
            HashMap<String, Object> task=new HashMap<String, Object>();
            for(int i=0; i<task_column.length; i++)
            {
               if(task_column[i].contains("date"))
                  task.put(task_column[i], rs.getString(i+1));
               else
                  task.put(task_column[i], rs.getObject(i+1));
            }
            list.add(task);
         }
         
      }
      catch(SQLException e)
      {
         e.printStackTrace();
      }
      finally
      {
         closeSQL();
      }
      
      return list;
   }
   

   public boolean insertWork(HashMap<String, Object> work)
   {
      connectSQL();
      
      int ret=0;
      try
      {
         String query="insert into task values(?,?,?,?,?,?,?,?,?,?,?)";         
         
         pstmt=conn.prepareStatement(query);         
         
         for(int i=0; i<task_column.length; i++)
         {
            pstmt.setObject(i+1, work.get(task_column[i]));
         }
         
         ret=pstmt.executeUpdate();
      }
      catch(SQLException e)
      {
         e.printStackTrace();
      }
      finally
      {
         closeSQL();
      }
      if(ret==0)
         return false;
      else 
         return true;
   }
   
   public boolean modifyTask(int task_id, String task_title, String task_content, String task_state, int task_rank, String task_color, String task_date)
   {
      connectSQL();
      
      int ret=0;
      try
      {
         String query="update task set task_title=?, task_content=?, task_state=?, task_date=?, level=?, task_color=?  where task_id=?";
         pstmt=conn.prepareStatement(query);
         
         pstmt.setString(1, task_title);
         pstmt.setString(2, task_content);
         pstmt.setString(3,task_state);
         pstmt.setString(4,task_date);
         pstmt.setInt(5, task_rank);
         pstmt.setString(6, task_color);
         pstmt.setInt(7, task_id);
         
         ret=pstmt.executeUpdate();
      }
      catch(SQLException e)
      {
         e.printStackTrace();
      }
      finally
      {
         closeSQL();
      }
      if(ret==0)
         return false;
      else
         return true;
   }
   
   public  boolean delTask(int task_id)
   {
      connectSQL();
      
      int ret=0;
      
      try{
         String query="delete from task where task_id="+task_id;
         
         stmt=conn.createStatement();
         ret=stmt.executeUpdate(query);
         
      }
      catch(SQLException e)
      {
         e.printStackTrace();
      }
      finally
      {
         closeSQL();
      }

      if(ret==0)
         return false;
      else 
         return true;
   }
   
}