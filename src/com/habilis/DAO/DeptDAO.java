package com.habilis.DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public class DeptDAO extends DAO{
	
	//id 값 
	public int getDeptId(){
		connectSQL();
		
		int ret=0;
		try{
			String query="select max(dept_id) from dept";
			
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
	public int getCompanyId(int dept_id){
		connectSQL();
		
		int com_id=-1;
		try{
			String query="select dept_grp from dept where dept_id="+dept_id;
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			if(rs.next())
				com_id=rs.getInt(1);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return com_id;
	}
	//부서 등록
	public boolean insertDept(HashMap<String, Object> dept){
		connectSQL();
		
		int ret=0;
		try{
			String query="insert into dept values(?,?,?,?,?)";
			
			pstmt=conn.prepareStatement(query);
			for(int i=0; i<dept_column.length; i++){
				pstmt.setObject(i+1, dept.get(dept_column[i]));
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
	
	//사용자의 부서 리스트( 부서 정보 + 부서의 사용자 정보 ) 조회 
	//맨 처음 부서가 기본 부서
	//각 회사별로 모든 부서 조회
	public ArrayList<HashMap> getUserDeptList(int user_id, String user_dept){
		connectSQL();
		
		String []dept_id=user_dept.split(",");
		ArrayList<HashMap> list=new ArrayList<HashMap>();
		
		try{
			for(int i=0; i<dept_id.length; i++){
				String query="select * from dept where dept_id="+dept_id[i];
				stmt=conn.createStatement();
				
				rs=stmt.executeQuery(query);
				
				
				HashMap<String, Object> dept=new HashMap<String, Object>();
				if(rs.next()){
					for(int j=0; j<dept_column.length; j++){
						dept.put(dept_column[j], rs.getObject(j+1));
					}
				}
				
				ArrayList<HashMap<String, Object>> user_list=new ArrayList<HashMap<String, Object>>();
				query="select * from user where user_dept like '%"+dept_id[i]+"%' and user_id<>"+user_id;
				pstmt=conn.prepareStatement(query);
				rs=pstmt.executeQuery();
				while(rs.next()){
					HashMap<String, Object> user=new HashMap<String, Object>();
					for(int j=0; j<user_column.length; j++){
						user.put(user_column[j], rs.getObject(j+1));
					}
					user_list.add(user);
				}
				
				HashMap<String, Object> hash=new HashMap<String, Object>();
				hash.put("dept", dept);
				hash.put("user_list", user_list);
				
				list.add(hash);
			}
			System.out.println(list);
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}
	public HashMap<String, Object> getCompanyInfo(int dept_id){
		connectSQL();
		
		HashMap<String, Object> dept=new HashMap<String, Object>();
		try{
			String query="select * from dept where dept_id="+dept_id+" and dept_id=dept_grp";
			stmt=conn.createStatement();
			
			rs=stmt.executeQuery(query);
			rs.next();
			for(int i=0; i<dept_column.length; i++){
				dept.put(dept_column[i], rs.getObject(dept_column[i]));
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return dept;
	}
	//부서 상세 조회
	public ArrayList<HashMap<String, Object>> getDeptInfo(int dept_id){
		connectSQL();
		
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>();
		try{//팀 이름, 팀원 들의 이름, 직급, 포지션 
			//사장, 부사장 
			//나머지 팀원
			String query="select user_id, user_name, user_position, user_dept, user_priv, dept_name, dept_id from user, dept";
			query+=" where dept_id="+dept_id+" and user_dept like '%"+dept_id+"%' order by binary(user_priv)";
			
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				HashMap<String, Object> hash=new HashMap<String, Object>();
				hash.put("user_id", rs.getInt(1));
				hash.put("user_name", rs.getString(2));
				hash.put("user_position",rs.getString(3));
				
				String []dept=rs.getString(4).split(",");
				String []priv=rs.getString(5).split(",");
				String u_priv="",u_dept="";
				for(int i=0; i<dept.length; i++){
					if(dept[i].equals(Integer.toString(dept_id))){
						u_priv=priv[i];
						u_dept=dept[i];
					}
				}
				
				hash.put("user_dept",u_dept);
				hash.put("user_priv",u_priv);
				hash.put("dept_name", rs.getString(6));
				hash.put("dept_id", rs.getInt(7));
				list.add(hash);
			}
			
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}
	
	//부서 정보 변경
	
	
	//부서 삭제
	public boolean delDept(int dept_id){
		connectSQL();
		
		int ret=0;
		try{
			String query="delete from dept where dept_id=?";
			
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, dept_id);
			
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

	public ArrayList isBoss(int user_id, String company_list){
		connectSQL();
		
		ArrayList<Boolean> list=new ArrayList<Boolean>();
		try{
			String com_list[]=company_list.split(",");
			for(int i=0; i<com_list.length; i++){
				String query="select count(*) from dept where dept_header="+user_id+" and dept_id="+com_list[i];
				stmt=conn.createStatement();
				rs=stmt.executeQuery(query);
				
				int ret=0;
				if(rs.next())
					ret=rs.getInt(1);
				
				if(ret==0) list.add(false);
				else list.add(true);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return list;
	}
}