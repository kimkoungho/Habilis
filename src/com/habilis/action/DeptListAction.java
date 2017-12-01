package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.DeptDAO;;

public class DeptListAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		DeptDAO dept_dao=new DeptDAO();
		
		HttpSession session=request.getSession();
		
		int user_id=(Integer)session.getAttribute("user_id");
		String user_dept=(String)session.getAttribute("user_dept");
		String user_company=(String)session.getAttribute("user_company");
		
		ArrayList<HashMap> list=dept_dao.getUserDeptList(user_id, user_dept);
//		
		ActionForward forward=new ActionForward();
		
		//System.out.println(list);
		request.setAttribute("dept_list", list);
		
		forward.setRedirect(false);
		forward.setPath("jsp/Menu.jsp");
		
		return forward;
	}

}
