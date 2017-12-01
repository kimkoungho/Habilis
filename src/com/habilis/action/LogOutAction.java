package com.habilis.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogOutAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session=request.getSession();
		session.invalidate();
		
		ActionForward forward=new ActionForward();
		forward.setPath("jsp/Main.jsp");
		forward.setRedirect(true);
		
		return forward;
	}

}