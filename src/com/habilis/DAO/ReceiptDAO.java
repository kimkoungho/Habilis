package com.habilis.DAO;

import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;

public class ReceiptDAO extends DAO{

	public int getReceiptId(){
		connectSQL();
		
		int id=1;
		try{
			String query="select max(receipt_id) from receipt";
			
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
	//페이지 네비 게이션 
	public int getTotalRecord(Integer dept_id){
		connectSQL();
		int tot=0;
		try{
			String query="select count(*) from receipt where receipt_dept like '"+dept_id+"%'";
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
	public ArrayList<HashMap> getReportReceipt(int report_id){
		connectSQL();
		
		ArrayList<HashMap> list=new ArrayList<HashMap>();
		try{
			String query="select * from receipt where report_id="+report_id;
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			while(rs.next()){
				
				HashMap<String, Object> receipt=new HashMap<String, Object>();
				for(int i=0; i<receipt_column.length; i++){
					if(receipt_column[i].contains("date"))
						receipt.put(receipt_column[i], rs.getString(i+1));
					else
						receipt.put(receipt_column[i], rs.getObject(i+1));
				}
				
				list.add(receipt);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return list;
	}
	public int getNextReceiptId(int dept_id){
		connectSQL();
		
		int ret=1;
		
		try{
			String query="select max(receipt_id) from receipt where receipt_dept="+dept_id;
			
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
	//영수증 읽기 권한이 있는 리스트 출력
	//필터 : 기간별 조회, 분류별 조회, 상태별 조회, 사용자별 조회 
	public ArrayList<HashMap> getReceiptList(Integer dept_id, String cmd, String value, int page, int level){
		connectSQL();
		
		ArrayList<HashMap> list=new ArrayList<HashMap>();
		try{
			
			String query="select * from receipt where receipt_dept ="+dept_id;
			if(cmd.equals("term")){
				//기간은 ~ 
				String st_date=value.split("~")[0];
				String end_date=value.split("~")[1];
				query+=" and receipt_date between '"+st_date+"' and '"+end_date+"'";
			}else if(cmd.equals("type")){
				query+=" and receipt_type='"+value+"'";
			}else if(cmd.equals("state")){
				if(value=="play")
					query+=" and receipt_state like '"+value+"%'";
				else
					query+=" and receipt_state ='"+value+"'";
			}else if(cmd.equals("user")){
				query+=" and receipt_writer ="+value;
			}
			query+=" and level>="+level+" order by receipt_write_date desc limit "+((page-1)*20)+", "+20;
			
			//System.out.println(query);
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				
				HashMap<String, Object> receipt=new HashMap<String, Object>();
				for(int i=0; i<receipt_column.length; i++){
					if(receipt_column[i].contains("date"))
						receipt.put(receipt_column[i], rs.getString(i+1));
					else
						receipt.put(receipt_column[i], rs.getObject(i+1));
				}
				
				list.add(receipt);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}
	
	//영수증 세부 내용
	
	
	//영수증 작성
	public boolean insertReceipt(HashMap<String, Object> receipt){
		connectSQL();
		
		int ret=0;
		try{
			String query="insert into receipt values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt=conn.prepareStatement(query);
			for(int i=0; i<receipt_column.length; i++){
				pstmt.setObject(i+1, receipt.get(receipt_column[i]));
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
	
	//영수증 수정
	public boolean modifyReceipt(HashMap<String, Object> receipt){
		connectSQL();
		int ret=0;
		
		try{
			String query="update receipt set receipt_type=?, receipt_date=?, receipt_cost=?, receipt_state=?, receipt_writer=?, "
						+"receipt_use=?, receipt_write_date=?, level=?, comment=?, payment=?, receipt_dept=?, report_id=? where receipt_id=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, (String)receipt.get("receipt_type"));
			pstmt.setString(2, (String)receipt.get("receipt_date"));
			pstmt.setInt(3, (Integer)receipt.get("receipt_cost"));
			pstmt.setString(4, (String)receipt.get("receipt_state"));
			pstmt.setInt(5, (Integer)receipt.get("receipt_writer"));
			pstmt.setString(6, (String)receipt.get("receipt_use"));
			pstmt.setString(7, (String)receipt.get("receipt_write_date"));
			pstmt.setInt(8, (Integer)receipt.get("level"));
			pstmt.setString(9, (String)receipt.get("comment"));
			pstmt.setString(10, (String)receipt.get("payment"));
			pstmt.setInt(11, (Integer)receipt.get("receipt_dept"));
			pstmt.setInt(12, (Integer)receipt.get("report_id"));
			pstmt.setInt(13, (Integer)receipt.get("receipt_id"));
			
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
	
	//영수증 삭제
	public boolean delReceipt(ArrayList<Integer> receipt_id){
		connectSQL();
		
		int ret=0;
		
		try{
			for(int i=0; i<receipt_id.size(); i++){
				String prevQuery="select receipt_img from receipt where receipt_id="+receipt_id.get(i);
				stmt=conn.createStatement();
				rs=stmt.executeQuery(prevQuery);
				if(rs.next()){
					String filename=rs.getString(1);
					File prevFile=new File(filename);
					prevFile.delete();
				}
				
				String query="delete from receipt where receipt_id=?";
				
				pstmt=conn.prepareStatement(query);
				pstmt.setInt(1, receipt_id.get(i));
				
				ret=pstmt.executeUpdate();
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
	
	public HashMap<String, Object> getHeaderChart(int dept_id, String cmd, String value){
		connectSQL();
		
		HashMap<String, Object> head=new HashMap<String, Object>();
		try{
			String query="select sum(receipt_cost), max(receipt_cost), avg(receipt_cost) from receipt where receipt_dept="+dept_id;
			
			if(cmd.equals("term")){
				String st_date=value.split("~")[0];
				String end_date=value.split("~")[1];
				query+=" and receipt_date between '"+st_date+"' and '"+end_date+"'";
			}else if(cmd.equals("user")){
				query+=" and receipt_writer ="+value;
			}else{
				query+=" and  receipt_date between date_add(now(), interval-1 month) and now()";
			}
			//System.out.println(query);
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			
			rs.next();
			head.put("total",rs.getInt(1));
			head.put("max",rs.getInt(2));
			head.put("avg",rs.getInt(3));
				
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		return head;
	}
	
	//차트 데이터 
	// 지정된 날짜의 총합계, 최대, 평균 + 결제 별 , 분류 별 + 지출 비교 (기간 - 전 기간)
	public ArrayList<HashMap<String, Object>> getListChart(int dept_id, String cmd, String value){
		connectSQL();
		
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>();
		try{
			String query="select receipt_type, payment, sum(receipt_cost) from receipt where receipt_dept="+dept_id;
			
			//기본이 한 달간의 날짜가 필요함
			if(cmd.equals("term")){
				String st_date=value.split("~")[0];
				String end_date=value.split("~")[1];
				query+=" and receipt_date between '"+st_date+"' and '"+end_date+"'";
			}else if(cmd.equals("user")){
				query+=" and receipt_writer ="+value;
			}else{
				query+=" and  receipt_date between date_add(now(), interval-1 month) and now()";
			}
			query+=" group by receipt_type, payment";
			
			//System.out.println(query);
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			

			String types[]=new String[]{
				"교통", "기타", "비품", "소모품", "식비"
			};
			for(int i=0; i<10; i++){
				HashMap<String, Object> hash=new HashMap<String, Object>();
				if(i%2==0){
					hash.put("receipt_type", types[i/2]);
					hash.put("payment", "cor");
				}else{
					hash.put("receipt_type", types[i/2]);
					hash.put("payment", "per");
				}
				hash.put("sum", 0);
				list.add(hash);
			}
			while(rs.next()){
				String type=rs.getString(1);
				String payment=rs.getString(2);
				for(int i=0; i<list.size(); i++){
					String l_type=(String)list.get(i).get("receipt_type");
					String l_payment=(String)list.get(i).get("payment");
					if(type.equals(l_type) && payment.trim().equals(l_payment)){
						list.get(i).put("sum", rs.getInt(3));
						break;
					}
				}
			}
			
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}

	//특정 기간의 날짜와 총 합을 구하는 함수
	public ArrayList<HashMap<String, Object>> getFooterChart(int dept_id, String cmd, String value, boolean flag){
		connectSQL();
		
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>(); 
		String s_date="", e_date="";
		HashMap<String, Object> start=new HashMap<String, Object>();
		HashMap<String, Object> end=new HashMap<String, Object>();
		try{
			String query="";
			if(flag) query="select sum(receipt_cost), date_format(receipt_date, '%Y-%m-%d') df from receipt where receipt_dept="+dept_id;
			else query="select sum(receipt_cost), date_format(date_add(receipt_date, interval+1 month), '%Y-%m-%d') df from receipt where receipt_dept="+dept_id;
			
			String st_date=null;
			String end_date=null;
			if(cmd.equals("term")){
				st_date=value.split("~")[0];
				end_date=value.split("~")[1];
				
				int prev_m=Integer.parseInt(st_date.split("-")[1]);
				if(prev_m==1) prev_m=12;
				else prev_m--;
				String prev_sdate=st_date.split("-")[0]+"-"+prev_m+"-"+st_date.split("-")[2];
				
				int prev_mm=Integer.parseInt(end_date.split("-")[1]);
				if(prev_m==1) prev_mm=12;
				else prev_mm--;
				String prev_edate=end_date.split("-")[0]+"-"+String.format("%02d", prev_mm)+"-"+end_date.split("-")[2];
				
				if(flag){
					query+=" and receipt_date between '"+st_date+"' and '"+end_date+"'";
					s_date=st_date;
					e_date=end_date;
				}else{
					query+=" and receipt_date between '"+prev_sdate+"' and '"+prev_edate+"'";
				}
				//subquery+=" and receipt_date between "+st_date+" and "+end_date;
			}else{
				if(cmd.equals("user")){
					query+=" and receipt_writer ="+value;
				}
				if(flag){
					query+=" and  receipt_date between date_add(now(), interval-1 month) and now()";
					
					Date now=new Date();
					SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
					
					Calendar cal = new GregorianCalendar(Locale.KOREA);
					cal.setTime(now);
					cal.add(Calendar.MONTH, -1);
					
					s_date=formatter.format(cal.getTime());
					e_date=formatter.format(now);
				}else{
					query+=" and  receipt_date between date_add(now(), interval-2 month) and date_add(now(), interval-1 month)";
				}
			}
			query+=" group by df order by receipt_date";
			
			System.out.println(query);
			pstmt=conn.prepareStatement(query);
			rs=pstmt.executeQuery();
			
			
			while(rs.next()){
				HashMap<String, Object> hash=new HashMap<String, Object>();
				hash.put("sum", rs.getInt(1));
				
				String date=rs.getString(2);
				hash.put("receipt_date",date);
				
				list.add(hash);
			}
			
			start.put("sum", 0);
			start.put("receipt_date", s_date);
			end.put("sum", 0);
			end.put("receipt_date", e_date);
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}
}
