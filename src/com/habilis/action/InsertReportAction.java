package com.habilis.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.ReportDAO;
import java.net.URLEncoder;

public class InsertReportAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		ActionForward forward=new ActionForward();
		
		boolean result=false;
		try{
			ReportDAO report_dao=new ReportDAO();
			
			String receipt_list=request.getParameter("receipt_list");
			int report_id=report_dao.getReportId();
			String report_title=request.getParameter("report_title");
			
			System.out.println(report_title);
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
			Date today=new Date();
			String report_date=sdf.format(today);
			String report_state="wait";
			int level=Integer.parseInt(request.getParameter("level"));
			HttpSession session=request.getSession();
			int report_writer=(Integer)session.getAttribute("user_id");
			int report_dept=Integer.parseInt(request.getParameter("dept_id"));
			
			HashMap<String, Object> report=new HashMap<String, Object>();
			report.put("receipt_list", receipt_list);
			report.put("report_id", report_id);
			report.put("report_title", report_title);
			report.put("level", level);
			report.put("report_date", report_date);
			report.put("report_state", report_state);
			report.put("report_writer", report_writer);
			report.put("report_dept", report_dept);
			report.put("report_delay", "");
			report.put("dept_sequence", report_dao.getTotalRecord(report_dept)+1);
			
			//System.out.println(report);
			result=report_dao.insertReport(report);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!result){
			System.out.println("보고서 insert 실패");
			return null;
		}else{
			ReportListAction action=new ReportListAction();
			
			return action.executeAction(request, response);
		}
	}

}
