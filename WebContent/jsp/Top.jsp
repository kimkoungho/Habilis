<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//로그인 시 회원정보와 회사명 리스트 추출
//ArrayList<HashMap<String, Object>> company_list=new ArrayList<HashMap<String, Object>>();


/* String []test_list=new String[]{
	"구글","MS", "IBM", "넷플릭스"
};
for(int i=0; i<test_list.length; i++){
	HashMap<String, Object> hash1=new HashMap<String, Object>();
	hash1.put("id",Integer.toString(i));
	hash1.put("name",test_list[i]);
	company_list.add(hash1);
} */
//가정

	ArrayList<HashMap<String, Object>> company_list=(ArrayList)session.getAttribute("com_list");
	//System.out.println("회사리스트");
	//System.out.println(company_list);
	
	
	ArrayList<Boolean> boss_list=(ArrayList)session.getAttribute("boss_list");
	System.out.println(boss_list);
	//사용자의 회사의 직급 알아내기 
	//회사의 부서=사용자의 기본 부서 -> 사장
	//String user_coms=(String)session.getAttribute("user_company");
	
	//int user_company=Integer.parseInt(user_coms.split(",")[0]);
	//사용자의 기본 부서 권한 1 이면 팀장
	//session.setAttribute("user_level",0);
	//session.setAttribute("user", user_info);
	
	String []user_depts=((String)session.getAttribute("user_dept")).split(",");
	String []user_privs=((String)session.getAttribute("user_priv")).split(",");	
	int user_id=(Integer)session.getAttribute("user_id");
	
	
	String user_img=(String)session.getAttribute("user_img");
	user_img="../public"+user_img.substring(user_img.indexOf("/"));
	
	
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<title></title>
	<meta charset="utf-8" />
	
	<script src="${pageContext.request.contextPath}/include/jquery.js"></script>
	
	<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
    <script src="${pageContext.request.contextPath}/include/jquery-ui.js"></script>
	
	<script src="${pageContext.request.contextPath}/include/keyevent.js"></script>
	<script src="${pageContext.request.contextPath}/js/Top.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Top.css">
	
	<script src='${pageContext.request.contextPath}/include/moment.min.js'></script>
	<script src="${pageContext.request.contextPath}/include/jquery.daterangepicker.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/include/daterangepicker.css" />
    
    <script src="${pageContext.request.contextPath}/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap.min.css"/>
    
	<link rel="stylesheet" href="${pageContext.request.contextPath}/include/swiper.min.css">
	<script src="${pageContext.request.contextPath}/include/swiper.min.js"></script>
    
    <!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
    
</head>
<body>
	<div class="top_wrap">
		<iframe class="left_side" id="left_side" frameborder="0" src="${pageContext.request.contextPath}/DeptListAction.cont"></iframe>
		<iframe class="center" id="center" frameborder="0" src=""></iframe>
	</div>
	<iframe class="chatting" id="chatting" frameborder="0" src='http://localhost:3000/?user_name=<%=session.getAttribute("user_name")%>&user_img=<%=user_img%>&=dept_id=<%=user_depts[0]%>'></iframe>
<!-- 달력 3개 -->
<div id="date_dialog">
	<input type="text" id="receipt_date"  style="display:none"/>
	<input type="text" id="dash_date" style="display:none"/>
	<input type="text" id="report_date" style="display:none"/>
</div>
	<!--  -->
