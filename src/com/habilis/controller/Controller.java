package com.habilis.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.habilis.action.Action;
import com.habilis.action.ActionForward;


@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Controller() {
        super();
    }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	System.out.println("do process");
    	
    	String requestURI=request.getRequestURI();
    	String contextPath=request.getContextPath();
    	String command=requestURI.substring(contextPath.length());
    	
    	ActionForward forward=null;
    	Action action=null;
    	
    	System.out.println(command);
    	//command 에 따라 실행
    
    	String className="com.habilis.action."+command.substring(1,command.lastIndexOf(".")).trim();
    	System.out.println(className);
    	try{
    		Class cmd_class=Class.forName(className);
    		Object commandInstance=cmd_class.newInstance();
    		
    		action=(Action)commandInstance;
    		
    		if(action==null){
    			System.out.println("not found class");
    			return;
    		}
    		
    		forward=action.executeAction(request, response);
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    	if(forward!=null){
    		if(forward.isRedirect()){
    			response.sendRedirect(forward.getPath());
    		}else{
    			RequestDispatcher dispatcher=request.getRequestDispatcher(forward.getPath());
    			dispatcher.forward(request,response);
    		}
    	}
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get method");
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("post method");
		doProcess(request, response);
	}

}
