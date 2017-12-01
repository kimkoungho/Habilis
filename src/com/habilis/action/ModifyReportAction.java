package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.habilis.DAO.ReceiptDAO;
import com.habilis.DAO.ReportDAO;

public class ModifyReportAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward=new ActionForward();
		
		String cmd=request.getParameter("cmd");
		if(cmd==null)
			cmd="";
		String value=request.getParameter("value");
		if(value==null)
			value="";
		int dept_id=Integer.parseInt(request.getParameter("dept_id"));
		int page=Integer.parseInt(request.getParameter("page"));
		
		boolean result=false;
		try{
			ReportDAO report_dao=new ReportDAO();
			
			int report_id=Integer.parseInt(request.getParameter("report_id"));
			String report_state=request.getParameter("report_state");
			String report_delay=request.getParameter("report_delay");
			
			result=report_dao.modifyReport(report_id, report_state, report_delay);
			
			ReceiptDAO receipt_dao=new ReceiptDAO();
			ArrayList<HashMap> receipt_list=receipt_dao.getReportReceipt(report_id);
			
			for(int i=0; i<receipt_list.size(); i++){
				HashMap<String, Object> receipt=receipt_list.get(i);
				receipt.put("receipt_state", report_state);
				receipt_dao.modifyReceipt(receipt);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(result==false){
			System.out.println("보고서 modify 실패");
			return null;
		}else{
			ReportListAction action=new ReportListAction();
			return action.executeAction(request, response);
		}
	}

}