package com.habilis.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.ReceiptDAO;

public class DelReceiptAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		ReceiptDAO receipt_dao=new ReceiptDAO();
		ActionForward forward=new ActionForward();
		
		boolean result=false;
		
		try{
			String id_list=request.getParameter("receipt_id");
			
			String []id=id_list.split(",");
			ArrayList<Integer> receipt_id=new ArrayList<Integer>();
			for(int i=0; i<id.length; i++){
				receipt_id.add(Integer.parseInt(id[i]));
			}
			System.out.println(receipt_id);
			result=receipt_dao.delReceipt(receipt_id);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(!result){
			System.out.println("영수증 delete 실패");
			return null;
		}else{
			
			ReceiptListAction action=new ReceiptListAction();
			
			return action.executeAction(request, response);
		}
		
	}
}
