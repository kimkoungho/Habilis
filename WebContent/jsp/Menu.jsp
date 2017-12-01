<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
    
<%
	int user_id=(Integer)session.getAttribute("user_id");
	//사용자의 기본 부서 추출
	String []user_depts=((String)session.getAttribute("user_dept")).split(",");
	String []user_privs=((String)session.getAttribute("user_priv")).split(",");
	
	String []user_company=((String)session.getAttribute("user_dept")).split(",");
	
	
	ArrayList<HashMap<String, Object>> company_list=(ArrayList)session.getAttribute("com_list");
	
	ArrayList<HashMap> list=(ArrayList)request.getAttribute("dept_list");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8" />
	<title></title>
	
	<script src="${pageContext.request.contextPath}/include/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/include/jquery-ui.js"></script>
	
	<script src="${pageContext.request.contextPath}/js/Menu.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Menu.css">
	
	<!-- 달력 -->
	<script src='${pageContext.request.contextPath}/include/moment.min.js'></script>
	<script src="${pageContext.request.contextPath}/include/jquery.daterangepicker.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/daterangepicker.css" />
    
</head>
<body>
<script>
$(document).ready(function()
{
	   $(".sep_team").click(function()
	   {
	      if($(this).hasClass("on"))
	      {
	         $(".sep_team > img").attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
	         $(this).removeClass("on");
	      }
	      else
	      {
	         $(".sep_team > img").attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
	         $(this).children("img").attr('src', '${pageContext.request.contextPath}/IMAGES/expend.png');
	         $(this).addClass("on");
	      }
	   });
	   $(".fold_user_img").click(function(){
	      if($(this).hasClass("on"))
	      {
	         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
	         $(this).parent().siblings(".member_info_wrap").slideToggle();
	         $(this).removeClass("on");         
	      }
	      else
	      {
	         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
	         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/dropdown.png');
	         $(this).parent().siblings(".member_info_wrap").slideToggle();
	         $(this).addClass("on");
	      }
	   });
	   $(".fold_img").click(function()
    	{
	      if($(this).hasClass("on"))
	      {
	         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
	         $(this).parent().siblings(".report_option_sub_wrap").slideToggle();
	         $(this).removeClass("on");         
	      }
	      else
	      {
	         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
	         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/dropdown.png');
	         $(this).parent().siblings(".report_option_sub_wrap").slideToggle();
	         $(this).addClass("on");
	      }
	   });
	    $(".fold_menu_img").click(function()
   	    {
   		      if($(this).hasClass("on"))
   		      {
   		         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
   		         $(this).removeClass("on");         
   		      }
   		      else
   		      {
   		         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
   		         $(this).attr('src', '${pageContext.request.contextPath}/IMAGES/dropdown.png');
   		         $(this).addClass("on");
   		      }
   	   });
	    $("#pri_img").click(function()
	    {	
			if($(this).hasClass("on"))
			{
				$(this).attr('src', '${pageContext.request.contextPath}/IMAGES/ellipsis.png');
				$(".rank_wrap").slideToggle();
				$(this).removeClass("on");
			}
			else
			{				
				$(this).attr('src', '${pageContext.request.contextPath}/IMAGES/dropdown.png');
				$(".rank_wrap").slideToggle();
				$(this).addClass("on");
			}
	    });
});
</script>
    <div class="wrap">
        <!--아이콘 바-->
        <div class="side_bar">
            <div class="side_wrap">
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/user.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/team_information.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/dashboard.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/working_status_report.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/receipt.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/report.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/customer_center.png" />
				</div>
				<div class="menu">
					<img src="${pageContext.request.contextPath}/IMAGES/logout.png" />
				</div>
			</div>
        </div>
        <!--첫 번째 사이드 메뉴-->
        <div id="first_side">
        	<!--사용자  -->
        	<div class="menu_sub">
        		<div class="my_info_wrap" id="my_info_wrap">
			         <div class="my_info_menu">
			            <div class="close">사용자 관리</div>
			         </div>
			         <div class="my_info_cont">
			            <div class="my_info_pic">
			               <img src='${pageContext.request.contextPath}/<%=session.getAttribute("user_img") %>' />
			               <div class="my_info_modify">수정하기</div>
			            </div>
			            <div class="my_info_name"><%=session.getAttribute("user_name") %></div>
			            <div class="my_info_depart">
			               <span>
			               <%
			               if(company_list.size()>1)
			               {
			            	   out.println(company_list.get(0).get("dept_name"));
			               }
							%>
							</span>/ 
			               <span><%=session.getAttribute("user_position") %></span>
			            </div>
			         </div>
			         <div class="my_info_cont_sub">
			            <div class="my_info_tel">
			               <span class="info_title">Tel </span> <span class="info_cont"><%=session.getAttribute("user_tel") %></span>
			            </div>
			            <div class="my_info_phone">
			               <span class="info_title">Phone </span> <span class="info_cont"><%=session.getAttribute("user_phone") %></span>
			            </div>
			            <div class="my_info_mail">
			               <span class="info_title">E-mail</span> <span class="info_cont"><%=session.getAttribute("user_mail") %></span>
			            </div>
			            <div class="card_manage">
			               <span style="margin-left: 5%;">카드관리</span>
			               <img src="${pageContext.request.contextPath}/IMAGES/expend.png"  style="width: 5%; margin-top: 2%; float: right;">
			            </div>
			            <div class="pri_manage">
			            	 <span style="margin-left: 5%;" class="pri">권한범위</span>
			            	 <img class="direction" id="pri_img" src="${pageContext.request.contextPath}/IMAGES/ellipsis.png"  style="width: 5%; margin-top: 2%; float: right;">
			            	 <div class="rank_wrap">
			            	 	<div class="rank_info">0등급</div>
			            	 	<div class="rank_info">ALL(invite,read,write)</div>
			            	 	<div class="rank_info">1등급</div>
			            	 	<div class="rank_info">Part(invite,All Team_W/R)</div>
			            	 	<div class="rank_info">2등급</div>
			            	 	<div class="rank_info">Part(All Team_W/R)</div>
			            	 	<div class="rank_info">3등급</div>
			            	 	<div class="rank_info">Part(Our Team_W/R)</div>
			            	 </div>
			            </div>
			         </div>
		      	</div>
        	</div>
        	
        	<!-- 부서 관리 -->
            <div class="menu_sub">
                <div class="sub_title">
                    <span class="manage">부서 관리</span>
                    <%-- <img src="${pageContext.request.contextPath}/IMAGES/member_add.png" /> --%>
                </div>
                <div class="sub_index">
				    <div class="index_name">팀별</div>
				    <div class="index_img" style="float:right; margin-right:5%">
					    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png" style="width: 70%; margin-top:40%" />
				    </div>
			    </div>

			    <div class="split_line"></div>

			    <div class="sub_team_list">
                    <%
                    	for(int i=0; i<list.size(); i++)
                    	{
                    		HashMap<String, Object> dept=(HashMap)list.get(i).get("dept");
                    		ArrayList<HashMap> user_list=(ArrayList)list.get(i).get("user_list");
                    %>
	                    <div class="sep_team">
	                    	<div style="display:none;"><%=dept.get("dept_id")%></div>
	                        <div class="team_name"><%=dept.get("dept_name") %></div>
	                        <img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="direction" /> 
	                        <span class="amount"><%=user_list.size() %></span>
	                    </div>
                    <%
                    	}
                    %>
			    </div>
			    <div class="sub_btn" id="add_dept">
			    	<div class="sub_index">
				    	<div class="index_name" style="color:white">+ 부서추가</div>
			    	</div>
			    </div>
            </div>
            
            <!-- 대시 보드 -->
            <div class="menu_sub">
                <div class="sub_title">
                    <span class="manage">대시 보드</span>
                    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png"  />
                </div>
                <div class="sub_index">
				    <div class="index_name">팀 별</div>
				    <%-- <div class="index_img">
					    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png" style="width: 50%;" />
				    </div> --%>
			    </div>

			    <div class="split_line"></div>

			    <div class="sub_team_list">
                    <%
                    	for(int i=0; i<list.size(); i++)
                    	{
                    		HashMap<String, Object> dept=(HashMap)list.get(i).get("dept");
                    		ArrayList<HashMap> user_list=(ArrayList)list.get(i).get("user_list");
                    %>
	                    <div class="sep_team">
	                    	<div style="display:none;"><%=dept.get("dept_id")%></div>
	                        <div class="team_name"><%=dept.get("dept_name") %></div>
	                        <img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="direction" /> 
	                        <span class="amount"><%=user_list.size() %></span>
	                    </div>
                    <%
                    	}
                    %>
			    </div>
            </div>
            
            <!-- 업무 관리 -->
            <div class="menu_sub">
                <div class="sub_title">
                    <span class="manage">업무 관리</span>
                    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png" />
                </div>
                <div class="sub_index">
				    <div class="index_name">팀 별</div>
				    <%-- <div class="index_img">
					    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png" style="width: 50%;" />
				    </div> --%>
			    </div>

			    <div class="split_line"></div>

			    <div class="sub_team_list">
                    <%
                    	for(int i=0; i<list.size(); i++)
                    	{
                    		HashMap<String, Object> dept=(HashMap)list.get(i).get("dept");
                    		ArrayList<HashMap> user_list=(ArrayList)list.get(i).get("user_list");
                    %>
	                    <div class="sep_team">
	                    	<div style="display:none;"><%=dept.get("dept_id")%></div>
	                        <div class="team_name"><%=dept.get("dept_name") %></div>
	                        <img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="direction" /> 
	                        <span class="amount"><%=user_list.size() %></span>
	                    </div>
                    <%
                    	}
                    %>
			    </div>
            </div>
            
            <!-- 영수증 관리-->
            <div class="menu_sub">
                <div class="sub_title">
                    <span class="manage">영수증 관리</span>
                   
                </div>
                <div class="sub_index">
				    <div class="index_name">팀 별</div>
				    <%-- <div class="index_img">
					    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png" style="width: 50%;" />
				    </div> --%>
			    </div>

			    <div class="split_line"></div>

			    <div class="sub_team_list">
                    <%
                    	for(int i=0; i<list.size(); i++)
                    	{
                    		HashMap<String, Object> dept=(HashMap)list.get(i).get("dept");
                    		ArrayList<HashMap> user_list=(ArrayList)list.get(i).get("user_list");
                    %>
	                    <div class="sep_team">
	                    	<div style="display:none;"><%=dept.get("dept_id")%></div>
	                        <div class="team_name"><%=dept.get("dept_name") %></div>
	                        <img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="direction" /> 
	                        <span class="amount"><%=user_list.size() %></span>
	                    </div>
                    <%
                    	}
                    %>
			    </div>
            </div>
            
            <!-- 보고서 관리 -->
            <div class="menu_sub">
                <div class="sub_title">
                    <span class="manage">보고서 관리</span>
                   
                </div>
                <div class="sub_index">
				    <div class="index_name">팀 별</div>
				    <div class="index_img">
					    <img src="${pageContext.request.contextPath}/IMAGES/dropdown.png" style="width: 50%;" />
				    </div>
			    </div>

			    <div class="split_line"></div>

			    <div class="sub_team_list">
                   <%
                    	for(int i=0; i<list.size(); i++)
                    	{
                    		HashMap<String, Object> dept=(HashMap)list.get(i).get("dept");
                    		ArrayList<HashMap> user_list=(ArrayList)list.get(i).get("user_list");
                    %>
	                    <div class="sep_team">
	                    	<div style="display:none;"><%=dept.get("dept_id")%></div>
	                        <div class="team_name"><%=dept.get("dept_name") %></div>
	                        <img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="direction" /> 
	                        <span class="amount"><%=user_list.size() %></span>
	                    </div>
                    <%
                    	}
                    %>
			    </div>
			    <div class="sub_btn">
			    	<div class="sub_index">
				    	<div class="index_name" id="my_payment"  style="width:100%">
				    		결제목록
				    	</div>
			    	</div>
			    </div>
            </div>
            
            <!-- Q&A -->
            <div class="menu_sub">
            </div>
			
        </div>

        <!--두 번째 사이드 메뉴-->
        <div id="second_side">
        	<!-- 사용자 -->
        	<div class="sub_cont">
				
        	</div>
        	<!-- 팀원 정보 -->
            <div class="sub_cont">
                <div class="sub_search_wrap">
                    <img src="${pageContext.request.contextPath}/IMAGES/search.png" style="width: 10%; display: inline-block" />
                        <input type="text" class="search_bar" placeholder="search" />
                </div>

                <div class="split_line"></div>
                <!--부서별 멤버 정보-->
                <div class="member_detail_list">
	               	<%
	                   	for(int i=0; i<list.size(); i++)
	                   	{
	                   		ArrayList<HashMap<String, Object>> user_list=(ArrayList)list.get(i).get("user_list");
                   %>
	                    <div class="team_member">
	                    <%
	                    	for(int j=0; j<user_list.size(); j++)
	                    	{
	                    %>
	                        <div class="member_detail_wrap">
	                            <div class="member_icon">
	                            	<!-- profile_image -->
	                                <img src="${pageContext.request.contextPath}/<%=user_list.get(j).get("user_img") %>" />
	                            </div>
	                            <div class="detail_info_wrap">
	                                <div class="member_detail_name">
	                                    <%=user_list.get(j).get("user_name") %>
	                                    <img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_user_img" />
	                                </div>
	                                <div class="member_detail_position"><%=user_list.get(j).get("user_position") %></div>
	                                <div class="member_detail_part">Programming</div>
	                                <div class="member_info_wrap">
	                                    <div class="member_detail_part">Phone <%=user_list.get(j).get("user_phone") %></div>
	                                    <div class="member_detail_part">Tel <%=user_list.get(j).get("user_tel") %></div>
	                                </div>
	                            </div>
	                        </div>
						<%
	                    	}
						%>
	                    </div>
                   <%
                    	}
                   %>

                </div>
                
            </div>
			<!-- 대시 보드 -->
			<div class="sub_cont">
				<div class="sub_search_wrap">
					<img src="${pageContext.request.contextPath}/IMAGES/search.png" style="width: 5%; display: inline-block; margin-left: 5%;" />
						<input type="text" class="search_bar" placeholrder="search"/>
				</div>
				<div class="split_line"></div>
				<div class="report_option_list">
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>기간별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img"/>
						</div>
						<div class="report_option_sub_wrap">
							<div class="term_cri_wrap">
								<span class="term_cri" style="margin-left: 7.5%;">1주</span>
								<span class="term_cri">15일</span>
								<span class="term_cri">1개월</span>
								<span class="term_cri">3개월</span>
								<span class="term_cri">6개월</span>
							</div>
							<div class="search_date" id="dash_date">
								2016-09-01 ~ 2016-10-01
							</div>
						</div>
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>사용자별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_menu_img"  />
						</div>
						<%
							for(int i=0; i<list.size(); i++)
							{
								ArrayList<HashMap<String, Object>> user_list=(ArrayList)list.get(i).get("user_list");
						%>
							<div class="report_option_sub_wrap">
								<%
									for(int j=0; j<user_list.size(); j++)
									{
								%>
									<div class="report_status_list">
										<span class="#"><%=user_list.get(j).get("user_name") %></span>
										<span style="display:none;"><%=user_list.get(j).get("user_id") %></span>
										<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
									</div>
								<%
									}
								%>
							</div>
						<%
							}
						%>
					</div>
						
				</div>
			</div>
        	<!-- 업무 -->
        	<div class="sub_cont">
				<div class="sub_search_wrap">
					<img src="${pageContext.request.contextPath}/IMAGES/search.png" style="width: 10%; display: inline-block" />
					<input type="text" class="search_bar"  placeholder="search" />
				</div>
				<div class="split_line"></div>
				<div class="report_option_list">
				
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>상태별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img" />
						</div>
						<div class="report_option_sub_wrap">
							<div class="report_status_list">
								<span class="#">진행</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">승인</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">보류</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
						</div>
						
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>사용자별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_menu_img"  />
						</div>
						<%
							for(int i=0; i<list.size(); i++)
							{
								ArrayList<HashMap<String, Object>> user_list=(ArrayList)list.get(i).get("user_list");
						%>
							<div class="report_option_sub_wrap">
								<%
									for(int j=0; j<user_list.size(); j++)
									{
								%>
									<div class="report_status_list">
										<span class="#"><%=user_list.get(j).get("user_name") %></span> 
										<span style="display:none;"><%=user_list.get(j).get("user_id") %></span>
										<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
									</div>
								<%
									}
								%>
							</div>
						<%
							}
						%>
					</div>
					
				</div>
			</div>
        	<!--  영수증 -->
        	<div class="sub_cont">
				<div class="sub_search_wrap">
					<img src="${pageContext.request.contextPath}/IMAGES/search.png" style="width: 10%; display: inline-block" />
					<input type="text" class="search_bar"  placeholder="search"/>
				</div>
				<div class="split_line"></div>
				<div class="report_option_list">
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>기간별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img" />
						</div>
						<div class="report_option_sub_wrap">
							<div class="term_cri_wrap">
								<span class="term_cri" style="margin-left: 7.5%;">1주</span>
								<span class="term_cri">15일</span>
								<span class="term_cri">1개월</span>
								<span class="term_cri">3개월</span>
								<span class="term_cri">6개월</span>
							</div>
							<div class="search_date" id="receipt_date">
								2016-09-01 ~ 2016-10-01
							</div>
						</div>
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>분류별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img" />
						</div>
						<div class="report_option_sub_wrap">
							<div class="report_status_list">
								<span class="#">교통</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">식비</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">소모품</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">비품</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">기타</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
						</div>
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>상태별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img" />
						</div>
						<div class="report_option_sub_wrap">
							<div class="report_status_list">
								<span class="#">대기</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">진행</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">승인</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">보류</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
						</div>
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>사용자별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_menu_img"  />
						</div>
						<%
							for(int i=0; i<list.size(); i++)
							{
								ArrayList<HashMap<String, Object>> user_list=(ArrayList)list.get(i).get("user_list");
						%>
							<div class="report_option_sub_wrap">
								<%
									for(int j=0; j<user_list.size(); j++)
									{
								%>
									<div class="report_status_list">
										<span class="#"><%=user_list.get(j).get("user_name") %></span> 
										<span style="display:none;"><%=user_list.get(j).get("user_id") %></span>
										<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
									</div>
								<%
									}
								%>
							</div>
						<%
							}
						%>
					</div>
				</div>
			</div>
        	<!-- 보고서 -->
        	<div class="sub_cont">
       			<div class="sub_search_wrap">
       				<img src="${pageContext.request.contextPath}/IMAGES/search.png" style="width: 10%; display: inline-block" />
					<input type="text" class="search_bar"  placeholder="search"/>
       			</div>
       			<div class="split_line"></div>
       			<div class="report_option_list">
       				<div class="report_option_wrap">
						<div class="report_option_select">
							<span>기간별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img" />
						</div>
						<div class="report_option_sub_wrap">
							<div class="term_cri_wrap">
								<span class="term_cri" style="margin-left: 7.5%;">1주</span>
								<span class="term_cri">15일</span>
								<span class="term_cri">1개월</span>
								<span class="term_cri">3개월</span>
								<span class="term_cri">6개월</span>
							</div>
							<div class="search_date" id="report_date">
								2016-09-01 ~ 2016-10-01
							</div>
						</div>
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>상태별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_img" />
						</div>
						<div class="report_option_sub_wrap">
							<div class="report_status_list">
								<span class="#">대기</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">진행</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">승인</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
							<div class="report_status_list">
								<span class="#">보류</span> 
								<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
							</div>
						</div>
					</div>
					
					<div class="report_option_wrap">
						<div class="report_option_select">
							<span>사용자별 조회</span>
							<img src="${pageContext.request.contextPath}/IMAGES/ellipsis.png" class="fold_menu_img"  />
						</div>
						<%
							for(int i=0; i<list.size(); i++)
							{
								ArrayList<HashMap<String, Object>> user_list=(ArrayList)list.get(i).get("user_list");
						%>
							<div class="report_option_sub_wrap">
								<%
									for(int j=0; j<user_list.size(); j++)
									{
								%>
									<div class="report_status_list">
										<span class="#"><%=user_list.get(j).get("user_name") %></span> 
										<span style="display:none;"><%=user_list.get(j).get("user_id") %></span>
										<img src="${pageContext.request.contextPath}/IMAGES/expend.png" style="width: 5%; float: right;" />
									</div>
								<%
									}
								%>
							</div>
						<%
							}
						%>
					</div>
       			</div>
        	</div>
        	
        	<!-- QNA --> 
        	<div class="sub_cont"></div>
        </div>
    </div>
    <script>
	
    $('.card_manage').click(function(){
    	$(top.document).find(".center").attr('src','../CardListAction.cont');	
    });
    
    $('#my_payment').click(function(){
    	var query_str=$('#center',top.document).prop('src');
    	query_str=query_str.substring(query_str.indexOf("?")+1);
    	
    	var dept_id=query_str.split('&')[0];//필요없음
    	var page=1;
    	var cmd="my_payment";
    	var value=null;//사장=0, 팀장=1
    	
    	if(dept_id=='<%=user_company%>'){
    		value=0;
    	}else{
    		<%
        	for(int i=0; i<user_depts.length; i++)
        	{
        	%>
        		if(dept_id=='<%=user_depts[i]%>' && '<%=user_privs[i]%>'=='1')
        			value=1;
        	<%
        	}
        	%>
    	}
    	
		var url='../ReportListAction.cont?'+dept_id+'&page=1&cmd=my_payment&value='+value;
		$(top.document).find(".center").attr('src',url);
	}); 
    
	$(window).load(function() {
		
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
		$('body').css('height', $(window).innerHeight());
		
	});
	</script>
</body>
</html>