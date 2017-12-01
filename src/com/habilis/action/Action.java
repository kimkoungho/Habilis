package com.habilis.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	
	
	public ActionForward executeAction(HttpServletRequest request,    HttpServletResponse response) throws Exception;
}
