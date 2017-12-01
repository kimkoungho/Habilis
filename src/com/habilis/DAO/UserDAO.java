package com.habilis.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class UserDAO extends DAO{
	
	//id 값 
	public int getUserId(){
		connectSQL();
		
		int ret=0;
		try{
			String query="select max(user_id) from user";
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			
			rs.next();
			ret=rs.getInt(1)+1;
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return ret;
	}
	
	//회원 가입
	public boolean join(HashMap<String, Object> user){
		connectSQL();

		int ret=0;
		try{
			String query="insert into user values(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt=conn.prepareStatement(query);
			for(int i=0; i<user_column.length; i++){
				pstmt.setObject(i+1, user.get(user_column[i]));
			}
			
			ret=pstmt.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		if(ret==0)
			return false;
		else 
			return true;
	}
	
	//아이디 중복검사
	public boolean idCheck(String mail){
		connectSQL();
		int ret=0;
		try{
			String query="select count(*) from user where user_mail='"+mail+"'";
			
			//System.out.println(query);
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			
			rs.next();
			ret=rs.getInt(1);
			//System.out.println(ret);
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		if(ret==0)
			return true;
		else 
			return false;
	}
	
	//로그인
	public int login(String user_mail, String password){
		connectSQL();
		
		int ret=-1;
		try{
			String query="select user_id from user where user_mail=? and password=?";
			
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, user_mail);
			pstmt.setString(2, password);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
				ret=rs.getInt(1);
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return ret;
	}
	
	// 회원 정보 조회
	public HashMap<String, Object> getUserInfo(int user_id){
		connectSQL();
		
		HashMap<String, Object> user=new HashMap<String, Object>();
		try{
			String query="select * from user where user_id="+user_id;
			
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery(query);
			
			rs.next();
			for(int i=0; i<user_column.length; i++)
			{
				user.put(user_column[i], rs.getObject(i+1));
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return user;
	}
	//회원 회사 변경
	public boolean updateDept(int user_id, int u_dept, int u_priv, int company){
		connectSQL();
		
		int ret=0;
		try{
			String subquery="select user_dept, user_priv, user_company from user where user_id="+user_id;
			stmt=conn.createStatement();
			rs=stmt.executeQuery(subquery);
			
			if(rs.next()){
				String user_dept=rs.getString(1);
				String user_priv=rs.getString(2);
				String user_com=rs.getString(3);
				
				
				
				
				if(company==-1){
					if(user_dept.charAt(0)==','){
						user_dept=user_dept.substring(1);
						user_priv=user_priv.substring(1);
					}
					user_dept+=u_dept+",";
					user_priv+=u_priv+",";
				}else{
					if(user_com.charAt(0)==',')
						user_com=user_com.substring(1);
					user_com+=company+",";
				}
				
				String query="update user set user_dept=?, user_priv=?, user_company=? where user_id="+user_id;
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, user_dept);
				pstmt.setString(2, user_priv);
				pstmt.setString(3, user_com);
				
				//System.out.println(query);
				ret=pstmt.executeUpdate();
				//System.out.println(ret);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		if(ret==0)
			return false;
		else
			return true;
	}
	public boolean updateUser(HashMap<String, Object> user){
		connectSQL();
		int ret=0;
		try{
			String query="update user set user_name=?, user_position=?, user_tel=?, user_phone=?, user_img=? "
					+"where user_id="+user.get("user_id");
			pstmt=conn.prepareStatement(query);
			pstmt.setObject(1, user.get("user_name"));
			pstmt.setObject(2, user.get("user_position"));
			pstmt.setObject(3, user.get("user_tel"));
			pstmt.setObject(4, user.get("user_phone"));
			pstmt.setObject(5, user.get("user_img"));
			
			ret=pstmt.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		if(ret==0)
			return false;
		else
			return true;
	}
	//탈퇴
	public boolean withdraw(String user_mail){
		connectSQL();
		
		int ret=0;
		try{
			String query="delete from user where user_mail="+user_mail;
			
			stmt=conn.createStatement();
			
			ret=stmt.executeUpdate(query);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		if(ret==0)
			return false;
		else
			return true;
	}
	
	// 같은 부서의 회원들 조회
	
	//id 추출
	public Integer getId(String user_mail){
		connectSQL();
		
		int u_id=-1;
		try{
			String query="select user_id from user where user_mail=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, user_mail);
			
			rs=pstmt.executeQuery();
			if(rs.next())
				u_id=rs.getInt(1);
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return u_id;
	}
}
