package com.habilis.action;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.habilis.DAO.DeptDAO;
import com.habilis.DAO.UserDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class JoinAction implements Action{

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
			
			int user_id=user_dao.getUserId();
			String password=multi.getParameter("Pw");
			String user_name=multi.getParameter("name");
			String user_mail=multi.getParameter("ID");
			
			//파일 이름 바꾸기
			String fname = multi.getOriginalFileName("profile_file");
			//System.out.println(fname);
			
			String newName=user_mail.split("@")[0]+user_id+fname.substring(fname.lastIndexOf("."));//
			File oldFile=new File(realPath+"/"+fname);
			if(user_dao.idCheck(user_mail)){
				
				File newFile=new File(realPath+"/"+newName);
				oldFile.renameTo(newFile);
				String user_img="uploads"+"/"+newName;
				
				String user_phone=multi.getParameter("Phone");
				//여기까지 필수
				
				String user_tel=multi.getParameter("com_phone");
				//System.out.println(user_tel);
				if(user_tel==null) user_tel="";
				String user_position=multi.getParameter("sir");
				if(user_position==null) user_position="";
				
//				DeptDAO dept_dao=new DeptDAO();
//				int dept_id=dept_dao.getDeptId();
//				String user_dept=Integer.toString(dept_id)+",";
//				String user_priv="1,";
				//사용자이름의 부서생성
//				HashMap<String, Object> dept=new HashMap<String, Object>();
//				dept.put("dept_id", dept_id);
//				dept.put("dept_name", user_name);
//				dept.put("dept_info", "");
//				dept.put("dept_header", user_id);
//				dept.put("dept_grp", dept_id);
				
				ret++;
				
				HashMap<String, Object> user=new HashMap<String, Object>();
				user.put("user_id", user_id);
				user.put("password", password);
				user.put("user_name", user_name);
				user.put("user_mail", user_mail);
				user.put("user_img", user_img);
				user.put("user_phone", user_phone);
				user.put("user_tel", user_tel);
				user.put("user_position", user_position);
				user.put("user_dept", ",");
				user.put("user_priv", ",");
				user.put("user_company", ",");
				
				if(user_dao.join(user)) ret++;
			}else{
				oldFile.delete();
			}
			
			response.getWriter().print(ret);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return null;
	}

	
}
