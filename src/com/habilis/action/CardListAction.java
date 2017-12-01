package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.CardDAO;

public class CardListAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		CardDAO card_dao=new CardDAO();
		
		ActionForward forward=new ActionForward();
		
		HttpSession session=request.getSession(); 
		//임시
		ArrayList<HashMap> list=card_dao.getCardList((Integer)session.getAttribute("user_id"));
		
		request.setAttribute("card_list", list);
		
		forward.setRedirect(false);
		forward.setPath("jsp/CardManage.jsp");
		
		return forward;
	}

}
