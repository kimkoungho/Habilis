package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.CardDAO;

public class InsertCardAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		
		
		CardDAO card_dao=new CardDAO();
		
		ActionForward forward=new ActionForward();
		
		boolean result=false;
		
		try{
			String card_num=request.getParameter("card_num1")+" - "+request.getParameter("card_num2")+" - "+request.getParameter("card_num3")+" - "+request.getParameter("card_num4");
			System.out.println(card_num);
			String card_type=request.getParameter("card_type");
			
			String card_expired=request.getParameter("card_year")+"/"+request.getParameter("card_month");
			Integer cvc=Integer.parseInt(request.getParameter("cvc"));
			
			HttpSession session=request.getSession(); 
			//별도의 처리가 필요함
			Integer card_user=(Integer)session.getAttribute("user_id");//세션
			String card_img="/IMAGES/card1.gif";//이미지 매칭 
			
			String card_corpor=request.getParameter("card_corpor");
			
			HashMap<String, Object> card=new HashMap<String, Object>();
			card.put("card_num", card_num);
			card.put("card_type", card_type);
			card.put("card_expired", card_expired);
			card.put("cvc", cvc);
			card.put("card_user", card_user);
			card.put("card_img", card_img);
			card.put("card_corpor", card_corpor);
			
			result=card_dao.insertCard(card);
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(!result){
			System.out.println("카드 insert 실패");
			return null;
		}else{
			
			CardListAction action=new CardListAction();
			
			return action.executeAction(request, response);
		}
	}

}