<button class="btn btn-primary" id="report_write_btn" data-toggle="modal" data-target="#report_write" style="display:none"></button>
<div class="modal fade" id="report_write" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span>새 보고서 작성</span>
            </div>
            <div class="modal-body">
            	<div style="display:none;"></div>
            	<div style="display:none;"></div>
            	<div style="display:none;"></div>
            	<div style="display:none;"></div>
            	<div style="display:none;"></div>
            	<div style="display:none;"></div>
            	<div class="manage_left">
					<div class="manage_table_area">
                     	<div class="manage_table_title">
                     		<div class="number">NO.001234</div>
                     		<div class="manage_report_title"><input type="text" class="title_name"></div>
                     	</div>
	                     <table class="table_approval">
	                        <tr>
			                     <td></td>
			                     <td>담당</td>
			                     <td>팀장</td>
			                     <td>사장</td>
	                  		</tr>
							<tr>
			                     <td>결제</td>
			                     <td>
			                     	<img src="${pageContext.request.contextPath}/IMAGES/disapprove.png" class="report_approval_btn" id="per_report_approval_btn"/>
			                     	<div style="display:none;"></div>
			                     </td>
			                     <td>
			                     	<img src="${pageContext.request.contextPath}/IMAGES/disapprove.png" class="report_approval_btn" id="team_report_approval_btn"/>
			                     	<div style="display:none;"></div> 
			                     </td>
			                     <td>
			                     	<img src="${pageContext.request.contextPath}/IMAGES/disapprove.png" class="report_approval_btn" id="boss_report_approval_btn"/>
			                     	<div style="display:none;"></div>
			                     </td>
							</tr>
							<tr>
								<td>보류</td>
								<td colspan="3">
									<input type="text" name="report_delay" id="report_delay"/>
								</td>
							</tr>
	               		</table>
						<table  class="table_content" >
	                  		<tr class="table_content_title">
	                     		<th >NO.</th>
		                     	<th >영수일시</th>
		                     	<th >분류</th>
		                     	<th >결제방식</th>
		                     	<th >업체명</th>
		                     	<th >금액</th>
	                  		</tr>
	                  		<%
	                  		for(int i=0; i<10; i++)
	                  		{
	                  		%>
	                  		<tr class="table_content_line">
			                     <!-- report_id -->
			                     <td class="table_content_info" style="display:none"></td>
			                     <td class="table_content_info"> </td>
			                     <td class="table_content_info"> </td>
			                     <td class="table_content_info"> </td>
			                     <td class="table_content_info"> </td>
			                     <td class="table_content_info"> </td>
			                     <td class="table_content_info"> </td>
	                  		</tr>
		                  	<%
	                  		}
		                  	%>
		                  	<tr>
		                  		<td colspan="2" style="padding-left:7%">총 금액</td>
		                  		<td colspan="4" class="cost_total">....</td>
		                  	</tr>
						</table>
					</div>
					<div class="manage_area">
					   <div class="manage_con">승인바랍니다.</div>
					   <div class="manage_cal">2016.10.29</div>
					</div>
					<div class="manage_line">
						<div class="manager_left">
							<span class="manager">등급</span>
							<span class="manager_name">
								<select name="level" class="report_level">
									<option value="0">선택하시오</option>
									<option value=1>극비</option>
									<option value=2>대외비 Ⅰ</option>
									<option value=3>대외비 Ⅱ</option>
									<option value=4>일반 </option>
								</select>
							</span>
	                     </div>
	                     <div class="manager_right">
						   	<span class="manager">담당</span>
						  	<span class="manager_name"><%=session.getAttribute("user_name") %></span>
					  	</div>
					</div>
	            </div>
	            <div class="manage_right">
	               <div class="swiper-container">
				        <div class="swiper-wrapper">
				        	
				        </div>
				        <!-- Add Pagination -->
				        <!-- <div class="swiper-pagination"></div> -->
				        <div class="swiper-button-next"></div>
        				<div class="swiper-button-prev"></div>
				    </div>
	            </div>
	            <div class="manage_line1">
	               <div class="manage_plus_button" id="write_report">저장하기</div>
	            </div>
	            <div class="manage_line2" style="display:none">
	            	<div class="manage_plus_button" id="delay_report">보류하기</div>
	               	<div class="manage_plus_button" id="approval_report">저장하기</div>
	            </div>
			</div>
		</div>
	</div>
</div>

