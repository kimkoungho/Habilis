package com.habilis.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.habilis.DAO.ReceiptDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ModifyReceiptAction implements Action{

	@Override
	public ActionForward executeAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MultipartRequest multi=null;
		String realPath=request.getServletContext().getRealPath("uploads");
		
		int size=10*1024*1024;
		String encType="utf-8";
		DefaultFileRenamePolicy policy=new DefaultFileRenamePolicy();
		
		multi=new MultipartRequest(request, realPath, size, encType, policy);
		
		ActionForward forward=new ActionForward();
		
		boolean result=false;
		
		try{
			ReceiptDAO receipt_dao=new ReceiptDAO();
			
			int receipt_id=Integer.parseInt(multi.getParameter("receipt_id"));
			String receipt_type=multi.getParameter("type");
			String receipt_date=multi.getParameter("use_date");
			
			int receipt_cost=Integer.parseInt(multi.getParameter("cost").trim());
			String receipt_state="wait";
			
			String receipt_img="";
			//파일 이름 바꾸기
			String fname = multi.getOriginalFileName("r_img");
			if(fname!=null){
				String oldName="uploads/"+String.format("%010d", receipt_id)+fname.substring(fname.lastIndexOf("."));
				File prevFile=new File(oldName);
				if(prevFile.delete())
					System.out.println("삭제 성공");
				
				String newName=String.format("%010d", receipt_id)+fname.substring(fname.lastIndexOf("."));//
				File oldFile=new File(realPath+"/"+fname);
				File newFile=new File(realPath+"/"+newName);
				oldFile.renameTo(newFile);
				receipt_img="uploads"+"/"+newName;
			}
			
			HttpSession session=request.getSession();
			int receipt_writer=(Integer)session.getAttribute("user_id");//임시 로그인 사용자 아이디
			String receipt_use=multi.getParameter("use");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
			Date today=new Date();
			String receipt_write_date=sdf.format(today);
			int level=Integer.parseInt(multi.getParameter("level"));
			String comment=multi.getParameter("comment");
			String payment=multi.getParameter("card");
			int receipt_dept=Integer.parseInt("dept_id");
			String report_id=multi.getParameter("report_id");
			if(report_id==null)
				report_id="-1";
			
			HashMap<String, Object> receipt=new HashMap<String, Object>();
			receipt.put("receipt_id", receipt_id);
			receipt.put("receipt_type", receipt_type);
			receipt.put("receipt_date", receipt_date);
			receipt.put("receipt_cost", receipt_cost);
			receipt.put("receipt_state", receipt_state);
			receipt.put("receipt_writer", receipt_writer);
			receipt.put("receipt_use", receipt_use);
			receipt.put("receipt_write_date", receipt_write_date);
			receipt.put("level", level);
			receipt.put("comment", comment);
			receipt.put("payment", payment);
			receipt.put("receipt_dept", receipt_dept);
			receipt.put("report_id", Integer.parseInt(report_id));
			//System.out.println(receipt);
			
			result=receipt_dao.modifyReceipt(receipt);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(!result){
			System.out.println("영수증 modify 실패");
			return null;
		}else{
			ReceiptListAction action=new ReceiptListAction();
			
			return action.executeAction(request, response);
		}
	}

}