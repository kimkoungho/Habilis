package com.habilis.action;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.DeptDAO;
import com.habilis.DAO.UserDAO;

import javax.mail.Transport;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.Address;
import javax.mail.internet.MimeMessage;
import javax.mail.Session;
import javax.mail.Authenticator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import kr.pe.hoyanet.mail.SMTPAuthenticator;

public class InsertDeptAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String type=request.getParameter("type");
		
		Enumeration<String> names=request.getParameterNames();
		
		ArrayList<String> p_list1=new ArrayList<String>();
		ArrayList<String> p_list2=new ArrayList<String>();
		while(names.hasMoreElements()){
			String param_name=names.nextElement();
			if(request.getParameter(param_name).equals("")==false){
				if(param_name.contains("dept_title_"))
					p_list1.add(request.getParameter(param_name));
				if(param_name.contains("dept_header_"))
					p_list2.add(request.getParameter(param_name));
				
				if(param_name.contains("dept_member_"))
					p_list1.add(request.getParameter(param_name));
				if(param_name.contains("dept_member_priv_"))
					p_list2.add(request.getParameter(param_name));
			}
		}
		
		Properties p = new Properties();
		
		p.put("mail.smtp.user", "akkdu");
		p.put("mail.smtp.host", "smtp.naver.com");
		
		// 아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		Authenticator auth = new SMTPAuthenticator();
		Session ses = Session.getInstance(p, auth);
		
		// 메일의 내용을 담기 위한 객체
		MimeMessage msg = new MimeMessage(ses);
		
		DeptDAO dept_dao=new DeptDAO();
		UserDAO user_dao=new UserDAO();
		String dept_name="";
		int select_company=-1;
		HttpSession session=request.getSession(); 
		Integer dept_user=(Integer)session.getAttribute("user_id");
		if(type.equals("company")){
			dept_name=request.getParameter("company_title");
			
			//회사 추가
			HashMap<String, Object> com=new HashMap<String, Object>();
			int dept_id=dept_dao.getDeptId();
			com.put("dept_id", dept_id);
			com.put("dept_name", dept_name);
			com.put("dept_info", "");
			com.put("dept_header", dept_user);
			com.put("dept_grp", dept_id);
			
			dept_dao.insertDept(com);
			
			//회사 추가 - 사용자의 회사 변경
			user_dao.updateDept(dept_user, -1, 1, dept_id);
			
			for(int i=0; i<p_list1.size(); i++){
				int user_id=user_dao.getId(p_list2.get(i));
				if(user_id==-1) continue;
				int user_dept=dept_dao.getDeptId();
				
				HashMap<String, Object> dept=new HashMap<String, Object>();
				dept.put("dept_id", user_dept);
				dept.put("dept_name", p_list1.get(i));
				dept.put("dept_info", "");
				dept.put("dept_header", user_id);
				dept.put("dept_grp", dept_id);
				dept_dao.insertDept(dept);
				
				user_dao.updateDept(user_id, user_dept, 1, -1);
				
				HashMap<String,Object> user=user_dao.getUserInfo(user_id);
				// 제목 설정 
				msg.setSubject("[하빌리스 시스템] "+dept_name+" 팀장이 되었습니다.");

				// 보내는 사람의 메일주소
				Address fromAddr = new InternetAddress("akkdu@naver.com");
				msg.setFrom(fromAddr);

				// 받는 사람의 메일주소

				Address toAddr = new InternetAddress((String)user.get("user_mail"));
				msg.addRecipient(Message.RecipientType.TO, toAddr);

				// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
				String content=(String)user.get("user_name")+" 님이 "+dept_name+"팀에 초대하셨습니다.";
				msg.setContent(content, "text/html;charset=UTF-8");

				// 발송하기
				Transport.send(msg);
			}
		}else{
			dept_name=request.getParameter("dept_title");
			select_company=Integer.parseInt(request.getParameter("select_company"));
			
			//부서 추가하고
			HashMap<String, Object> dept=new HashMap<String, Object>();
			int user_dept=dept_dao.getDeptId();
			dept.put("dept_id", user_dept);
			dept.put("dept_name", dept_name);
			dept.put("dept_info", "");
			dept.put("dept_header", dept_user);
			dept.put("dept_grp", select_company);
			dept_dao.insertDept(dept);
			
			user_dao.updateDept(dept_user, user_dept, 1, -1);
			
			//부서에 사용자들 추가
			for(int i=0; i<p_list1.size(); i++){
				int user_id=user_dao.getId(p_list1.get(i));
				if(user_id==-1) continue;
				user_dao.updateDept(user_id, user_dept, Integer.parseInt(p_list2.get(i)), -1);
				
				HashMap<String,Object> user=user_dao.getUserInfo(user_id);
				// 제목 설정 
				msg.setSubject("[하빌리스 시스템] "+dept_name+"팀에 초대되었습니다.");

				// 보내는 사람의 메일주소
				Address fromAddr = new InternetAddress("akkdu@naver.com");
				msg.setFrom(fromAddr);

				// 받는 사람의 메일주소

				Address toAddr = new InternetAddress((String)user.get("user_mail"));
				msg.addRecipient(Message.RecipientType.TO, toAddr);

				// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
				String content=(String)user.get("user_name")+" 님이 "+dept_name+"팀에 초대하셨습니다.";
				msg.setContent(content, "text/html;charset=UTF-8");

				// 발송하기
				Transport.send(msg);
			}
		}
		
		//갱신
		HashMap<String, Object> user=user_dao.getUserInfo((Integer)session.getAttribute("user_id"));
		
		//session.setAttribute("user_id", user.get("user_id"));
		//session.setAttribute("password",user.get(" password"));
		//session.setAttribute("user_name",user.get("user_name"));
		//session.setAttribute("user_img",user.get("user_img"));
		//session.setAttribute("user_mail",user.get("user_mail"));
		//session.setAttribute("user_phone",user.get("user_phone"));
//		session.setAttribute("user_tel",user.get("user_tel"));
//		session.setAttribute("user_position",user.get("user_position"));
		session.setAttribute("user_dept",user.get("user_dept"));
		session.setAttribute("user_priv",user.get("user_priv"));
		session.setAttribute("user_company",user.get("user_company"));
		
		String user_company=(String)user.get("user_company");
		String []com_list=user_company.split(",");
		
		ArrayList<HashMap<String, Object>> company_list=new ArrayList<HashMap<String, Object>>();
		for(int i=0; i<com_list.length; i++){
			company_list.add(dept_dao.getCompanyInfo(Integer.parseInt(com_list[i])));
		}
		
		session.setAttribute("com_list", company_list);
		
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(true);
		forward.setPath("jsp/Top.jsp");
		
		return forward;
	}
	
}