<!-- 회원정보 수정하기 -->
<button class="btn btn-primary" id="modi_pro_btn" data-toggle="modal" data-target="#modi_pro" style="display:none"></button>
<div class="modal fade" id="modi_pro" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg" style="width:45%; margin-top:5%">
     <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
         	<span>개인정보 수정하기</span>
         </div>
         </div>
         <div class="modal-body" style="background-color:#242c34">
            <div class="modify_cont_wrap">
            	<form name="modify_user_info" id="modify_user_info" method="post" action="../ModifyUserAction.cont" encType="multipart/form-data">
               <table class="modify_block">
                  <tr>
                     <td class ="table_first"><div class="table_first_name">담당이름</div></td>
                     <td class ="table_second"><div class = "pro_modi"><input class="pro_sub_modi" name="modify_user_name" id="modify_user_name" type="text"/></div></td>
                  </tr>
                  <tr>
                     <td class ="table_first"><div class="table_first_name">담당업무</div></td>
                     <td class ="table_second"><div class = "pro_modi"><input class="pro_sub_modi" name="modify_user_pos" id="modify_user_pos" type="text"/></div></td>
                  </tr>
                  <tr>
                     <td class ="table_first"><div class="table_first_name">Tel</div></td>
                     <td class ="table_second"><div class = "pro_modi"><input class="pro_sub_modi" type="text" name="modify_user_tel" id="modify_user_tel" style="ime-mode: disabled" onKeyDown="javascript:NumKey()"/></div></td>
                  </tr>
                  <tr>
                     <td class ="table_first"><div class="table_first_name">phone</div></td>
                     <td class ="table_second"><div class = "pro_modi"><input class="pro_sub_modi" type="text" name="modify_user_phone" id="modify_user_phone" style="ime-mode: disabled" onKeyDown="javascript:NumKey()"/></div></td>
                  </tr>
                  <tr>
                     <td class ="table_first"><div class="table_first_name">프로필사진</div></td>
                     <td class ="table_second">
                     	<div class = "pro_modi">
                     		<input class="pro_sub_modi" id="profile_img_modi" type="text" value="파일을 선택"/>
                     		<input type="file" id="profile_file_modi" name="profile_file_modi" style="display:none;">
                     		
                     	</div>
                     </td>
                  </tr>
                  <tr>
                     <td class ="table_first"><div class="table_first_name">비밀번호</div></td>
                     <td class ="table_second"><div class = "pro_modi"><input class="pro_sub_modi" name="modify_user_pw" id="modify_user_pw" type="password"/></div></td>
                  </tr>
                </table>             
                </form>  
         </div>
         <div class="pro_plus">저장</div>
      </div>
   </div>
</div>

<div class="float_button" ><img src=" ${pageContext.request.contextPath}/IMAGES/chatting.png"></div>
<div class="team_make_toggle">
      <div class="team_wrap">
         <div class="team_title">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 팀원 초대하기 
               <img src="${pageContext.request.contextPath}/IMAGES/close.png"  class="close" style="float:right"/>
           </div>
           <div class="team_cont_wrap">
               <div class="team_block">
                  <input type="text" class="name"  placeholder="E-mail"/>
                  <select class="team_status">
                        <option>권한</option>
                        <option value=1>0등급</option>
                        <option value=2>1등급</option>
                        <option value=3>2등급</option>
                        <option value=3>3등급</option>
                  </select>
              </div>
               <div class="team_line">
                  <div class="plus">초대하기</div>
               </div>
        </div>
      </div>
   </div>   
   
 <!-- 부서추가하기 -->
