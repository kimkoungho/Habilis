package com.habilis.DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

public class ReportDAO extends DAO{

	public int getReportId(){
		connectSQL();
		
		int id=1;
		try{
			String query="select max(report_id) from report";
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			
			if(rs.next())
				id=rs.getInt(1)+1;
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return id;
	}
	
	//페이지 네비 게이션 , 해당 부서의 레코드 수 
	public int getTotalRecord(Integer dept_id){
		connectSQL();
		int tot=0;
		try{
			String query="select count(*) from report where report_dept ="+dept_id;
			stmt=conn.createStatement();
			
			rs=stmt.executeQuery(query);
			if(rs.next())
				tot=rs.getInt(1);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return tot;
	}
	
	public int getNextReportId(int dept_id){
		connectSQL();
		
		int ret=1;
		
		try{
			String query="select max(report_id) from report where report_dept="+dept_id;
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			if(rs.next())
				ret=rs.getInt(1)+1;
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return ret;
	}
	
	//부서가 선택되어 있고, 각 필터를 적용할 수 있음
	//필터 : 기간별 조회, 분류별 조회, 상태별 조회, 사용자별 조회 
	public ArrayList<HashMap> getReportList(Integer dept_id,String cmd, String value, int page, int level, int user_id){
		connectSQL();
		
		ArrayList<HashMap> list=new ArrayList<HashMap>();
		try{
			
			String query="select * from report ";
			
			if(cmd.equals("term")){
				//기간은 ~ 
				String st_date=value.split("~")[0];
				String end_date=value.split("~")[1];
				query+="where report_dept ="+dept_id+" and report_date between '"+st_date+"' and '"+end_date+"' and level>="+level;
			}else if(cmd.equals("state")){
				if(value=="play")
					query+="where report_dept ="+dept_id+" and report_state like '"+value+"%'  and level>="+level;
				else
					query+="where report_dept ="+dept_id+" and report_state ='"+value+"' and level>="+level;
				
			}else if(cmd.equals("user")){
				query+="where report_dept ="+dept_id+" and report_writer ="+value+" and level>="+level;
			}else if(cmd.equals("my_payment")){
				//나의 등급이 0인 부서에서의 결제가 필요 
				//내가 사장 일 때, 팀장 일 때, 담당 일 때
				if(value.equals("0")){
					query+="where report_state<> 'finish' ";
				}else if(value.equals("1")){
					query+="where report_dept="+dept_id+" and (report_state='play1' or report_state='wait')";
				}else{
					query+="where report_writer="+user_id+" and report_state='wait' ";
				}
			}else{
				query+="where report_dept="+dept_id;
			}
			
			query+=" order by report_date desc limit "+((page-1)*20)+", "+20;
			//System.out.println(query);
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				HashMap<String, Object> report=new HashMap<String, Object>();
				for(int i=0; i<report_column.length; i++){
					if(report_column[i].contains("date"))
						report.put(report_column[i], rs.getString(i+1));
					else
						report.put(report_column[i], rs.getObject(i+1));
				}
				
				list.add(report);
			}
			
			String subQuery="select * from receipt where report_id=?";
			Iterator itr = list.iterator();
			while(itr.hasNext()){
				HashMap report=(HashMap)itr.next();
				pstmt=conn.prepareStatement(subQuery);
				pstmt.setInt(1, (Integer)report.get("report_id"));
				rs=pstmt.executeQuery();
				
				ArrayList<HashMap> receipt_list=new ArrayList<HashMap>();
				while(rs.next()){
					HashMap<String, Object> receipt=new HashMap<String, Object>();
					for(int j=0; j<receipt_column.length; j++){
						if(receipt_column[j].contains("date"))
							receipt.put(receipt_column[j], rs.getString(j+1));
						else
							receipt.put(receipt_column[j], rs.getObject(j+1));
					}
					receipt_list.add(receipt);
				}
				report.put("receipt_list", receipt_list);
				
			}
		
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}
	
	public boolean insertReport(HashMap<String, Object> report){
		connectSQL();
		int ret=0;
		try{
			String subQuery="update receipt set report_id="+report.get("report_id")+" where receipt_id=";
			String[] receipt_list=((String)report.get("receipt_list")).split("_");
			for(int i=0; i<receipt_list.length; i++){
				stmt=conn.createStatement();
				//System.out.println(subQuery+receipt_list[i]);
				stmt.executeUpdate(subQuery+receipt_list[i]);
			}
			
			String query="insert into report values(?,?,?,?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(query);
			for(int i=0; i<report_column.length; i++){
				pstmt.setObject(i+1, report.get(report_column[i]));
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
	
	public boolean modifyReport(int report_id, String report_state, String report_delay){
		connectSQL();
		
		int ret=0;
		try{
			String query="update report set report_state=?, report_delay=? where report_id=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, report_state);
			pstmt.setString(2, report_delay);
			pstmt.setInt(3, report_id);
			
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
	
	public boolean delReport(ArrayList<Integer> report_id){
		connectSQL();
		
		int ret=0;
		try{
			String query="delete from report where report_id=";
			for(int i=0; i<report_id.size(); i++){
				stmt=conn.createStatement();
				ret=stmt.executeUpdate(query+report_id.get(i));
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
}