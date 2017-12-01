<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	HashMap<String, Object> header=(HashMap)request.getAttribute("header");
	ArrayList<HashMap<String, Object>> list=(ArrayList)request.getAttribute("chart_list");
	
	ArrayList<HashMap<String, Object>> end_list_f=(ArrayList)request.getAttribute("end_list_f");
	ArrayList<HashMap<String, Object>> end_list_s=(ArrayList)request.getAttribute("end_list_s");
	
	String cmd=(String)request.getAttribute("cmd");
	String value=(String)request.getAttribute("value");
	
	//System.out.println(list);
	String unit="", format="";
	if(cmd.equals("term")){
		String st_date=value.split("~")[0];
		String end_date=value.split("~")[1];
		
		
	}else{
		unit="week";
		format="MM/DD ";
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta charset="utf-8" />
	<script src="${pageContext.request.contextPath}/include/jquery.js"></script>
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script> -->
	
	<script src="${pageContext.request.contextPath}/dist/Chart.bundle.js"></script>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ChartManage.css">

</head>
<body>
	<div class="content_menu">
		<div class="menu_name">DASH BOARD</div>
	</div>
	<div class="content_border">
		<div class="content_info">
			<div class="calendar"></div>
			<div class="member_wrap">
				<div class="member_cont">
					<div class="member_sum"></div>
					<div class="member_user">
						<div class="member_TOTAL">TOTAL <%=header.get("total") %></div>
						<div class="member_MAX">MAX <%=header.get("max") %></div>
						<div class="member_AVERAGE">AVERAGE <%=header.get("avg") %></div>
					</div>
					<div class="member_chart">
						<div class="member_stack">
							<div class="member_stack_title">결제별(TOTAL)</div>
							<div class="member_stcak_canvas">
								<canvas id="radar" style="width:100%; background-color : #2a343e; "></canvas>
								<div class="radar_menu">
									
								</div>
							</div>
						</div>
						
						<div class="member_dount">
							<div class="member_dount_title">분류별(TOTAL)</div>
							<div class="member_dount_canvas">
								<canvas id="dount" style="width:100%; background-color : #2a343e;"></canvas>
								<div class="dount_menu">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="member_line">
					<div class="member_line_canvas">전달지출비교</div>
					<canvas id="line" style="width:100%; background-color : white;"></canvas>
				</div>
			</div>
		</div>
	</div>
	<script>
		var unit_type='<%=unit%>';
		var format_type='<%=format%>';
		
		var labels = [
			<%
			for(int i=0; i<list.size()/2; i++)
			{
			%>
				'<%=(String)list.get(i*2).get("receipt_type")%>',
			<%	
			}
			%>
		];
		var doughnut_data = [ 
		<%
		for(int i=0; i<list.size()/2; i++)
		{
			int sum=(Integer)list.get(i*2).get("sum")+(Integer)list.get(i*2+1).get("sum");
			//System.out.println(sum);
		%>
			<%=sum%>,
		<%
		}
		%>
		];
		
		var radar_datasets = [
			{
				label : "개인 카드",
				backgroundColor: "#5a9bd5",
                borderColor: "#81F7F3",
                pointBackgroundColor: "#fff",
				fillColor : "#5a9bd5",
				strokeColor : "#81F7F3",
				fontsize : "8px",
				pointColor : "rgba(220,220,220,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(220,220,220,1)",
				data : [
				        <%
				        for(int i=0; i<list.size(); i++){
				        	if(list.get(i).get("payment").equals("per"))
				        		out.print(list.get(i).get("sum")+",");
				        }
				        %>
				]
			},
			{
				label : "법인 카드",
				backgroundColor: "#ed7d31",
                borderColor:"rgba(151,187,205,1)",
                pointBackgroundColor: "#fff",
				fillColor : "#ed7d31",
				strokeColor : "rgba(151,187,205,1)",
				pointColor : "rgba(151,187,205,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(151,187,205,1)",
				data : [
						<%
						for(int i=0; i<list.size(); i++){
				        	if(list.get(i).get("payment").equals("cor"))
				        		out.print(list.get(i).get("sum")+",");
				        }
				        %>
				]
			} 
		];
	
		
		var line_datasets = [
			{
				label:"now",
				backgroundColor:"#6fd3ff",
				data:[
					<%
					for(int i=0; i<end_list_f.size(); i++)
					{
					%>
						{
							x: new Date('<%=end_list_f.get(i).get("receipt_date")%>'),
							y: <%=end_list_f.get(i).get("sum")%>
						},	
					<%
					}
					%>
				]
			},
			{
				label:"before",
				backgroundColor:"#fe9e6b",
				data:[
					<%
					for(int i=0; i<end_list_s.size(); i++)
					{
					%>
						{
							x: new Date('<%=end_list_s.get(i).get("receipt_date")%>'),
							y: <%=end_list_s.get(i).get("sum")%>
						},	
					<%
					}
					%>
				]
			}
		];

	</script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/ChartManage.js"></script>
</body>
</html>