<button class="btn btn-primary" id="department_pro_btn" data-toggle="modal" data-target="#department_pro" style="display:none"></button>
<div class="modal fade" id="department_pro" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="width:45%; margin-top:5%">
		<div class="modal-content">
    		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
				<span>부서추가하기</span>
			</div>
		</div>
		<div class="modal-body" style="background-color:#242c34">
			<div class="modify_cont_wrap">
   				<div class="select_radio">
      				<input type="radio" name="depart_select" id="company" value="company" checked/>
      				<div class="depart_radio">회사</div>
      				<input type="radio" name="depart_select" id="depart" value="depart"/>
      				<div class="depart_radio">부서</div>
   				</div>
   				<form name="depart" method="post" action="${pageContext.request.contextPath}/InsertDeptAction.cont?type=depart">
   					<table id="depart_name" class="modify_block" style="display:none;">
   						<tr>
   							<td colspan="2" class ="table_center">
	   							<div class="table_center_name">
		   							<select name="select_company" id="select_company" style="background-color:black; margin-left:10%;">
		   								<option value="-1" selected>회사를 선택해주세요</option>
		   								<%
		   								for(int i=0; i<company_list.size(); i++)
		   								{
		   								%>
		   									<option value='<%=company_list.get(i).get("dept_id")%>'><%=company_list.get(i).get("dept_name") %></option>
		   								<%
		   								}
		   								%>
		   							</select>
	   							</div>
   							</td>
   						</tr>
                  		<tr>
                     		<td colspan="2" class ="table_center">
                     			<div class="table_center_name">
                     				<input class="pro_sub_modi" style="margin-left:4%;" name="dept_title" id="dept_title" type="text" placeholder="부서명"/>
                     			</div>
                     		</td>
                  		</tr>
                  		<tr>
                     		<td class ="table_first">
                     			<div class="table_first_name">
                     				<input class="pro_sub_modi" name="dept_member_1" type="text" placeholder="팀원이름"/>
                     			</div>
                     		</td>
                     		<td class ="table_second">
                     			<div class = "depart_modi">
		                        	<select name="dept_member_priv_1" id= "select1" class="member_invi_box" onchange="disableCheck1(this)">
		                     			<option value="0" selected>등급</option>
		                     			<option value="1">1등급</option>
		                     			<option value="2">2등급</option>
		                     			<option value="3">3등급</option>
		                     			<option value="4">4등급</option>
		                     		</select>
                     			</div>
                     		</td>
                  		</tr>
                  		<tr>
                     		<td class ="table_first">
                     			<div class="table_first_name">
                     				<input class="pro_sub_modi" type="text" name="dept_member_2" placeholder="팀원이름"/>
                     			</div>
                     		</td>
                     		<td class ="table_second">
                     			<div class = "depart_modi">
                        			<select name="dept_member_priv_2" id= "select2" class="member_invi_box" onchange="disableCheck2(this)">
					                     <option value="0" selected>등급</option>
					                     <option value="1">1등급</option>
					                     <option value="2">2등급</option>
					                     <option value="3">3등급</option>
					                     <option value="4">4등급</option>
                     				</select>
                     			</div>
                     		</td>
                  		</tr>
						<tr>
						   <td class ="table_first">
							   	<div class="table_first_name">
							   		<input class="pro_sub_modi" type="text" name="dept_member_3" placeholder="팀원이름"/>
							   	</div>
						   </td>
						   <td class ="table_second">
						   		<div class = "depart_modi">
						      		<select name="dept_member_priv_3" id= "select3" class="member_invi_box" onchange="disableCheck3(this)">
									   <option value="0" selected>등급</option>
									   <option value="1">1등급</option>
									   <option value="2">2등급</option>
									   <option value="3">3등급</option>
									   <option value="4">4등급</option>
						   			</select>
						   		</div>
						   	</td>
						</tr>
                </table>
             	</form>
               	<form name="insertCompany" method="post" action="${pageContext.request.contextPath}/InsertDeptAction.cont?type=company">
                	<table id="company_name" class="modify_block" >
	                  <tr>
	                     <td colspan="2" class ="table_center">
	                     	<div class="table_center_name">
	                     		<input id="company_name_priv" class="pro_sub_modi" style="margin-left:3%;" type="text" name="company_title" placeholder="회사명"/>
	                     	</div>
	                     </td>
	                  </tr>
	                  <tr>
	                     <td class ="table_first">
	                     	<div class="table_first_name">
	                     		<input class="pro_sub_modi" type="text" name="dept_title_1" placeholder="부서명"/>
	                     	</div>
	                     </td>
	                     <td class ="table_first">
	                     	<div class="table_second_name">
	                     		<input class="pro_sub_modi" type="text" name="dept_header_1" placeholder="부서책임자"/>
	                     	</div>
	                     </td>
	                  </tr>
	                  <tr>
	                     <td class ="table_first">
	                     	<div class="table_first_name">
	                     		<input class="pro_sub_modi" type="text" name="dept_title_2" placeholder="부서명"/>
	                     	</div>
	                     </td>
	                     <td class ="table_first">
	                     	<div class="table_second_name">
	                     		<input class="pro_sub_modi" type="text" name="dept_header_2" placeholder="부서책임자"/>
	                     	</div>
	                     </td>
	                  </tr>
	                  <tr>
	                     <td class ="table_first">
	                     	<div class="table_first_name">
	                     		<input class="pro_sub_modi" type="text" name="dept_title_3" placeholder="부서명"/>
	                     	</div>
	                     </td>
	                     <td class ="table_first">
	                     	<div class="table_second_name">
	                     		<input class="pro_sub_modi" type="text" name="dept_header_3" placeholder="부서책임자"/>
	                     	</div>
	                     </td>
	                  </tr>     
                	</table>  
                </form>                            
         </div>
         <div class="depart_plus">저장</div>
      </div>
   </div>
