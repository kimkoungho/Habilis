<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <title>Habilis</title>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="author" content="Alvaro Trigo Lopez" />
   <meta name="description" content="fullPage demo scrolling speed." />
   <meta name="keyword" content="fullpage,jquery," />
   <meta name="Resource-type" content="Document" />

   <script src="../include/jquery.js" type="text/javascript"></script>
   <script src="../include/jquery-ui.js" type="text/javascript"></script>
      
   <link type="text/css" rel="stylesheet" href="../include/jquery.fullPage.css">
   <link type="text/css" rel="stylesheet" href="../css/Main.css">
<!-- <script type="text/javascript"
   src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script type="text/javascript"
   src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript"
   src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script> -->
   
   <script src="../include/jquery.fullPage.js" type="text/javascript"></script>
   <script src="../js/Main.js" type="text/javascript"></script>
   <script src="../include/keyevent.js"></script>
   
   <script type="text/javascript">
      $(document).ready(function() {
         $('#fullpage').fullpage({
            scrollingSpeed : 1000
         });
      });
   </script>
</head>


<body>
   <!-- 마크,로그인 -->
   <div class="wrap">
      <div class="top_fix_zone" >
         <img src="../IMAGES/logo_w.png" width="17%" height="21%">
      </div>
   </div>
   
   <div class="top_fix_zone" id="topBar">
      <div id="login_join_icon">
         <img id="main_img" src="../IMAGES/profile1.png" style="width: 20%; float: right">
      </div>
   
      <div id="login_join" style="display:none;">
         <form name="login_form" id="login_form" method="post" action="../LoginAction.cont">
            <div class="wraplogin">
               <table id="login_table" class="table_wrap" style="border-collapse: collapse;">
                  <tr>
                     <td class="table_second" colspan="2">로그인</td>
                  </tr>
                  <tr>
                     <td class="table_second" colspan="2">
                        <div class="login_id">
                           <img class="login_img" src="../IMAGES/user_login.png">
                        </div>
                        <div class="login_text">
                           <input class="login_text_sub" id="email_login" name="email" type="text" placeholder="E-mail">
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td class="table_second" colspan="2">
                        <div class="login_id">
                           <img class="login_img" src="../IMAGES/lock_login.png">
                        </div>
                        <div class="login_text">
                           <input class="login_text_sub" id="pw_login" name="pw" type="password" placeholder="Password">
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td class="table_second" colspan="2">
                        <div class="login" id="login_btn">sign in</div>
                     </td>
                  </tr>
                  <tr>
                     <td class="table_second" colspan="2">
                        <div id="join" style="margin-bottom:2.5%; font-weight:600;">회원가입</div>
                     </td>
                  </tr>
               </table>
            </div>
         </form>
         
         <form name="join_form" id="join_form" method="post" action="JoinAction.cont" enctype="multipart/from-data">
            <table id="join_table" class="join_table_wrap">
               <tr>
                  <td class="join_table_second" colspan="2" id="login_swap_btn">로그인</td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class="member_join">회원가입</div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">E-mail</div>
                        <div class="join_text">
                           <input class="join_text_sub on" name="ID" type="text"/> 
                           <img class="join_img" id="ID_img" src="../IMAGES/check_ok.png">
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">비밀번호</div>
                        <div class="join_text">
                           <input class="join_text_sub on" name="Pw" type="password"/> 
                           <img class="join_img" id="Pw_img" src="../IMAGES/check_ok.png">
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">비밀번호확인</div>
                        <div class="join_text">
                           <input class="join_text_sub on" name="Check_Pw" type="password" /> 
                           <img class="join_img" id="Check_Pw_img" src="../IMAGES/check_ok.png">
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">이름</div>
                        <div class="join_text">
                           <input class="join_text_sub on" name="name" type="text" />
                           <img class="join_img" id="name_img" src="../IMAGES/check_ok.png">
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">휴대전화번호</div>
                        <div class="join_text">
                           <input class="join_text_sub on" name="Phone" type="text" onKeyDown="javascript:NumKey()"/>
                           <img class="join_img" id="Phone_img" src="../IMAGES/check_ok.png">
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">사내번호</div>
                        <div class="join_text">
                           <input class="join_text_sub" name="com_phone" type="text"  onKeyDown="javascript:NumKey()"/> 
                        </div>
                     </div>
                  </td>
               </tr>
               <!-- <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">회사</div>
                        <div class="join_text">
                           <input class="join_text_sub" name="depart" type="text" /> 
                        </div>
                     </div>
                  </td>
               </tr> -->
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">직급</div>
                        <div class="join_text">
                           <input class="join_text_sub" name="sir" type="text" /> 
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <div class=join_first>
                        <div class="join_id">이미지</div>
                        <div class="join_text">
                           <input class="join_text_sub on" id="profile_img" name="pro_img" type="text" value="파일을 선택"/>
                           <img class="join_img" id="Profile_img1" src="../IMAGES/check_ok.png">
                           <input type="file" name="profile_file" id="profile_file" style="display:none;"> 
                        </div>
                     </div>
                  </td>
               </tr>
               <tr>
                  <td class="join_table_second" colspan="2">
                     <input type="button" id="join_btn" value="시작하기" class="join">
                  </td>
               </tr>
            </table>
         </form>
         <div class="swap">
            
         </div>
      </div>
   </div>
   
   <div id="fullpage" style = "width : 100%; height: 100%;">

      <!-- 첫페이지 -->
      <div class="section" id="section0" style="background-image:url('../IMAGES/m1.png')">
         <div class="text">
            <div class="title_info">하빌리스, 지금 시작하세요!</div>
            <div class="title">간편한 업무, 손쉬운 업무 이제 편리하게 사용하세요.</div>
         </div>
      </div>

      <!-- 두번째 페이지 -->
      <div class="section" id="section1" >
         <div class="slide" style="background-image:url('../IMAGES/m2_1.png')">
            <div class="intro">
               <div class="text">
                  <div class="title_info">실시간채팅</div>
                  <div class="title">팀원들과의 실시간 채팅 이제는 한번에 사용하세요.</div>
               </div>
            </div>
         </div>
         <div class="slide" style="background-image:url('../IMAGES/m2_2.png')">
            <div class="intro">
               <div class="text">
                  <div class="title_info">실시간채팅</div>
                  <div class="title">팀원들과의 실시간 채팅 이제는 한번에 사용하세요.</div>   
               </div>
            </div>
         </div>
         <div class="slide" style="background-image:url('../IMAGES/m2-3.png')">
            <div class="intro">
               <div class="text">
                  <div class="title_info">실시간채팅</div>
                  <div class="title">팀원들과의 실시간 채팅 이제는 한번에 사용하세요.</div>
               </div>
            </div>
         </div>
      </div>

      <!-- 세번째 페이지 -->
      <div class="section" id="section2" style="background-image:url('../IMAGES/m3-1.png')">
         <div class="slide">
            <div class="intro">
               <div class="text">
                  <div class="title">이제는 찍으세요!</div>
                  <div class="title_info"> 찟어진 영수증,<br>젖은 영수증, <br>지저분한 영수증, <br></div>
               </div>
            </div>
         </div>

         <div class="slide" style="background-image:url('../IMAGES/m3-2-.png')">
            <div class="intro">
               <div class="text">
                  <div class="title1">보관과 지출보고서가 한번에!</div>
               </div>
            </div>
         </div>
      </div>

      <!-- 네번째 페이지 -->
      <div class="section" id="section3" style="background-image:url('../IMAGES/m4-1.jpg')">
         <div class="text">
            <div style="float:right;width:100%; text-align:right; padding-right:5%;color:black;font-size:1.5em;font-weight:800;">
               편리하게 사용하세요!<br> 언제어디서든!<br>
            </div>
            <!-- <img src="../IMAGES/m4-1.jpg" alt="Compatible" width="100%" height="100%" /> -->
         </div>
      </div>

      <!-- 다섯번째 페이지 -->
      <div class="section" id="section4" style="background-color : #252c34;" >
               <div class="backgroundimg">
                  <img src="../IMAGES/total2.gif" />
               </div>
            <div class="text">
               <div class="title1">Total-Office<br>
                  업무에만 집중하세요.<br> 하빌리스가 도와드립니다.<br> 팀원관리, 업무일정, 경비지출 <br>대신해드립니다.
               </div>
            </div>
         </div>
      </div>
   

   <div id="container">
      <div id="footer">패더입니다잉</div>
   </div>

   <script>
      $('#join_btn').click(function(){
         var form=document.join_form;

         if($('#ID_img').css('visibility')!='visible'){
            alert('이메일 확인');
            $('#ID_img').prev().focus();
            return;
         }else if($('#Pw_img').css('visibility')!='visible'){
            alert('패스워드 확인');
            $('#Pw_img').prev().focus();
            return;
         } else if($('#Check_Pw_img').css('visibility')!='visible'){
            alert('패스워드 확인');
            $('#Check_Pw_img').prev().focus();
            return;
         }else if($('#name_img').css('visibility')!='visible'){
            alert('이름 확인');
            $('#name_img').prev().focus();
            return;
         }else if($('#Phone_img').css('visibility')!='visible'){
            alert('휴대폰 확인');
            $('#Phone_img').prev().focus();
            return;
         }else if($('#Profile_img1').css('visibility')!='visible'){
            alert('프로필 이미지 확인');
            $('#Profile_img1').prev().focus();
            return;
         }
         
         var fd=new FormData(form);
         
         $.ajax({
             url: "../JoinAction.cont",
              type: "POST",
              data: fd,
              async: false,      
              cache: false,
              contentType: false,
              processData: false,
              onprogress: function (e) {
              },
              success:  function(data){
                 console.log(data);
                 if(data=="2"){
                    alert('회원가입 성공');
                    $('.join_img').css('visibility','hidden');
                    form.reset();
                    $('#join_table').hide();
                    $('#login_table').slideToggle();
                 }else{
                    alert('회원가입 실패');
                 }
                 
              }
          });
         
         
      });
      
      $('#login_btn').click(function(){
         var form=document.login_form;
         
         var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
         if(!regEmail.test($('#email_login').val())){
            alert("이메일 양식 확인");
            $('#email_login').focus();
            return;
         }
         if(!$('#pw_login').val()){
            alert('비밀번호 입력');
            $('#pw_login').focus();
            return;
         }
         
         form.submit();
      });
   </script>
</body>
</html>