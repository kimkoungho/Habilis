<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   
   <script src="../include/jquery.js"></script>
   <!-- 플러그인 참조 -->
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.js"></script>
    <script src="http://cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
   <script src="../include/keyevent.js"></script>
   <link rel="stylesheet" href="../css/QNA.css">
   <script language="javascript" src="../js/QNA.js"></script>
   <title></title>
   	<script>
   		function Domain(val) {
   	  		$('#sender2').val(val); 
   	  	}
   	</script>
</head>
<body>
<form method="post" action="SendMail2.jsp">
   <div class="wrap">
      <div class="title">
         <div class="title_name">CUSTOMER CENTER</div>
      </div>
      
      <div class="content_border">
         <div class="member_wrap">
            <div class="member_title">1:1 문의하기</div>
            <div class="member_sup_title">하빌리스 서비스 이용시 불편사항이나 문의사항을 보내주시면 신속하고 친절하게 안내해드리겠습니다.</div>
            <div class="member_sup_title">신속한 답변을 위해 메일을 보내시기 전에 이름과 이메일을 다시한번 확인해주십시요.</div>
            <table class="table_wrap">
               <tr>
                  <td name="name" id="name" class="table_first">이름</td>
                  <td class="table_second"><input name="name1" id = "name1" value='<%=session.getAttribute("user_name") %>' type="text" MAXLENGTH=3 class="text_name" readonly/></td>
               </tr>
               <tr>
                  <td name="phone" id = "phone" class="table_first">연락처</td>
                  <td class="table_second">
                  	<input type="text" name="phone1" id = "phone1" class="text_second" MAXLENGTH=3 style="ime-mode: disabled" onKeyDown="javascript:NumKey()" />- 
                    <input type="text" name="phone2" id = "phone2" class="text_second" MAXLENGTH=4 style="ime-mode: disabled" onKeyDown="javascript:NumKey()" />- 
                    <input type="text" name="phone3" id ="phone3" class="text_second" MAXLENGTH=4 style="ime-mode: disabled" onKeyDown="javascript:NumKey()" /></td>
               </tr>
               <tr>
                  <td name="mail" id="mail" class="table_first">E-MAIL</td>
                  <td class="table_second">
                  	<input name="sender" id = "sender" type="text" class="text_second" style="ime-mode: disabled" />@ 
                  	<input name="sender2" id="sender2" type="text" class="text_second" placeholder="직접입력" style="ime-mode: disabled" onFocus="clearText(this)" /> 
                  	<select class="table_select" id = "sel_val" onChange="Domain(this.value);">
                        <option>선택하시오</option>
                        <option>naver.com</option>
                        <option>hanmail.net</option>
                        <option>nate.com</option>
                        <option>google.co.kr</option>
                  </select>
                 </td>
               </tr>
               <tr>
                  <td name="question" id="question" class="table_first">질문 구분</td>
                  <td class="table_second">
                  	<select name="select" id= "select" class="table_select">
                        <option>선택하시오</option>
                        <option>시스템문의</option>
                        <option>사용문의</option>
                        <option>결제문의</option>
                        <option>기타</option>
                  	</select>
                  </td>
               </tr>
               <tr>
                  <td name="subject" id="subject" class="table_first">제목</td>
                  <td class="table_second">
                  	<input name="sub_subject" id="sub_subject" type="text" class="text_title" />
                  </td>
               </tr>
               <tr>
                  <td name="content" id="content" class="table_first">내용</td>
                  <td class="table_second"><textarea name="sub_content" id="sub_content" class="text_area" rows="7"></textarea>
                  </td>
               </tr>
            </table>
            <div class="button_wrap">
               <input type="submit" class="wrap_button_first" value="보내기" />
            </div>
         </div>
      </div>
	</div>
</form>
   
</body>
</html>