</div>

<!-- 팀원초대  -->
  <button class="btn btn-primary" id="team_invi_btn" data-toggle="modal" data-target="#team_invi" style="display:none"></button>
  <div class="modal fade" id="team_invi" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="width:40%">
       <div class="modal-content">
           <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
           		<span>맴버초대</span>
           </div>
           </div>
           <div class="modal-body" >
              <div class="team_member_cont_wrap">
              	<form name="add_member" id="add_user_form" method="post" action="../InsertMemberAction.cont"> 
                 <table class="team_member_block">
                    <tr>
                       <td class ="member_first">
                       		<div class = "member_box">
                       			<input class="member_invi_box" id="u_mail" type="text" name="mail" placeholder="E-mail"/>
                       		</div>
                       	</td>
                    </tr>
                    <tr>
                      <td class ="member_first">
                       	<div class = "member_box">
	                       	<select id= "select" name="priv" class="member_invi_box">
		                       <option value="-1" selected>등급</option>
		                       <option value="1">1등급</option>
		                       <option value="2">2등급</option>
		                       <option value="3">3등급</option>
		                       <option value="4">4등급</option>
	                       	</select>
                       	</div>
                      </td>
                    </tr>
                  </table>
                  	<input type="text" name="company" style="display:none;" id="add_member_company">
           	  		<input type="text" name="dept" style="display:none;" id="add_member_dept">               
           		</form>
           	  </div>
           	  <div class="member_plus" id="member_plus">초대하기</div>
           	  
        </div>
     </div>
  </div>
  
	<script>
	$(".float_button").click(function()
	        {
	          if($(this).hasClass("on") && presstime < 1000 )
	          {
	        	  $("#chatting").fadeOut(500);
	             $(this).children("img").attr('src', '${pageContext.request.contextPath}/IMAGES/chatting.png');
	             $(this).removeClass("on");
	          }
	          else if(presstime < 1000)
	          {
	             $(this).addClass("on");
	             $("#chatting").fadeIn(500);
	          }
	        });
	$('.pro_plus').click(function(){
		if(!$('#modify_user_name').val()){
			$('#modify_user_name').focus();
			return;
		}else if(!$('#modify_user_pos').val()){
			$('#modify_user_pos').focus();
			return;
		}else if(!$('#modify_user_tel').val()){
			$('#modify_user_tel').focus();
			return;
		}else if(!$('#modify_user_phone').val()){
			$('#modify_user_phone').focus();
			return;
		}else if($('#profile_img_modi').val()=='파일을 선택'){
			alert('파일을 선택해주세요');
			return;
		}else if(!$('#modify_user_pw').val()){
			$('#modify_user_pw').focus();
			return;
		}
		
		var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
		if(!regPhone.test($('#modify_user_phone').val())){
			alert("연락처 양식 확인");
			$(this).focus();
			return;
		}
		var regtel = /^((0[1-9])[1-9]+[0-9]{5,6})|(02[1-9][0-9]{5})$/;
		if(!regtel.test($('#modify_user_tel').val())){
			alert("연락처 양식 확인");
			$(this).focus();
			return;
		}
		
		$('#modify_user_info').submit();
	});
	$('#member_plus').click(function(){
		var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		if(!regEmail.test($("#u_mail").val())){
			alert('이메일 입력양식 확인');
			$("#u_mail").focus();
			return;
		}
		
		if($('#select').val()=='-1'){
			alert('등급을 확인');
			$('#select').focus();
			return;
		}
		
		/* var text=$('#add_member_dept').val()+"||"+$("#u_mail").val()+"||"+$('#select').val();
		alert(text); */
		
		$('#add_user_form').submit();
	});
	
	$('.depart_plus').click(function(){//부서, 회사추가
		//추가하려는거 구분
		if($('#company').is(':checked')){
			//alert('회사선택');
			if(!$('#company_name_priv').val()){
				$('#company_name_priv').focus();
				return;
			}
			
			if(pairCheck("company")){
				$('#company_name').parent().submit();
			}else{
				alert('부서이름이나 부서 팀장을 입력해주세요.');
				return;
			}
			
		}else{
			//alert('부서선택');
			if($('#select_company').val()=='-1'){
				$('#select_company').focus();
				return;
			}
			if(!$('#dept_title').val()){
				$('#dept_title').focus();
				return;
			}
			if(pairCheck("department")){
				$('#depart_name').parent().submit();
			}else{
				alert('회원이름이나 권한을 입력해주세요.');
				return;
			}
		}

	});
	var approval_flag=-1;
 	$('.report_approval_btn').click(function(){
		var com_id=$('#center').contents().find('#company_id').text();
		
		var boss=false;
 		<%
 		for(int i=0; i<company_list.size(); i++)
 		{
 		%>
 			if(com_id=='<%=company_list.get(i).get("dept_id")%>'){
 				boss=<%=boss_list.get(i)%>;
 			}
		<%
 		}
		%>
		//alert(boss);
		var id=$(this).attr('id');
		
		var writer=$('#report_write').contents().find('.modal-body').children().eq(1).text();
		
		var dept_id=$('#report_write').contents().find('.modal-body').children().eq(2).text();
		var team_head=null;
		var dept_index=0;
		
		
		<%
		int dept_index=-1;
		for(int i=0; i<user_depts.length; i++)
		{
		%>
			if('<%=user_depts[i]%>'==dept_id){
				team_head='<%=user_privs[i]%>';
			}
		<%
		}
		%>
		
		if($('.manage_line1').css('display')!='none'){
			writer='<%=user_id%>';
		}
		
		if(id=="per_report_approval_btn"){
			if(writer=='<%=user_id%>'){
				if($(this).attr('src')=='${pageContext.request.contextPath}/IMAGES/disapprove.png')
					$(this).attr('src','${pageContext.request.contextPath}/IMAGES/approve.png');
				else
					$(this).attr('src','${pageContext.request.contextPath}/IMAGES/disapprove.png');
				approval_flag=1;
			}
		}else if(id=="team_report_approval_btn"){
			if(team_head=='1'){
				if($(this).attr('src')=='${pageContext.request.contextPath}/IMAGES/disapprove.png')
					$(this).attr('src','${pageContext.request.contextPath}/IMAGES/approve.png');
				else
					$(this).attr('src','${pageContext.request.contextPath}/IMAGES/disapprove.png');
				approval_flag=2;
			}
		}else if(id=="boss_report_approval_btn"){
			 if(boss){
				if($(this).attr('src')=='${pageContext.request.contextPath}/IMAGES/disapprove.png')
					$(this).attr('src','${pageContext.request.contextPath}/IMAGES/approve.png');
				else
					$(this).attr('src','${pageContext.request.contextPath}/IMAGES/disapprove.png');
				approval_flag=3;
			}
		}
	});
	
	$('#delay_report').click(function(){
		if(!$('#report_delay').val()){
			alert('보류 사유를 입력해주세요.');
			$('#report_delay').focus();
			return;
		}
		var report_id=$('.modal-body').children().eq(0).text();
		var report_state="delay";
		var report_delay=$('#report_delay').val();
		
		var dept_id=$('#report_write').contents().find('.modal-body').children().eq(2).text();
		var page=$('#report_write').contents().find('.modal-body').children().eq(3).text();
 		var cmd=$('#report_write').contents().find('.modal-body').children().eq(4).text();
 		var value=$('#report_write').contents().find('.modal-body').children().eq(5).text();
		
		var url="${pageContext.request.contextPath}/ModifyReportAction.cont?dept_id="+dept_id+"&page="+page+"&cmd="+cmd+"&value="+value;
		url+="&report_id="+report_id+"&report_state="+report_state+"&report_delay="+report_delay;
		//alert(url);
		$('#center').attr('src', url);
		$('#report_write').contents().find('.close').click();
	});
	$('#approval_report').click(function(){
		//승인 눌렀다는 검사
		if(approval_flag==-1){
			alert('상태가 변경되지 않았습니다');
			return;
		}
		
		var report_id=$('.modal-body').children().eq(0).text();
		var report_state="";
		if(approval_flag==1){
			report_state="play1";
		}else if(approval_flag==2){
			report_state="play2";
		}else if(approval_flag==3){
			report_state="finish";
		}else{
			report_state="wait";
		}
		var report_delay="";
			
		var dept_id=$('#report_write').contents().find('.modal-body').children().eq(2).text();
		var page=$('#report_write').contents().find('.modal-body').children().eq(3).text();
 		var cmd=$('#report_write').contents().find('.modal-body').children().eq(4).text();
 		var value=$('#report_write').contents().find('.modal-body').children().eq(5).text();
		
		var url="${pageContext.request.contextPath}/ModifyReportAction.cont?dept_id="+dept_id+"&page="+page+"&cmd="+cmd+"&value="+value;
		url+="&report_id="+report_id+"&report_state="+report_state+"&report_delay="+report_delay;
		//alert(url);
		$('#center').attr('src', url);
		$('#report_write').contents().find('.close').click();
	});
	$('#write_report').click(function(){
		
		var report_title=$('#report_write').contents().find('.title_name').val();
		
		var tr_list=$('#report_write').contents().find('.table_content').children().children('.table_content_line');
		var td_list="";
		
		for(var i=0; i<tr_list.length; i++){
			if(tr_list.eq(i).children('.table_content_info').eq(0).html()!='&nbsp;'){
				td_list+=tr_list.eq(i).children('.table_content_info').eq(0).text()+"_";
			}
		}
		td_list=td_list.substring(0, td_list.lastIndexOf("_"));
		
		if(!report_title){
			alert('제목을 입력해주세요');
			$('#report_write').contents().find('.manage_table_title').children().focus();
			return;
		}
		if(td_list=="" || !td_list){
			alert('영수증을 선택해 주세요');
			return;
		}
		if($('.report_level').val()=='0'){
			alert('등급을 설정해주세요');
			return;
		}
		var url='${pageContext.request.contextPath}/InsertReportAction.cont?report_title='+report_title+'&receipt_list='+td_list+'&level='+$('.report_level').val()+"&dept_id=1&page=1";
		//alert(report_title);
		$('#center').attr('src', url);
		
		//영수증 메뉴바 지우기
		
		$('#left_side').get(0).contentWindow.sucWriteReport();
		$('#report_write').contents().find('.close').click();
		
		//$('#left_side')[0].contentWindow.menuToggle("보고서관리");
		//first_index=5;
	});
	//main_swiper.slideTo(index);
	$('.table_content_line').click(function(){
		var index=$(this).index()-1;
		//alert(index);
		swiperH.slideTo(index);
	});
	
	var swiperH = new Swiper('.swiper-container', {
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        preloadImages:true,
        updateOnImagesReady: true,
        spaceBetween:30,
        onSlideChangeStart : function(evt)
        {
         	  
        },
        onSlideChangeEnd : function(evt)
        {
           
        }
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
		$('#receipt_date').offset({top:$('#left_side').contents().find('#receipt_date').offset().top, left:$('#left_side').contents().find('#receipt_date').offset().left});
		$('#receipt_date').css('width',$('#left_side').contents().find('#receipt_date').width());
		$('#receipt_date').data('dateRangePicker').close();
		
	});
	</script>
</body>

</html>