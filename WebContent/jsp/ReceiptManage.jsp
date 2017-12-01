<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	//String receipt_id=(String)request.getAttribute("receipt_id");
	ArrayList<HashMap> list=(ArrayList)request.getAttribute("receipt_list");
	ArrayList<String> user_names=(ArrayList)request.getAttribute("user_names");
	
	int dept_id=(Integer)request.getAttribute("dept_id");
	String cmd=(String)request.getAttribute("cmd");
	String value=(String)request.getAttribute("value");
	
	int current_page=(Integer)request.getAttribute("page");
	int total=(Integer)request.getAttribute("total");
	
	int report_id=(Integer)request.getAttribute("report_id");
	String report_id_str=String.format("%010d",report_id);
	int next_receipt=(Integer)request.getAttribute("n_receipt");
	
	int pages=0;
	if(total%20==0)
	{
		pages=total/20;
	}
	else
	{
		pages=total/20+1;
	}
	//System.out.println(pages);
	
	int user_id=(Integer)session.getAttribute("user_id");
	//사용자의 기본 부서 추출
	//int user_company=(Integer)session.getAttribute("user_company");
	
	//사용자의 팀의 계급 추출 \ 0 사장 \ 1 팀장 \ 2 작성자 \ 3 사원 
	int user_level=(Integer)request.getAttribute("level");
	
	int com_id=(Integer)request.getAttribute("company_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta charset="utf-8" />
	
	<script src="${pageContext.request.contextPath}/include/jquery.js"></script>
	<!-- 다이얼로그 -->
	<script src="${pageContext.request.contextPath}/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap.min.css"/>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/ReceiptManage.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/include/keyevent.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ReceiptManage.css">
	
	<link href='${pageContext.request.contextPath}/include/fullcalendar.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/include/fullcalendar.print.css' rel='stylesheet' media='print' />
		
	<script src='${pageContext.request.contextPath}/include/moment.min.js'></script>
	<script src='${pageContext.request.contextPath}/include/fullcalendar.min.js'></script>
	
	<script src="${pageContext.request.contextPath}/include/jquery.daterangepicker.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/daterangepicker.css" />
	<!--  -->
	
</head>
<body>
<div id="wrap">
	<div id="company_id" style="display:none;"><%=com_id %></div>
	<div id="depart_id" style="display:none;"><%=dept_id %></div>
	<div class="content_menu">
		<div class="menu_name">RECEIPT MANAGE</div>
	</div>
	<div class="tab_menu">
		<span class="tab_list" style="color:black; border:2px solid #0078a7; border-bottom:none;box-sizing:border-box; background-color:white;"><span class="tab_vertical">목록보기</span></span>
		<span class="tab_all"  style="border-bottom:2px solid #0078a7; box-sizing:border-box"><span class="tab_vertical">한눈에 보기</span></span>
		<span class="tab_plus"  style="border-bottom:2px solid #0078a7; box-sizing:border-box"><span class="tab_vertical">추가하기</span></span>
	</div>
	<div class="tab_wrap">
      <div class="report_wrap">
         <div class="report_sub_wrap">
            <div class="table_wrap">
               <table style="width: 100%">
                  <tr class="report_menu">
                     <th>일시</th>
                     <th>업체명</th>
                     <th>분류</th>
                     <th>결제방법</th>
                     <th>금액</th>
                     <th>상태</th>
                     <th>영수증보기</th>
                  </tr>
                  <%
                  for(int i=0; i<list.size(); i++)
                  {
                	  String receipt_date=(String)list.get(i).get("receipt_date");
                	  receipt_date=receipt_date.substring(0,receipt_date.lastIndexOf(":"));
                	  
                	  String cnt=String.format("%010d",(Integer)list.get(i).get("dept_seq"));
                  %>
                  <tr class="report_cont_line" id="<%=list.get(i).get("receipt_id")%>">
                     <!-- receipt_id -->
                     <td style="display:none;"><%=cnt%></td>
                     <td class="report_cont_info" style="display:none;"><%=user_names.get(i) %></td>
                     <td class="report_cont_info" style="display:none;"><%=list.get(i).get("receipt_img") %></td>
                     <td style="display:none;"><input type="checkbox" name="check_box" class="check_box" /></td>
                     <td class="report_cont_info"><%=receipt_date%></td>
                     <td class="report_cont_info"><%=list.get(i).get("receipt_use") %></td>
                     <td class="report_cont_info"><%=list.get(i).get("receipt_type") %></td>
                     <td class="report_cont_info">
                     	<%
                     		String payment=(String)list.get(i).get("payment");
                     		if(payment.equals("cor"))
                     			out.println("법인 카드");
                     		else
                     			out.println("개인 카드");
                     	%>
                     </td>
                     <td class="report_cont_info">
                     	<%
                     		String cost=String.format("%,d",((Integer)list.get(i).get("receipt_cost")));
                     		out.println(cost);
                     	%>
                     </td>
                     <td class="report_cont_info">
                     	<%
                     		String state=(String)list.get(i).get("receipt_state");
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
                     <td class="report_cont_info" style="display:none;"><%=list.get(i).get("level") %></td>
                     <td class="report_cont_info" style="display:none;"><%=list.get(i).get("comment") %></td>
                     <td class="report_cont_info" style="width:20%">
                     	<img src="${pageContext.request.contextPath}/IMAGES/basic.png" class="receipt_img_icon"/>
                     </td>
                     <td style="display:none;"><%=list.get(i).get("receipt_writer")%></td>
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
		               <span class="write_report">보고서 쓰기</span>
	               </span>
	            </div>
	            <div class="page">
	            
					<%
					String page_url="./ReceiptListAction.cont?dept_id="+dept_id+"&cmd="+cmd+"&value="+value+"&page=";
					int prev=current_page-1, next=current_page+1;
					%>
						<span>
							<%
							if(prev>=1)
							{
							%>
								<a href='<%=page_url+(prev) %>'>
									<img src="${pageContext.request.contextPath}/IMAGES/pageNavi_l.png" class="page_nav_icon"/>
								</a>
							<%
							}
							else
							{
							%>
								<img src="${pageContext.request.contextPath}/IMAGES/pageNavi_l.png" class="page_nav_icon"/>
							<%
							}
							%>
						</span>
					<%
						if(prev>=1){
							if(prev!=1){
								out.println("<span><a href='"+page_url+1+"'>"+1+"</a></span>");
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
            <div class="modify">수정하기</div>
            <div class="delete">삭제하기</div>
            <div class="detail">정보보기</div>
         </div>
         
      </div>
   </div>
	<div class="tab_wrap" style="display: none;">
		<div class="wrap_inner">
         	<div id='calendar'></div>
      	</div>
	</div>

	<div class="tab_wrap" style="display: none;">
	<form id="fileform" name="receipt_write" method="post" encType="multipart/form-data" action="./InsertReceiptAction.cont?dept_id=<%=dept_id %>&page=<%=current_page %>&cmd=<%=cmd %>&value=<%=value %>">
	
		<div class="content_info">
	         <div class="member_title">NO. <%=String.format("%010d",next_receipt) %></div>
	         <table class="member_sub_wrap">
	         <tbody>
	                <tr class="member_user">
	                   <td class="member_first">담당자</td>
	                     <td class="member_second">
	                        <%=session.getAttribute("user_name") %>
	                     </td>
	                     <td class="member_first">파일첨부</td>
	                     <td class="member_second">
	                     	<input type="text" name="img" class="member_textfield" id="img"/>
	                     	<input type="file" name="r_img" id="r_img" style="display:none;" />
	                    	<img src="${pageContext.request.contextPath}/IMAGES/readingglass_black.bmp" id="receipt_img" style="width: auto; height: 50%;"/>
	                     </td>
	               </tr>
	               
	               <tr class="member_user">
	                  <td class="member_first">업체명</td>
	                  <td class="member_second"><input type="text" name="use" class="member_Thrid" id="use" /></td>
	                  <td class="member_first"></td>
	                  <td rowspan="7" class="member_pic">
	                  		<div id="pic">
	                        	<img src="${pageContext.request.contextPath}/IMAGES/no_image.png" style="height:100%"/>
	                        </div>
	                  </td>
	               </tr>
	               <tr class="member_user">
	                  <td class="member_first">영수일시</td>
	                  <td class="member_second">
	                  	<input type="text" name="use_date" class="use_date" id="use_date" />
	                  	<img src="${pageContext.request.contextPath}/IMAGES/calendar.bmp" style="width: auto; height: 60%;"/>
	                  </td>
	                  <td class="member_first"></td>
	               </tr>
	               <tr class="member_user">
	                  <td class="member_first">영수금액</td>
	                  <td class="member_second"><input type="text" name="cost" class="member_Thrid" id="cost" onKeyDown="NumKey()" /></td>
	                  <td class="member_first"></td>
	               </tr>
	               <tr class="member_user">
	                  <td class="member_first">분 류</td>
	                  <td class="member_second">
	                     <select name="type" class="member_Thrid" id="type" >
	                        <option value="0">선택하시오</option>
	                        <option value="교통">교통</option>
	                        <option value="식비">식비</option>
	                        <option value="소모품">소모품</option>
	                        <option value="비품">비품</option>
	                        <option value="기타">기타</option>
	                     </select>
	                  </td>
	                  <td class="member_first"></td>
	               </tr>
	               <tr class="member_user">
	                  <td class="member_first">결제방법</td>
	                  <td class="member_second">
	                     <select name="card" class="member_Thrid" id="card" >
	                        <option value="0">선택하시오</option>
	                        <option value="per">개인카드</option>
	                        <option value="cor">법인카드</option>
	                     </select>
	                 </td>
	                 <td class="member_first"></td>
	               </tr>
	               <tr class="member_user">
	                  <td class="member_first">등급</td>
	                  <td class="member_second" style="border-bottom:1px solid #a0a4a7">
	                     <select name="level" class="member_Thrid" id="level" >
	                        <option value="0">선택하시오</option>
	                        <option value=1>극비</option>
	                        <option value=2>대외비 Ⅰ</option>
	                        <option value=3>대외비 Ⅱ</option>
	                        <option value=4>일반 </option>
	                     </select>
	                  </td>
	                  <td class="member_first"></td>
	               </tr>
	               <tr class="member_user">
	                  <td class="member_first">메 모</td>
	                  <td class="member_text">
	                     <textarea class="member_textarea" name="comment" rows="7" id="comment" ></textarea>
	                  </td>                  
	               </tr>
	            </tbody>
	            </table>
	            
	         <div class="button_wrap">
	            <div class="wrap_button_cancel">취소</div>
	            <div class="wrap_button_save">저 장</div>
	            <div id="ocr_button">분 석</div>
	      </div>
	</form>
	</div>
</div>

<button class="btn btn-primary" id="receipt_detail_btn" data-toggle="modal" data-target="#receipt_detail" style="display:none"></button>
<div class="modal fade" id="receipt_detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <!-- <div class="header_info"> -->
					<span>정보보기</span>
				<!-- </div> -->
            </div>
            <div class="modal-body">
                <div class="content_info">
			         <div class="member_title">NO. </div>
			         <table class="member_sub_wrap">
			         <tbody>
			                <tr class="member_user">
			                   <td class="member_first">담당자</td>
			                     <td class="member_second">
			                        
			                     </td>
			                     <td class="member_first">파일첨부</td>
			                     <td rowspan="8" class="member_pic">
			                        <img src="${pageContext.request.contextPath}/IMAGES/report.png" />
			                  </td>
			               </tr>
			               
			               <tr class="member_user">
			                  <td class="member_first">업체명</td>
			                  <td class="member_second"><input type="text" name="use" class="member_Thrid" readonly="readonly"/></td>
			                  <td class="member_first"></td>
			               </tr>
			               <tr class="member_user">
			                  <td class="member_first">영수일시</td>
			                  <td class="member_second">
			                  	<input type="text" name="use_date" class="use_date" readonly="readonly"/>
			                  	<img src="${pageContext.request.contextPath}/IMAGES/calendar.bmp" style="width: auto; height: 60%;"/>
			                  </td>
			                  <td class="member_first"></td>
			               </tr>
			               <tr class="member_user">
			                  <td class="member_first">영수금액</td>
			                  <td class="member_second"><input type="text" name="cost" class="member_Thrid" readonly="readonly"/></td>
			                  <td class="member_first"></td>
			               </tr>
			               <tr class="member_user">
			                  <td class="member_first">분 류</td>
			                  <td class="member_second">
			                     <select name="type" class="member_Thrid" disabled>
			                        <option value="0">선택하시오</option>
			                        <option value="교통">교통</option>
			                        <option value="식비">식비</option>
			                        <option value="소모품">소모품</option>
			                        <option value="비품">비품</option>
			                        <option value="기타">기타</option>
			                     </select>
			                  </td>
			                  <td class="member_first"></td>
			               </tr>
			               <tr class="member_user">
			                  <td class="member_first">결제방법</td>
			                  <td class="member_second">
			                     <select name="card" class="member_Thrid" disabled>
			                        <option value="0">선택하시오</option>
			                        <option value="per">개인카드</option>
			                        <option value="cor">법인카드</option>
			                     </select>
			                 </td>
			                 <td class="member_first"></td>
			               </tr>
			               <tr class="member_user">
			                  <td class="member_first">등급</td>
			                  <td class="member_second">
			                     <select name="level" class="member_Thrid" disabled>
			                        <option value="0">선택하시오</option>
			                        <option value=1>극비</option>
			                        <option value=2>대외비 Ⅰ</option>
			                        <option value=3>대외비 Ⅱ</option>
			                        <option value=4>일반 </option>
			                     </select>
			                  </td>
			                  <td class="member_first"></td>
			               </tr>
			               <tr class="member_user">
			                  <td class="member_first">메 모</td>
			                  <td class="member_text">
			                     <textarea class="member_textarea" name="comment" rows="7" readonly="readonly"></textarea>
			                  </td>                  
			               </tr>
			            </tbody>
			            </table>
                    
	            </div>
	        </div>
	    </div>
	</div>
</div>

<button class="btn btn-primary" id="receipt_modify_btn" data-toggle="modal" data-target="#receipt_modify" style="display:none"></button>
<div class="modal fade" id="receipt_modify" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span>수정 하기</span>
            </div>
            <div class="modal-body">
				<form name="receipt_modify" method="post" action="./ModifyReceiptAction.cont?dept_id=<%=dept_id %>&page=<%=current_page %>&cmd=<%=cmd %>&value=<%=value %>" encType="multipart/form-data">
					<div class="content_info">
				         <div class="member_title">NO. </div>
				         <table class="member_sub_wrap">
				         <tbody>
				                <tr class="member_user">
				                   <td class="member_first">담당자</td>
				                     <td class="member_second">
				                        
				                     </td>
				                     <td class="member_first">파일첨부</td>
				                     <td class="member_second">
				                     	<input type="text" name="img" class="member_textfield" id="modify_img"/>
				                     	<input type="file" name="r_img" id="r_modify_img" style="display:none;" />
				                    	<img src="${pageContext.request.contextPath}/IMAGES/readingglass_black.bmp" id="modify_receipt_img" style="width: auto; height: 50%;"/>
				                     </td>
				               </tr>
				               
				               <tr class="member_user">
				                  <td class="member_first">업체명</td>
				                  <td class="member_second"><input type="text" name="use" class="member_Thrid" id="modify_use" /></td>
				                  <td class="member_first"></td>
				                  <td rowspan="7" class="member_pic">
				                  		<div id="modify_pic">
				                        	<img src="${pageContext.request.contextPath}/IMAGES/report.png" />
				                        </div>
				                  </td>
				               </tr>
				               <tr class="member_user">
				                  <td class="member_first">영수일시</td>
				                  <td class="member_second">
				                  	<input type="text" name="use_date" class="use_date" id="modify_use_date" />
				                  	<img src="${pageContext.request.contextPath}/IMAGES/calendar.bmp" style="width: auto; height: 60%;"/>
				                  </td>
				                  <td class="member_first"></td>
				               </tr>
				               <tr class="member_user">
				                  <td class="member_first">영수금액</td>
				                  <td class="member_second"><input type="text" name="cost" class="member_Thrid" id="modify_cost" onKeyDown="NumKey()" /></td>
				                  <td class="member_first"></td>
				               </tr>
				               <tr class="member_user">
				                  <td class="member_first">분 류</td>
				                  <td class="member_second">
				                     <select name="type" class="member_Thrid" id="modify_type" >
				                        <option value="0">선택하시오</option>
				                        <option value="교통">교통</option>
				                        <option value="식비">식비</option>
				                        <option value="소모품">소모품</option>
				                        <option value="비품">비품</option>
				                        <option value="기타">기타</option>
				                     </select>
				                  </td>
				                  <td class="member_first"></td>
				               </tr>
				               <tr class="member_user">
				                  <td class="member_first">결제방법</td>
				                  <td class="member_second">
				                     <select name="card" class="member_Thrid" id="modify_card" >
				                        <option value="0">선택하시오</option>
				                        <option value="per">개인카드</option>
				                        <option value="cor">법인카드</option>
				                     </select>
				                 </td>
				                 <td class="member_first"></td>
				               </tr>
				               <tr class="member_user">
				                  <td class="member_first">등급</td>
				                  <td class="member_second">
				                     <select name="level" class="member_Thrid" id="modify_level" >
				                        <option value="0">선택하시오</option>
				                        <option value=1>극비</option>
				                        <option value=2>대외비 Ⅰ</option>
				                        <option value=3>대외비 Ⅱ</option>
				                        <option value=4>일반 </option>
				                     </select>
				                  </td>
				                  <td class="member_first"></td>
				               </tr>
				               <tr class="member_user">
				                  <td class="member_first">메 모</td>
				                  <td class="member_text">
				                     <textarea class="member_textarea" name="comment" rows="7" id="modify_comment"></textarea>
				                  </td>                  
				               </tr>
				            </tbody>
				            </table>
				            
				         <div class="button_wrap">
				            <div class="wrap_button_modify">수정 하기</div>
				         </div>
				      </div>
					<input type="text" name="receipt_id" id="receipt_modify_id" style="display:none;">
				</form>
			</div>
    	</div>
	</div>
</div>

<div id="receipt_img_detail">
	<img src="${pageContext.request.contextPath}/IMAGES/receipt.png" />
</div>
<div id="schedule_detail" >
</div>
<!-- ocr -->
<button class="btn btn-primary" id="ocr_analy_btn" data-toggle="modal" data-target="#ocr_analy" style="display:none"></button>
<div class="modal fade" id="ocr_analy" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="width:55%; margin-top:5%">
		<div class="modal-content">
    		<div class="modal-header">
        		<button type="button" id="ocr_close_btn" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
      			<span>영수증 분석</span>
      		</div>
      	</div>
		<div class="modal-body" style="background-color:white">
			<div class="content_info">
      			<table class="ocr_sub_wrap">
      				<tbody>
           				<tr class="ocr_user">
               				<td class="ocr_first"><div class="ocr_name">업체명</div></td>
               				<td class="ocr_second"><input type="text" name="use" class="ocr_Thrid" id="ocr" /></td>
            			</tr>
			            <tr class="ocr_user">
			               <td class="ocr_first">영수일시</td>
			               <td class="ocr_second">
			                  <input type="text" name="use_date" class="ocr_Thrid" id="ocr_date" />
			               </td>
			            </tr>
			            <tr class="ocr_user">
			               <td class="ocr_first">영수금액</td>
			               <td class="ocr_second"><input type="text" name="cost" class="ocr_Thrid" id="ocr_cost" onKeyDown="NumKey()" /></td>
			            </tr>
                  	</tbody>
            	</table>
				<div class="ocr_button_wrap">
				   <div class="ocr_button_cancel">취 소</div>
				   <div class="ocr_button_save">저  장</div>
				</div>
				<code style="white-space:pre" id="results"></code>
			</div>
		</div>
	</div>
</div>



<script>
	
	$('.write_report').click(function(){
		$('#report_delay',top.document).val('');
		$('#report_write', top.document).contents().find('.modal-header').children('span').text('새 보고서 작성');
		 //선택된 아이템들의 정보 추출
		 var dialog_content=$('#report_write', top.document).children('.modal-dialog').children('.modal-content').children('.modal-body');
		 var swiper=dialog_content.children('.manage_right').children('.swiper-container').children('.swiper-wrapper');
		 
		 dialog_content.children().eq(2).text('<%=dept_id%>');
		 dialog_content.children().eq(1).text('<%=user_id%>');
		 
		 var top_table=dialog_content.children('.manage_left').children('.manage_table_area').children('.manage_table_title');
  		 top_table.children('.number').text('NO. '+'<%=report_id_str%>');
  		 top_table.children('.manage_report_title').children().val('');
  		 top_table.children('.manage_report_title').children().prop('readonly',false);
  		 
  		var top_table_left=dialog_content.children('.manage_left').children('.manage_table_area').children('.table_approval').children();
			
 		for(var k=1; k<=3; k++){
 			top_table_left.children('tr').eq(1).children('td').eq(k).children('img').attr('src','../IMAGES/disapprove.png');
 		}
 		top_table_left.children('tr').eq(2).children('td').eq(1).children().prop('readonly',true);
 		
  		
  		 var foot_line=dialog_content.children('.manage_left').children('.manage_line').children('.manager_left').children('.manager_name');
  		 foot_line.children('.report_level').val('0');
  		 foot_line.children('.report_level').prop('disabled', false);
  		
  		
  		 $('.manage_line2',top.document).hide();
  		 $('.manage_line1',top.document).show();
		 
		 
		 var table_content=dialog_content.children('.manage_left').children('.manage_table_area').children('.table_content').children().children('.table_content_line');
		 var i=0;
		 var state_flag=false;
		
		 for(var j=0; j<10; j++){
			 for(var k=0; k<7; k++){
				 table_content.eq(j).children('.table_content_info').eq(k).html("&nbsp;");	
			 }
		 }
		 top.swiperH.removeAllSlides();
		 
		 var cost=0;
		 //swiper.css('height',dialog_content.children('.manage_left').height());
		//alert(table_content.html());	
		
		 $('.check_box:checked').each(function(){
			if(state_flag || i>10) return;
			
			var parent=$(this).parent().parent('.report_cont_line');
			
			var receipt_state=parent.children().eq(9).text();
			receipt_state=receipt_state.trim();
			if(receipt_state!="대기중"){
				alert('처리된 영수증이 포함되어 있습니다.');
				state_flag=true;
				return;
			}
			
			var receipt_id=parent.attr('id');
			var receipt_num=parent.children().eq(0).text();
			var receipt_date=parent.children().eq(4).text();
			var receipt_type=parent.children().eq(6).text();
			var receipt_payment=parent.children().eq(7).text();
			var receipt_use=parent.children().eq(5).text();
			var receipt_cost=parent.children().eq(8).text();
			
		
			var receipt_img=parent.children().eq(2).text();
			
			//alert(swiper.eq(i).html());
			//swiper.children('.swiper-slide').eq(i).children().prop('src',"../"+receipt_img);
			top.swiperH.appendSlide('<div class="swiper-slide"><img src="../' + receipt_img + '"/></div>');
			
			table_content.eq(i).children('.table_content_info').eq(0).html(receipt_id);
			table_content.eq(i).children('.table_content_info').eq(1).html(receipt_num);
			table_content.eq(i).children('.table_content_info').eq(2).html(receipt_date);
			table_content.eq(i).children('.table_content_info').eq(3).html(receipt_type);
			table_content.eq(i).children('.table_content_info').eq(4).html(receipt_payment);
			table_content.eq(i).children('.table_content_info').eq(5).html(receipt_use);
			table_content.eq(i).children('.table_content_info').eq(6).html(receipt_cost);
			
			receipt_cost=receipt_cost.replace(/\,/g,'');
			cost+=Number(receipt_cost);
			
			i=i+1;
// 		
			//console.log(receipt_id+"_"+receipt_num+"_"+receipt_date+"_"+receipt_type+"_"+receipt_payment+"_"+receipt_use+"_"+receipt_cost+"_"+receipt_img);

			
		});
		 
		 $('.cost_total', top.document).text(cost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		 //alert(top.swiperH);
		 //해당 정보로 다이얼로그 셋팅
		 if(!state_flag){
			 //top.swiperSet();
			$('#report_write_btn', top.document).click();
			setTimeout(function(){
				//alert(dialog_content.children('.manage_left').height());
				top.swiperH.onResize();	
				dialog_content.children('.manage_right').css('height',dialog_content.children('.manage_left').height());
			},300);
			
		 }
	});
 	function checkedForm(form){
 		if(!form.use.value){
			alert('업체명을 입력하세요');
			form.use.focus();
			return;
		}
		if(!form.r_img.value && form==document.receipt_write){
			alert('이미지를 입력하세요');
			form.r_img.focus();
			return;
		}
		if(!form.use_date.value){
			alert('날짜를 선택하세요');
			form.use_date.focus();
			return;
		}
		if(!form.cost.value){
			alert('비용을 입력하세요');
			form.cost.focus();
			return;
		}
		if(!form.type.value || form.type.value=="0"){
			alert('분류를 선택하세요');
			form.type.focus();
			return;
		}
		if(!form.card.value || form.card.value=="0"){
			alert('결제방법을 선택하세요');
			form.card.focus();
			return;
		}
		if(!form.level.value || form.level.value=="0"){
			alert('등급을 선택하세요');
			form.level.focus();
			return;
		}
		form.submit();
 	}
 	$('.wrap_button_modify').click(function(){
 		var form=document.receipt_modify;
 		var cost=form.cost.value;
 		cost=cost.replace(/[^0-9]/g,'');
 		form.cost.value=cost;
 		//유효성 검사
 		checkedForm(form);
 	});
	$('.wrap_button_save').click(function(){
		var form=document.receipt_write;
		//유효성 검사
		checkedForm(form);
	});
	$('.wrap_button_cancel').click(function(){
		//var form=$(this).parent('.button_wrap').parent('.content_info').parent();
		var form=document.receipt_write;
		for(var i=0; i<form.elements.length; i++){
			if(i>3 && i<7){
				form.elements[i].value="0";
			}else{
				
			}
		}
	});
	$('.modify').click(function(){
		var user=selected_item.children().eq(13).text();
		if(<%=user_level%>==3 && user!='<%=user_id%>'){
			alert('수정할 권한이 없습니다');
			return;
		}else{
			dialogSet('#receipt_modify');
			$('#receipt_modify_btn').click();	
		}
	});
	$('.delete').click(function()
			{
		var user=selected_item.children().eq(13).text();
		if(<%=user_level%>==3 && user!='<%=user_id%>')
		{
			alert('삭제할 권한이 없습니다');
			return;
		}
		else
		{
			var url="./DelReceiptAction.cont?dept_id=<%=dept_id %>&page=<%=current_page %>&cmd=<%=cmd %>&value=<%=value %>&receipt_id="+selected_item.attr('id')+",";
			location.replace(url);	
		}
		
	});
	$('.select_delete').click(function(){
		//$('.check_box').
		var id_list="";
		var flag1=false;
		$('.check_box:checked').each(function(){
			id_list=id_list+$(this).parent().parent().attr('id')+",";
			var writer=$(this).parent().parent().children().eq(8).text();
			if(<%=user_level%>==3 && writer!='<%=user_id%>'){
					flag1=true;	
			}
		});
		if(id_list==""){
 			alert('보고서를 선택 해주세요');
 			return;
 		}
 		if(flag1){
 			alert('권한이 없는 보고서가 포함되어 있습니다');
 			return;
 		}
		var url="./DelReceiptAction.cont?dept_id=<%=dept_id %>&page=<%=current_page %>&cmd=<%=cmd %>&value=<%=value %>&receipt_id="+id_list;
		location.replace(url);
	});
	$('#calendar').fullCalendar({
        header: {
           left: 'prev, today',
           center: 'title',
           right: 'month, next'
        },
        defaultDate: '2016-11-01',
        navLinks: true, // can click day/week names to navigate views
        selectable: true,
        selectHelper: true,
        select: function(start, end) {
           var eventData;
           if (title){
              eventData = {
                 title: title,
                 start: start,
                 end: end
              };
              $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
           }
           $('#calendar').fullCalendar('unselect');
        },
        editable: false,
        eventLimit: true, // allow "more" link when too many events
        events:[
                <%
                for(int i=0; i<list.size(); i++)
                {
                	String title=(String)list.get(i).get("receipt_use")+" - "+(Integer)list.get(i).get("receipt_cost")+" - "+(String)list.get(i).get("receipt_type");
                	
                %>
                //누적인지 확인
                {
                	title:'<%=title%>',
                	start:'<%=((String)(list.get(i).get("receipt_date"))).substring(0,10)%>'
                }
                <%
                		if(i!=list.size()-1)
                			out.println(",");
                }
                %>
		],
        eventClick: function(event)
        {
        	var title=event.title;
        	var start=event.start;
        	
        	//alert(title);
           	var position = $(this).offset();
           	$("#schedule_detail").css('top',position.top);
           	$("#schedule_detail").css('left',position.left+$(this).parent().width());
           	
           	//alert($("#schedule_detail").html());
           	$("#schedule_detail").text(title);
           	$("#schedule_detail").slideToggle(500,function(){
           		calendar_flag=true;
           	});
           	
        }
     });
    
	$(window).load(function() {
		var hei = $(".tab_wrap").eq(0).outerHeight();
	    $('#calendar').fullCalendar('option', 'height', hei*0.8);
	   
	    $('#calendar').fullCalendar('render');
	    
	    $('.date-picker-wrapper').css("z-Index",9999);
	    $('.hour-range').css('display','inline-block');
	    $('.minute-range').css('display','inline-block');
		/* var events=new Array();     
	     event = new Object();       
	     event.title = '눈물이 앞을 가린다'; 
	     event.start = '2016-11-14';    // its a date string
	     events.push(event);
	     $('#calendar').fullCalendar('addEventSource',events); */
	    
	     
	     
	});
	// resize가 최종완료되기전까지 resize 이벤트를 무시(최대화의 경우 resize가 계속발생하는 것을 방지)
	$(window).resize(function() {
		if( this.resizeTO )
	        clearTimeout(this.resizeTO);
	
	    this.resizeTO = setTimeout(function() {
	        $(this).trigger('resizeEnd');
	    }, 0);
	});
	// resize가 최종완료된 후 실행되는 callback 함수
	$(window).on('resizeEnd', function() {
		
	});
</script>
</body>
</html>