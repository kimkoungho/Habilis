package com.habilis.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.CardDAO;
import java.util.ArrayList;

public class DelCardAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		CardDAO card_dao=new CardDAO();
		
		ActionForward forward=new ActionForward();
		
		HttpSession session=request.getSession();
		boolean result=false;
		
		try{
			String card_num=request.getParameter("card_num");
			String card_corpor=request.getParameter("card_corpor");
			
			result=card_dao.delCard(card_num, card_corpor, (Integer)session.getAttribute("user_id"));
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(!result){
			System.out.println("카드 delete 실패");
			return null;
		}else{
			//forward.setRedirect(true);
			//forward.setPath("jsp/CardManage.jsp");
			
			CardListAction action=new CardListAction();
			
			return action.executeAction(request, response);
		}
	}
	
	
}
