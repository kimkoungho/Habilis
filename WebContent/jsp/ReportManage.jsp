<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	ArrayList<HashMap> list=(ArrayList)request.getAttribute("report_list");
	ArrayList<String> user_names=(ArrayList)request.getAttribute("user_names");
	
	int dept_id=(Integer)request.getAttribute("dept_id");
	String cmd=(String)request.getAttribute("cmd");
	String value=(String)request.getAttribute("value");
	
	if(cmd==null)
		cmd=" ";
	if(value==null)
		value=" ";
	
	int current_page=(Integer)request.getAttribute("page");
	int total=(Integer)request.getAttribute("total");
	
	int pages=0;
	if(total%20==0){
		pages=total/20;
	}else{
		pages=total/20+1;
	}
	
	int user_id=(Integer)session.getAttribute("user_id");
	//사용자의 기본 부서 추출
	
	
	//사용자의 팀의 계급 추출 \ 0 사장 \ 1 팀장 \ 2 작성자 \ 3 사원 
	int user_level=(Integer)request.getAttribute("level");
	
	int com_id=(Integer)request.getAttribute("company_id");
	//System.out.println(list.size());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	
   <script src="${pageContext.request.contextPath}/include/jquery.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/js/ReportManage.js"></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ReportManage.css">
</head>
<body>
	<div class="wrap">
		<div id="company_id" style="display:none;"><%=com_id %></div>
		<div id="depart_id" style="display:none;"><%=dept_id %></div>
		
   		<div class="content_menu">
      		<div class="menu_name">REPORT MANAGE</div>
   		</div>
      	<div class="report_wrap">
      		<div class="report_sub_wrap">
            	<div class="table_wrap">
					<table style="width: 100%;">
                  		<tr class="report_menu">
                     		<th>NO.</th>
                     		<th>일시</th>
                     		<th>제목</th>
                     		<th>담당자</th>
                     		<th>등급</th>
                     		<th>상태</th>
                     		<th>보류사유</th>
                  		</tr>
                  	<%
                  	System.out.println(list);
                  	for(int i=0; i<list.size(); i++)
                  	{
                  		String cnt=String.format("%010d",(Integer)list.get(i).get("dept_sequence"));
                  		String date=(String)list.get(i).get("report_date");
                  		date=date.substring(0,date.lastIndexOf(":"));
                  	%>
                  		<tr class="report_cont_line" id="<%=list.get(i).get("report_id")%>">
                     	<!-- report_id -->
                     		<td style="display:none;"><input type="checkbox" name="" class="check_box"/></td>
                     		<td class="report_cont_info"><%=cnt %></td>
                     		<td class="report_cont_info"><%= date%></td>
                     		<td class="report_cont_info"><%=list.get(i).get("report_title") %></td>
                     		<td class="report_cont_info"><%=user_names.get(i) %></td>
                     		<td class="report_cont_info"><%=list.get(i).get("level") %> 등급</td>
                     		<td class="report_cont_info">
                     		<%
	                     		String state=(String)list.get(i).get("report_state");
	                     		if(state.equals("wait"))
	                     			out.println("대기중");
	                     		else if(state.equals("delay"))
	                     			out.println("보류중");
	                     		else if(state.equals("finish"))
	                     			out.println("완료");
	                     		else
	                     			out.println("진행중");
	                     	%>
                     		</td>
                     		<td class="report_cont_info"><%=list.get(i).get("report_delay") %></td>
                     		<td style="display:none;"><%=list.get(i).get("report_writer") %></td>
                  		</tr>
                  	<%
                  	}
                  	%>
               		</table>
            	</div>
            	
	            <div class="page_footer">
		            <div class="option_button">
		            	<span class="option_left">
			               <span class="num">0</span>
			               <span> 개 항목이 선택됨</span>
		               </span>
		               <span class="option_right">
		               		<span class="select_all">전체선택</span>
		               		<span class="select_no">전체해제</span>
			               	<span class="select_delete">삭제하기</span>
		               </span>
		            </div>
		            <div class="page">
						<%
						String page_url="./ReportListAction.cont?dept_id="+dept_id+"&cmd="+cmd+"&value="+value+"&page=";
						int prev=current_page-1, next=current_page+1;
						
						%>
							<span>
							<%
							if(prev>=1)
							{
							%>
								<a href='<%=page_url+(prev) %>'>
									<img src="${pageContext.request.contextPath}/IMAGES/pageNavi_l.png" class="page_nav_icon" />
								</a>
							<%
							}
							else
							{
							%>
								<img src="${pageContext.request.contextPath}/IMAGES/pageNavi_l.png" class="page_nav_icon" />
							<%
							}
							%>
							</span>
						<%
							if(prev>=1){
								if(prev!=1){
									out.println("<span><a href='"+page_url+1+"'><b>"+1+"</b></a></span>");
									out.println("...");
								}
								out.println("<span><a href='"+page_url+prev+"'>"+prev+"</a></span>");
							}
							out.println("<span><a>"+current_page+"</a></span>");
							if(next<=pages){
								out.println("<span><a href='"+page_url+next+"'>"+next+"</a></span>");
								if(next!=pages){
									out.println("...");
									out.println("<span><a href='"+page_url+pages+"'>"+pages+"</a></span>");
								}
							}
							
						%>
						<span>
						<%
						if(next<=pages)
						{
						%>
							<a href='<%=page_url+(next) %>'>
								<img src="${pageContext.request.contextPath}/IMAGES/pageNavi_r.png" class="page_nav_icon"/>
							</a>
						<%
						}
						else
						{
						%>
							<img src="${pageContext.request.contextPath}/IMAGES/pageNavi_r.png" class="page_nav_icon"/>
						<%
						}
						%>
						</span>
					</div>
				</div>
         	</div>
      		
      		<!-- 드롭다운 메뉴 -->
	         <div class="option" style="display:none;">
	            <div class="approval" style="text-align:center">승인하기</div>
	            <div class="download" style="text-align:center">csv 다운받기</div>
	         </div>
	         
      	</div>
     </div>
     <script>
     	$('.select_delete').click(function(){
     		//권한 있는지 검사 \ 사장, 작성자, 팀장
     		
     		var report_id_list="";
     		var flag1=false;
     		$('.check_box:checked').each(function(){
     				report_id_list+=$(this).parent().parent().attr('id')+"_";
     				var writer=$(this).parent().parent().children().eq(8).text();
     				if(<%=user_level%>==3 && writer!='<%=user_id%>'){
         					flag1=true;	
     				}
     		});
     		if(report_id_list==""){
     			alert('보고서를 선택 해주세요');
     			return;
     		}
     		if(flag1){
     			alert('권한이 없는 보고서가 포함되어 있습니다');
     			return;
     		}
     		//alert(report_id_list);
     		
     		var url="./DelReportAction.cont?dept_id=<%=dept_id %>&page=<%=current_page %>&cmd=<%=cmd %>&value=<%=value %>";
     		url+="&report_id="+report_id_list;
     		
    		location.replace(url);
     	});
     	$('.approval').click(function(){
     		
     		var report_id=selected_item.attr('id');
     		
     		//작성자인지만 검사
     		
	   		<%
	   		for(int i=0; i<list.size(); i++)
	   		{
	   			int cost=0;
	   			String cnt=String.format("%010d",(Integer)list.get(i).get("dept_sequence"));
	   			int report_writer=(Integer)list.get(i).get("report_writer");
	   			String state=(String)list.get(i).get("report_state");
	   			
	   		%>
	   			if(report_id=='<%=list.get(i).get("report_id")%>')
	   			{
					$('#report_delay',top.document).val('');
	   				$('#report_write', top.document).contents().find('.modal-header').children('span').text('<%=list.get(i).get("report_title")%>');
	   				
		     		//제목 설정
		     		var dialog_content=$('#report_write', top.document).children('.modal-dialog').children('.modal-content').children('.modal-body');
		     		var swiper=dialog_content.children('.manage_right').children('.swiper-container').children('.swiper-wrapper');
		     		
		     		dialog_content.children().eq(0).text(report_id);
		     		dialog_content.children().eq(1).text(<%=list.get(i).get("report_writer")%>);
		     		dialog_content.children().eq(2).text(<%=dept_id%>);
		     		dialog_content.children().eq(3).text(<%=current_page%>);
		     		dialog_content.children().eq(4).text('<%=cmd%>');
		     		dialog_content.children().eq(5).text('<%=value%>');
		     		
		     		var top_table=dialog_content.children('.manage_left').children('.manage_table_area').children('.manage_table_title');
		     		top_table.children('.number').text('NO. '+'<%=cnt%>');
		     		top_table.children('.manage_report_title').children().val('<%=list.get(i).get("report_title")%>');
		     		top_table.children('.manage_report_title').children().prop('readonly',true);
		     		
		     		var top_table_left=dialog_content.children('.manage_left').children('.manage_table_area').children('.table_approval').children();
		     		
		     		var size=0;
		     		//승인 이미지 설정
	   				if('<%=state%>'=="play1") size=1;
	   				else if('<%=state%>'=="play2") size=2;
		     		else if('<%=state%>'=="finish") size=3;
					else size=0;
	   				
		     		for(var k=1; k<=3; k++){
		     			if(k<=size)
		     				top_table_left.children('tr').eq(1).children('td').eq(k).children('img').attr('src','../IMAGES/승인.png');
		     			else
		     				top_table_left.children('tr').eq(1).children('td').eq(k).children('img').attr('src','../IMAGES/비승인.png');
		     		}
		     		top_table_left.children('tr').eq(2).children('td').eq(1).children().prop('readonly',false);
		     			
		     		
		     		var foot_line=dialog_content.children('.manage_left').children('.manage_line').children('.manager_left').children('.manager_name');
		     		foot_line.children('.report_level').val('<%=list.get(i).get("level")%>');
		     		foot_line.children('.report_level').prop('disabled', true);
		     		
		     		
		     		$('.manage_line1',top.document).hide();
		     		$('.manage_line2',top.document).show();
		     		
		     		var table_content=dialog_content.children('.manage_left').children('.manage_table_area').children('.table_content').children().children('.table_content_line');
		     		
		     		for(var j=0; j<10; j++){
			   			for(var k=0; k<7; k++){
			   				table_content.eq(j).children('.table_content_info').eq(k).html("&nbsp;");	
			   			}
			   		}
			   		top.swiperH.removeAllSlides();
			   		
			   		<%
			   		ArrayList<HashMap> receipt_list=(ArrayList<HashMap>)list.get(i).get("receipt_list");
			   		for(int j=0; j<receipt_list.size(); j++)
			   		{
			   			String receipt_cnt=String.format("%010d",(Integer)receipt_list.get(j).get("dept_seq"));
			   			String date=(String)receipt_list.get(j).get("receipt_date");
			   			date=date.substring(0, date.lastIndexOf(":"));
			   			String payment=(String)receipt_list.get(j).get("payment");
			   			String pay="";
                 		if(payment.equals("cor"))
                 			pay="법인 카드";
                 		else
                 			pay="개인 카드";
                 		String receipt_cost=String.format("%,d",(Integer)receipt_list.get(j).get("receipt_cost"));
			   		%>
			   			var table_text=table_content.eq(<%=j%>).children('.table_content_info');
			   			table_text.eq(0).text(<%=receipt_list.get(j).get("receipt_id")%>);
			   			table_text.eq(1).text('<%=receipt_cnt%>');
			   			table_text.eq(2).text('<%=date%>');
			   			table_text.eq(3).text('<%=receipt_list.get(j).get("receipt_type")%>');
			   			table_text.eq(4).text('<%=pay%>');
			   			table_text.eq(5).text('<%=receipt_list.get(j).get("receipt_use")%>');
			   			table_text.eq(6).text('<%=receipt_cost%>');
			   			
			   			var receipt_img='<%=receipt_list.get(j).get("receipt_img")%>';
			   			top.swiperH.appendSlide('<div class="swiper-slide"><img src="../' + receipt_img + '"/></div>');
					<%
			   			cost+=(Integer)receipt_list.get(j).get("receipt_cost");
					}
			   		String cost_total=String.format("%,d",cost);
			   		%>
			   		$('.cost_total', top.document).text('<%=cost_total%>');
	   			}
	   		<%
	   		}
	   		%>
	   		//alert(selected_item.html());
	   		
	   		$('#report_write_btn', top.document).click();
			setTimeout(function(){
				//alert(dialog_content.children('.manage_left').height());
				top.swiperH.onResize();	
				dialog_content.children('.manage_right').css('height',dialog_content.children('.manage_left').height());
			},300);
			
     	});
     	$('.download').click(function(){
     		
     	});
     </script>
</body>
</html>