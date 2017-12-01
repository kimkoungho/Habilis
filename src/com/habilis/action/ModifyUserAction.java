package com.habilis.action;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.UserDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ModifyUserAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MultipartRequest multi=null;
		String realPath=request.getServletContext().getRealPath("uploads");
		UserDAO user_dao=new UserDAO();
		
		int size=10*1024*1024;
		String encType="utf-8";
		DefaultFileRenamePolicy policy=new DefaultFileRenamePolicy();
		
		multi=new MultipartRequest(request, realPath, size, encType, policy);
		int ret=0;
		try{
			HttpSession session=request.getSession();
			
			int user_id=(Integer)session.getAttribute("user_id");
			String password=multi.getParameter("modify_user_pw");
			String session_pw=(String)session.getAttribute("password");
			
			if(password.equals(session_pw)){
				String user_name=multi.getParameter("modify_user_name");
				String user_mail=(String)session.getAttribute("user_mail");
				//이전 파일 삭제
				String prev_file=(String)session.getAttribute("user_img");
				if(prev_file!=null){
					File file=new File(prev_file);
					file.delete();
				}
				
				//파일 이름 바꾸기
				String fname = multi.getOriginalFileName("profile_file_modi");
				//System.out.println(fname);
				
				String newName=user_mail.split("@")[0]+user_id+fname.substring(fname.lastIndexOf("."));//
				File oldFile=new File(realPath+"/"+fname);
				
					
					File newFile=new File(realPath+"/"+newName);
					oldFile.renameTo(newFile);
					String user_img="uploads"+"/"+newName;
					
					String user_phone=multi.getParameter("modify_user_phone");
					//여기까지 필수
					
					String user_tel=multi.getParameter("modify_user_tel");
					//System.out.println(user_tel);
					if(user_tel==null) user_tel="";
					String user_position=multi.getParameter("modify_user_pos");
					if(user_position==null) user_position="";
					
					HashMap<String, Object> user=new HashMap<String, Object>();
					user.put("user_id", user_id);
					user.put("password", password);
					user.put("user_name", user_name);
					user.put("user_mail", user_mail);
					user.put("user_img", user_img);
					user.put("user_phone", user_phone);
					user.put("user_tel", user_tel);
					user.put("user_position", user_position);
					
					user_dao.updateUser(user);
					//System.out.println(user);
					
					session.setAttribute("user_name",user_name);
					session.setAttribute("user_img",user_img);
					session.setAttribute("user_phone",user_phone);
					session.setAttribute("user_tel",user_tel);
					session.setAttribute("user_position",user_position);
				
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionForward forward=new ActionForward();
		forward.setPath("jsp/Top.jsp");
		forward.setRedirect(true);
		
		return forward;
	}

}
