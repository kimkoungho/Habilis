package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.DeptDAO;

public class DeptInfoAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int dept_id=Integer.parseInt(request.getParameter("dept_id"));
		
		DeptDAO dept_dao=new DeptDAO();
		
		HttpSession session=request.getSession();
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
		
		ArrayList<HashMap<String, Object>> list=dept_dao.getDeptInfo(dept_id);
		
		request.setAttribute("dept", list);
		
		ActionForward forward=new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("jsp/DeptManage.jsp");
		return forward;
	}

}
