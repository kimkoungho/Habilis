package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.DeptDAO;
import com.habilis.DAO.ReportDAO;
import com.habilis.DAO.UserDAO;

public class ReportListAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		String cmd=request.getParameter("cmd");
		if(cmd==null)
			cmd="";
		String value=request.getParameter("value");
		if(value==null)
			value="";
		//System.out.println(cmd+"......."+value);
		int dept_id=Integer.parseInt(request.getParameter("dept_id"));
		int page=Integer.parseInt(request.getParameter("page"));
		
		HttpSession session=request.getSession();
		
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
		
		int user_id=(Integer)session.getAttribute("user_id");
		
		ReportDAO report_dao=new ReportDAO();
		int total=report_dao.getTotalRecord(dept_id);
		
		ArrayList<HashMap> list=report_dao.getReportList(dept_id, cmd, value, page, level, user_id);//
		
		UserDAO user_dao=new UserDAO();
		ArrayList<String> user_names=new ArrayList<String>();
		for(int i=0; i<list.size(); i++){
			HashMap<String, Object> user=user_dao.getUserInfo((Integer)(list.get(i).get("report_writer")));
			user_names.add((String)user.get("user_name"));
		}
		
		ActionForward forward=new ActionForward();
		
		//System.out.println(page+"...."+total);
		request.setAttribute("page", page);
		request.setAttribute("total", total);
		request.setAttribute("report_list", list);
		
		request.setAttribute("user_names", user_names);
		request.setAttribute("dept_id", dept_id);
		
		request.setAttribute("cmd", cmd);
		request.setAttribute("value", value);
		forward.setRedirect(false);
		forward.setPath("jsp/ReportManage.jsp");
		
		return forward;
	}

}