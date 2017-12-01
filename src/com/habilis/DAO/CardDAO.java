package com.habilis.DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;


public class CardDAO extends DAO{
	
	//카드 등록
	public boolean insertCard(HashMap<String, Object> card){
		connectSQL();
		
		int ret=0;
		try{
			String query="insert into card values(?,?,?,?,?,?,?)";
			
			pstmt=conn.prepareStatement(query);
			
			for(int i=0; i<card_column.length; i++){
				pstmt.setObject(i+1, card.get(card_column[i]));
			}
			
			System.out.println("성공");
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
	
	//카드 조회
	public ArrayList<HashMap> getCardList(Integer user_id)
	{
		connectSQL();
		
		ArrayList<HashMap> list=new ArrayList<HashMap>();
		
		try{
			String query="select * from card where card_user="+user_id;
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery(query);
			
			while(rs.next()){
				HashMap<String, Object> card=new HashMap<String, Object>();
				for(int i=0; i<card_column.length; i++){
					card.put(card_column[i], rs.getObject(i+1));
				}
				
				list.add(card);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeSQL();
		}
		
		return list;
	}
	
	
	//카드 제거
	public  boolean delCard(String card_num, String card_corpor, int card_user){
		connectSQL();
		
		int ret=0;
		
		try{
			String query="delete from card where card_num='"+card_num+"' and card_corpor='"+card_corpor+"'"
					+" and card_user="+card_user;
			
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
}
