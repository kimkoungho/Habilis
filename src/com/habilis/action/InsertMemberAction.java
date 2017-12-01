package com.habilis.action;

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
import java.net.URLEncoder;

public class InsertMemberAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String email=request.getParameter("mail");
		int priv=Integer.parseInt(request.getParameter("priv"));
		//System.out.println(request.getParameter("dept"));
		int u_dept=Integer.parseInt(request.getParameter("dept"));
		
		Properties p = new Properties();
		try{
			UserDAO user_dao=new UserDAO();
			int user_id=user_dao.getId(email);
			
			user_dao.updateDept(user_id, u_dept, priv, -1);
			
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
			
			// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
			ses.setDebug(true);

			// 메일의 내용을 담기 위한 객체
			MimeMessage msg = new MimeMessage(ses);

			DeptDAO dept_dao=new DeptDAO();
			ArrayList<HashMap<String, Object>> dept=dept_dao.getDeptInfo(u_dept);
			if(dept.size()<1) return null;
			
			HttpSession session=request.getSession();
			String user_name=(String)session.getAttribute("user_name");
			// 제목 설정 
			msg.setSubject("[하빌리스 시스템]"+dept.get(0).get("dept_name")+"팀에 초대되었습니다.");

			// 보내는 사람의 메일주소
			Address fromAddr = new InternetAddress("akkdu@naver.com");
			msg.setFrom(fromAddr);

			// 받는 사람의 메일주소

			Address toAddr = new InternetAddress(email);
			msg.addRecipient(Message.RecipientType.TO, toAddr);

			// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
			String content=user_name+" 님이 "+dept.get(0).get("dept_name")+"팀에 초대하셨습니다.";
			msg.setContent(content, "text/html;charset=UTF-8");

			// 발송하기
			Transport.send(msg);
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ActionForward forward=new ActionForward();
		forward.setPath("jsp/Top.jsp");
		forward.setRedirect(true);
		
		return forward;
	}

}