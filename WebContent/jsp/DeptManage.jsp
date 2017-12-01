<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
 <%
 	ArrayList<HashMap<String, Object>> dept=(ArrayList<HashMap<String, Object>>)request.getAttribute("dept");
 
 	String team_name="";
 	int dept_id=-1, dept_com=-1;
 	if(dept.size()>0){
 		team_name=(String)dept.get(0).get("dept_name");
 		dept_id=(Integer)dept.get(0).get("dept_id");
 		//dept_com=(Integer)dept.get(0).get("dept_grp");
 	}
 	
 	int index=-1;
 	int level=(Integer)request.getAttribute("level");
 	System.out.println(dept);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	
	<script src="${pageContext.request.contextPath}/include/jquery.js"></script>
	
	<script src='${pageContext.request.contextPath}/include/moment.min.js'></script>
	<script src="${pageContext.request.contextPath}/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap.min.css"/>
	<script src="${pageContext.request.contextPath}/js/DeptManage.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/DeptManage.css">
</head>
<body>
	<div class="total_wrap">
		<div class="content_menu">
			<div class="menu_name">TEAM INFOMATION</div>
		</div>
		<div class="right_menu" style="width:100%; float:left;margin-top:1%;">
			<div class="mini_wrap" id="team_member_invi" >
	            <div class="mini_menu" >팀원 초대</div>
	            <div class="mini_side"><img src="${pageContext.request.contextPath}/IMAGES/member_add.png"/></div>
	        </div>
      	</div>
      	
		<div class="report_wrap">
			<div class="report_sub_wrap">
				<div class="team_wrap">
					<div class="team_name">
						<img src="${pageContext.request.contextPath}/IMAGES/back.png"  style="width:70%" class="team_back"/>
						<div class="team_title"><%=team_name %></div>
					</div>
					<div class="team_head">
						<div class="head_member">
							<div class="name"><%=dept.get(0).get("user_name") %></div>
							<div class="position">팀장</div>
							<div class="job"><%=dept.get(0).get("user_position") %></div>
						</div>
					</div>
					<%
					index=1;
					if(dept.size()>2 && dept.get(1).get("user_priv").equals("2"))
					{
						index=2;
					%>
					<div class="team_sub_head">
						<div class="head_sub_member">
							<div class="name"><%=dept.get(1).get("user_name")%></div>
							<div class="position">부 팀장</div>
							<div class="job"><%=dept.get(1).get("user_position") %></div>
						</div>
					</div>
					<%
					}
					%>
					<div class="team_consistance">
						<%
						int max_len=index+3;
						for(;index<dept.size() && index<max_len; index++)
						{
						%>
							<div class="team_member">
								<div class="name"><%=dept.get(index).get("user_name")%></div>
								<div class="position">
								<%
									String priv=(String)dept.get(index).get("user_priv");
									if(priv.equals("3"))
										out.println("대리");
									else
										out.println("사원");
								%>
								</div>
								<div class="job"><%=dept.get(index).get("user_position") %></div>
							</div>
						<%
						}
						%>
					</div>
					<div class="team_consistance">
						<%
						max_len=index+3;
						for(;index<dept.size() && index<max_len; index++)
						{
						%>
							<div class="team_member">
								<div class="name"><%=dept.get(index).get("user_name")%></div>
								<div class="position">
								<%
									String priv=(String)dept.get(index).get("user_priv");
									if(priv.equals("3"))
										out.println("대리");
									else
										out.println("사원");
								%>
								</div>
								<div class="job"><%=dept.get(index).get("user_position") %></div>
							</div>
						<%
						}
						%>
					</div>
					<div class="team_consistance">
						<%
						max_len=index+3;
						for(;index<dept.size() && index<max_len; index++)
						{
						%>
							<div class="team_member">
								<div class="name"><%=dept.get(index).get("user_name")%></div>
								<div class="position">
								<%
									String priv=(String)dept.get(index).get("user_priv");
									if(priv.equals("3"))
										out.println("대리");
									else
										out.println("사원");
								%>
								</div>
								<div class="job"><%=dept.get(index).get("user_position") %></div>
							</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
	
 
	<script>
		$("#team_member_invi").click(function(){
			if('<%=level%>'==0 || '<%=level%>'=='1'){
				$('#add_member_dept',top.document).val('<%=dept_id%>');
			    $('#team_invi_btn', top.document).click();
			}else{
				alert("권한이 없습니다.");
			}
		      //$('#add_member_company',top.document).val();
		      
		  });
	</script>
</body>
</html>