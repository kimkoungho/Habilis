<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
    
 <%
 		ArrayList<HashMap> card_list = (ArrayList<HashMap>)request.getAttribute("card_list");
 		
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8" />
	<title></title>
	
	<script src="${pageContext.request.contextPath}/include/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/include/jquery-ui.js"></script>
	 
	<script src="${pageContext.request.contextPath}/js/CardManage.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/CardManage.css">
</head>
<body>
	<div id="wrap">
		<div class="content_menu">
			<div class="menu_name">CARD CHANGE</div>
		</div>
		
		<div class="content_border">
			<div class="page_title">카드 관리</div>
			<div class="page_info">개인카드 및 법입카드 등록, 삭제를 하실 수 있습니다.</div>
		</div>
	
		<div class="card_container">
		<%
		if(card_list!=null)
		{
			for(int i=0; i<card_list.size(); i++)
			{
		%>
			<div class="card_slide">
				<div class="card_pic">
					<img src="${pageContext.request.contextPath}/IMAGES/kakaopay_image.png"/>
				</div>
				
				<div class="card_make_cont">
					<div class="card_cont_wrap">
						<div class="card_info">카드 번호</div>
						<div class="card_info" style="width:60%"><%=card_list.get(i).get("card_num") %></div>
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">카드 이름</div>
						<div class="card_info"><%=card_list.get(i).get("card_corpor") %></div>
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">유효 기간</div>
						<div class="card_info"><%=card_list.get(i).get("card_expired") %></div>
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">CVC</div>
						<div class="card_info"><%=card_list.get(i).get("cvc") %></div>
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">카드 종류</div>
						<div class="card_info">
						<%
							String type=(String)card_list.get(i).get("card_type");
							if(type.equals("cor")){
								out.println("법인 카드");
							}else{
								out.println("개인 카드");
							}
						%>
						</div>
					</div>
					<div class="card_cont_wrap">
						<div class="card_delete">삭제</div>
					</div>
				</div>
			</div>
		<%
			}
		}
		%>
			<!-- form -->
			<form name="card_input" method=post action="./InsertCardAction.cont" >
			
			<div class="card_slide">
				<div class="card_pic_plus">
					<img src="${pageContext.request.contextPath}/IMAGES/card_add.png" />
				</div>
				<div class="card_make_cont" style="margin-top:3%">
					<div class="card_cont_wrap">
						<div class="card_info">카드번호</div>
						<input type="text" name="card_num1"  size=4 maxlength="4"  placeholder="1234" style="font-size: 1vw;"/>- 
						<input type="text" name="card_num2"  size=4 maxlength="4"  placeholder="1234" style="font-size: 1vw;"/>- 
						<input type="text" name="card_num3"  size=4 maxlength="4"  placeholder="1234" style="font-size: 1vw;"/>-
						<input type="text" name="card_num4"  size=4 maxlength="4"  placeholder="1234" style="font-size: 1vw;"/>
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">카드이름</div>
						<input type="text" placeholder="국민카드" class="card_info" name="card_corpor" style="font-size: 1vw;">
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">유효기간</div>
						<input type="text" placeholder="YYYY"name="card_year" size=4 maxlength="4" style="font-size: 1vw;"> / 
						<input type="text" placeholder="MM"name="card_month" size=2 maxlength="2" style="font-size: 1vw;">
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">CVC</div>
						<input type="text" placeholder="123" class="card_info" name="cvc"  maxlength="3" style="font-size: 1vw;">
					</div>
					<div class="card_cont_wrap">
						<div class="card_info">카드종류</div>
						<select name="card_type" class="card_info" style="padding: 1%; width:40%; font-size: 1vw;">
							<option value="menu" style="color:#cccccc">카드를 선택하세요</option>
							<option value="per">개인카드</option>
							<option value="cor">법인카드</option>
						</select>
					</div>
					<div class="card_cont_wrap">
						<div class="card_confirm">완료</div>
						<div class="card_cancel">취소</div>
					</div>
				</div>
			</div>
			
			</form>
			
		</div>
		
	</div>
	
	<script>
		//저장 버튼
		$('.card_confirm').click(function(){
			//검사
			if($('.card_type').val()=="menu")
			{
				card_input.card_type.focus();
				return;
			}

			card_input.submit();
		});
		
		$('.card_cancel').click(function()
		{
			
		});
	
		//삭제 버튼
		$('.card_delete').click(function()
		{
			var parent=$(this).parent('.card_cont_wrap').parent('.card_make_cont');
			
			var card_num=parent.children('.card_cont_wrap').eq(0).children('.card_info').eq(1).html();
			var card_corpor=parent.children('.card_cont_wrap').eq(1).children('.card_info').eq(1).html();
			
			alert(card_num+"..."+card_corpor);
			location.href="./DelCardAction.cont?card_num="+card_num+"&card_corpor="+card_corpor;
		});
	</script>
</body>
</html>