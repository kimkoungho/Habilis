$(document).ready(function(){
	$("#login_swap_btn").click(function(){
		$('#join_table').hide();
		$('#login_table').slideToggle();
	});
	
	$("#demosMenu").change(function(){
	  window.location.href = $(this).find("option:selected").attr("id") + '.html';
	});
	
	var topBar = $("#topBar").offset();
	$(window).scroll(function() {
		var docScrollY = $(document).scrollTop()
		var barThis = $("#topBar")
		var fixNext = $("fixNextTag")
		
		if(docScrollY > topBar.top) {
			barThis.addClass("top_bar_fix");
			fixNext.addClass("pd_top_80");
		}else {
			barThis.removeClass("top_bar_fix");
			fixNext.removeClass("pd_top_80");
		}
	});
	
	$('#main_img').click(function(){
		if($('#login_join').css('display')=='none'){//열기 
			$(this).attr('src', '../IMAGES/profile2.png');
		}else{//접기
			$(this).attr('src', '../IMAGES/profile1.png');
		}
		$('#login_join').slideToggle();
	});
	
	$('#join').click(function(){
		$('#login_table').hide();
		$('#join_table').slideToggle();
	});
	
	
	$('#profile_img').click(function(){
		$('#profile_file').click();
	});
	
	$('#profile_file').change(function(){
		if (this.files[0]) {
            var reader = new FileReader();  
            reader.onload = function (e) {  
            	var url=$('#profile_file').val();
            	url=url.substr(url.lastIndexOf("\\"));
            	$('#profile_img').val(url);
            	
            	$('#Profile_img1').css('visibility','visible');
            }
            // alert(this.files[0]);
            reader.readAsDataURL(this.files[0]);  
        }else{
        	$('#profile_img').val("파일을 선택");
        	if($(this).val()=="파일을 선택"){
				alert("프로필을 선택해주세요");
				$(this).focus();
				return;
			}
        	$('#Profile_img1').css('visibility','hidden');
        }
	});
	
	$('.join_text_sub').change(function(){
		if($(this).hasClass("on")){//필수 임 
			var img=$(this).next();
			if(img.attr('id')=='ID_img'){
				var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				if(!regEmail.test($(this).val())){
					alert("이메일 양식 확인");
					$(this).focus();
					return;
				}
			}else if(img.attr('id')=='Check_Pw_img'){
				if($('#Pw_img').prev().val()!=$(this).val()){
					alert("비밀번호 양식이 다릅니다.");
					$(this).focus();
					return;
				}
			}else if(img.attr('id')=='Phone_img'){
				var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
				if(!regPhone.test($(this).val())){
					alert("연락처 양식 확인");
					$(this).focus();
					return;
				}
			}
			if($(this).val()==""){
				img.css('visibility','hidden');
			}else{
				img.css('visibility','visible');
			}
		}else{
			if($(this).attr('name')=="com_phone"){
				var regPhone = /^((0[1-9])[1-9]+[0-9]{5,6})|(02[1-9][0-9]{5})$/;
				if(!regPhone.test($(this).val())){
					alert("연락처 양식 확인");
					$(this).focus();
					return;
				}
			}
		}
	});
});
