package com.habilis.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.habilis.DAO.ReceiptDAO;

public class ChartListAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int dept_id=Integer.parseInt(request.getParameter("dept_id"));
		String cmd=request.getParameter("cmd");//명령 
		if(cmd==null)
			cmd="";
		String value=request.getParameter("value");// 값 
		if(value==null)
			value="";
		request.setAttribute("cmd", cmd);
		request.setAttribute("value", value);
		
		ReceiptDAO receipt_dao=new ReceiptDAO();
		ArrayList<HashMap<String, Object>> chart_list=receipt_dao.getListChart(dept_id, cmd, value);
		HashMap<String, Object> header=receipt_dao.getHeaderChart(dept_id, cmd, value);
		
		ArrayList<HashMap<String, Object>> end_list_f=receipt_dao.getFooterChart(dept_id, cmd, value,true);
		ArrayList<HashMap<String, Object>> end_list_s=receipt_dao.getFooterChart(dept_id, cmd, value,false);

		
		ActionForward forward=new ActionForward();
		
		request.setAttribute("header", header);
		request.setAttribute("chart_list", chart_list);
		
		request.setAttribute("end_list_f", end_list_f);
		request.setAttribute("end_list_s", end_list_s);
		
		
		forward.setRedirect(false);
		forward.setPath("jsp/ChartManage.jsp");
		
		return forward;
	}

}
