package com.habilis.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionForward{
	private boolean isRedirect=false;
	private String path=null;
	
	public boolean isRedirect(){
		return isRedirect;
	}
	
	public String getPath(){
		return path;
	}
	
	public void setRedirect(boolean redirect){
		this.isRedirect=redirect;
	}
	
	public void setPath(String url){
		this.path=url;
	}
}
