package com.habilis.DAO;

import java.sql.*;

public class DAO {
	protected String []card_column=new String[]{
			"card_num", "card_type", "card_expired", "cvc", "card_user", "card_img", "card_corpor"
	};
	protected String []dept_column=new String[]{
			"dept_id", "dept_name", "dept_info", "dept_header", "dept_grp"
	};
	protected String []receipt_column=new String[]{
			"receipt_id", "receipt_type", "receipt_date", "receipt_cost", "receipt_state", "receipt_img", "receipt_writer", "receipt_use", "receipt_write_date", "level", "comment", "payment", "receipt_dept", "report_id", "dept_seq"
	};
	protected String []chat_column=new String[]{
			"dept_id", "user_name", "user_img", "content", "chat_date"
	};
	protected String []report_column=new String[]{
			"report_id", "report_title", "level", "report_date", "report_state", "report_writer", "report_dept", "report_delay", "dept_sequence" 
	};
	protected String []task_column=new String[]{
	         "task_id", "task_title", "task_content", "task_writer", "task_state",  "task_date", "task_dept", "level","dept_seq","task_color","writer_name"
	   };
	protected String []user_column=new String[]{
			"user_id", "password", "user_name", "user_img", "user_mail", "user_phone", "user_tel", "user_position", "user_dept", "user_priv","user_company"
	};
	
	protected Connection conn=null;
	protected Statement stmt=null;
	protected PreparedStatement pstmt=null;
	protected ResultSet rs=null;
	
	protected void connectSQL(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/habilis", "hauser", "hapass");
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	protected void closeSQL(){
		try{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
}
