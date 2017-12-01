package com.habilis.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.DeptDAO;
import com.habilis.DAO.UserDAO;

public class LoginAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String user_mail=request.getParameter("email");
		String user_pw=request.getParameter("pw");
		
		UserDAO user_dao=new UserDAO();
		
		int user_id=user_dao.login(user_mail, user_pw);
		
		ActionForward forward=new ActionForward();
		
		if(user_id!=-1){
			HashMap<String, Object> user=user_dao.getUserInfo(user_id);
			
			HttpSession session=request.getSession();
			session.setAttribute("user_id", user.get("user_id"));
			session.setAttribute("password",user.get("password"));
			session.setAttribute("user_name",user.get("user_name"));
			session.setAttribute("user_img",user.get("user_img"));
			session.setAttribute("user_mail",user.get("user_mail"));
			session.setAttribute("user_phone",user.get("user_phone"));
			session.setAttribute("user_tel",user.get("user_tel"));
			session.setAttribute("user_position",user.get("user_position"));
			session.setAttribute("user_dept",user.get("user_dept"));
			session.setAttribute("user_priv",user.get("user_priv"));
			session.setAttribute("user_company",user.get("user_company"));
			
			
			String user_company=(String)user.get("user_company");
			String []com_list=user_company.split(",");
			
			DeptDAO dept_dao=new DeptDAO();
			ArrayList<HashMap<String, Object>> company_list=new ArrayList<HashMap<String, Object>>();
			for(int i=0; i<com_list.length; i++){
				company_list.add(dept_dao.getCompanyInfo(Integer.parseInt(com_list[i])));
			}
			ArrayList boss_list=dept_dao.isBoss(user_id, user_company);
			
			session.setAttribute("com_list", company_list);
			session.setAttribute("boss_list", boss_list);
			
			forward.setPath("jsp/Top.jsp");
			forward.setRedirect(true);
		}else{
			forward.setPath("jsp/Main.jsp");
			forward.setRedirect(true);
		}
		
		return forward;
	}

}
