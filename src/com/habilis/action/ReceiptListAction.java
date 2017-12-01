package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.DeptDAO;
import com.habilis.DAO.ReceiptDAO;
import com.habilis.DAO.ReportDAO;
import com.habilis.DAO.UserDAO;

public class ReceiptListAction implements Action{

	boolean multi_flag=false;
	public ReceiptListAction(){}
	public ReceiptListAction(boolean flag){
		this.multi_flag=flag;
	}
	
	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		
		HttpSession session=request.getSession();
		String cmd=request.getParameter("cmd");
		if(cmd==null)
			cmd="";
		String value=request.getParameter("value");
		if(value==null)
			value="";
		int dept_id=Integer.parseInt(request.getParameter("dept_id"));
		int page=Integer.parseInt(request.getParameter("page"));
		
		//권한 관리
		String []deptList=((String)session.getAttribute("user_dept")).split(",");
		String []privList=((String)session.getAttribute("user_priv")).split(",");
		
		int level=-1;//임시
		for(int i=0; i<deptList.length; i++){
			if(Integer.parseInt(deptList[i])==dept_id){
				if(privList[i].equals("1")){//팀장
					level=1;
				}else{
					level=3;
				}
				break;
			}
		}
		DeptDAO dept_dao=new DeptDAO();
		int com_id=dept_dao.getCompanyId(dept_id);
		request.setAttribute("company_id", com_id);
		
		boolean boss=false;
		String []comList=((String)session.getAttribute("user_company")).split(",");
		ArrayList<Boolean> boss_list=(ArrayList)session.getAttribute("boss_list");
		for(int i=0; i<comList.length; i++){
			if(com_id==Integer.parseInt(comList[i])){
				boss=boss_list.get(i);
			}
		}
		
		if(boss)
			level=0;
		request.setAttribute("level", level);
		
		ReceiptDAO receipt_dao=new ReceiptDAO();
		
		//String receipt_id=receipt_dao.getReceiptId("0000000001");//사용자 아이디 임시
		int total=receipt_dao.getTotalRecord(dept_id);
		
		ArrayList<HashMap> list=receipt_dao.getReceiptList(dept_id, cmd, value, page,level);//
		
		UserDAO user_dao=new UserDAO();
		ArrayList<String> user_names=new ArrayList<String>();
		for(int i=0; i<list.size(); i++){
			HashMap<String, Object> user=user_dao.getUserInfo((Integer)list.get(i).get("receipt_writer"));
			user_names.add((String)user.get("user_name"));
			//receipt_users.add(receipt_dao.getReceiptId(user_id));
		}
		
		ReportDAO report_dao=new ReportDAO();
		int report_id=report_dao.getNextReportId(dept_id);
		int n_receipt=receipt_dao.getNextReceiptId(dept_id);
		
		ActionForward forward=new ActionForward();
		
		//System.out.println(page+"...."+total);
		request.setAttribute("page", page);
		request.setAttribute("total", total);
		//request.setAttribute("receipt_id", receipt_id);
		request.setAttribute("receipt_list", list);
		
		//request.setAttribute("receipt_users", receipt_users);
		request.setAttribute("user_names", user_names);
		request.setAttribute("report_id", report_id);
		request.setAttribute("n_receipt", n_receipt);
		
		request.setAttribute("dept_id", dept_id);
		
		request.setAttribute("cmd", cmd);
		request.setAttribute("value", value);
		
		forward.setRedirect(false);
		forward.setPath("jsp/ReceiptManage.jsp");
		
		return forward;
	}

}