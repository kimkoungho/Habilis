var st_date, end_date;

$(document).ready(function() {
	$('#profile_img_modi').click(function(){
		$('#profile_file_modi').click();
	});
	
	$('#profile_file_modi').change(function(){
		if (this.files[0]) {
            var reader = new FileReader();  
            reader.onload = function (e) {  
            	var url=$('#profile_file_modi').val();
            	url=url.substr(url.lastIndexOf("\\"));
            	$('#profile_img_modi').val(url);
            	
            	//$('#Profile_img1_modi').css('visibility','visible');
            }
            // alert(this.files[0]);
            reader.readAsDataURL(this.files[0]);  
        }else{
        	$('#profile_img_modi').val("파일을 선택");
        	if($(this).val()=="파일을 선택"){
				alert("프로필을 선택해주세요");
				$(this).focus();
				return;
			}
        	//$('#Profile_img1_modi').css('visibility','hidden');
        }
	});
	
	$('#company').click(function(){
         $('#depart_name').hide();
         $('#company_name').show();
     });
	$('#depart').click(function(){
         $('#depart_name').show();
         $('#company_name').hide();
     });
		
	   downtime = 0;
       presstime = 0;
       $(".float_button").mousedown(function()
       {
          var d = new Date();   
          downtime = d.getTime();   
       });
       
       $(".float_button").mouseup(function(){
          var d = new Date();
          presstime = d.getTime()-downtime;
       });
       
       
       
      
       $(".float_button").mouseenter(function()
       {
          $(this).css('border','2px solid black');
          $(this).draggable();
          
       });
       $(".float_button").mouseleave(function(){
          $(this).css('border','none');
       });
	
	$('#receipt_date').dateRangePicker({
		language:'kor',
		separator:' ~ ',
		showTopbar : false,
		showShortcuts:false,
		autoClose: true,
		getValue: function()
		{
			return this.innerHTML;
		},
		setValue: function(s)
		{
			//alert(s);
			this.innerHTML = s;
			$('#left_side').contents().find('#receipt_date').text(s);
			
			var url=$('#center').attr('src');
			url=url.substring(0, url.indexOf("page"));
			url+="page=1&cmd=term&value="+s;
			//alert(url);
			$('#center').attr('src', url);
		}
	})
	.bind('datepicker-closed',function()
	{
		$(this).hide();
		$(this).css({'top':0, 'left':0});
	});
	
	$('#report_date').dateRangePicker({
		language:'kor',
		separator:' ~ ',
		showTopbar : false,
		showShortcuts:false,
		autoClose: true,
		getValue: function()
		{
			return this.innerHTML;
		},
		setValue: function(s)
		{
			//alert(s);
			this.innerHTML = s;
			$('#left_side').contents().find('#report_date').text(s);
			var url=$('#center').attr('src');
			url=url.substring(0, url.indexOf("page"));
			url+="page=1&cmd=term&value="+s;
			//alert(url);
			$('#center').attr('src', url);
		}
	})
	.bind('datepicker-closed',function()
	{
		$(this).hide();
		$(this).css({'top':0, 'left':0});
	});
	
	$('#dash_date').dateRangePicker({
		language:'kor',
		separator:' ~ ',
		showTopbar : false,
		showShortcuts:false,
		autoClose: true,
		getValue: function()
		{
			return this.innerHTML;
		},
		setValue: function(s)
		{
			//alert(s);
			this.innerHTML = s;
			$('#left_side').contents().find('#dash_date').text(s);
			
			var url=$('#center').attr('src');
			url=url.substring(0, url.indexOf("page"));
			url+="page=1&cmd=term&value="+s;
			//alert(url);
			$('#center').attr('src', url);
		}
	})
	.bind('datepicker-closed',function()
	{
		$(this).hide();
		$(this).css({'top':0, 'left':0});
	});
	
});

function userToggle(flag) {
	other_flag = flag;
	if (flag) {
		$('.left_side').css('width', '30%');
		$('.center').css('width', '70%');
	} else {
		$('.left_side').css('width', '5%');
		$('.center').css('width', '95%');
	}
}

var fir_flag = false, scd_flag = false, other_flag = false;

// 왼쪽 1번째 메뉴들 toggle event
function leftSideToggle1(flag) {
	fir_flag = flag;
	if (flag) {
		$('.left_side').css('width', '20%');
		$('.center').css('width', '80%');
	} else {
		$('.left_side').css('width', '5%');
		$('.center').css('width', '95%');
	}
}

// 왼쪽 2번째 메뉴들 toggle event
function leftSideToggle2(flag) {
	scd_flag = flag;
	if (flag) {
		$('.left_side').css('width', '40%');
		$('.center').css('width', '60%');
	} else {
		$('.left_side').css('width', '20%');
		$('.center').css('width', '80%');
	}
}

//

function disableCheck1(obj) {
   var sel1=document.getElementById("select1");
   var sel2=document.getElementById("select2");
   var sel3=document.getElementById("select3");
   var i=1;
      if (sel1[sel1.selectedIndex].value==1){            
            sel2[1].disabled = true;
            sel3[1].disabled = true;
          }
      else if(sel1[sel1.selectedIndex].value!=1){
            sel2[1].disabled = false;
            sel3[1].disabled = false;
      }
}
function disableCheck2(obj) {
   var sel1=document.getElementById("select1");
   var sel2=document.getElementById("select2");
   var sel3=document.getElementById("select3");
      if (sel2[sel2.selectedIndex].value==1){            
         sel1[1].disabled = true;
         sel3[1].disabled = true;
      }
      else if(sel2[sel2.selectedIndex].value!=1){
         sel1[1].disabled = false;
         sel3[1].disabled = false;
      }
}
function disableCheck3(obj) {
   var sel1=document.getElementById("select1");
   var sel2=document.getElementById("select2");
   var sel3=document.getElementById("select3");
  if (sel3[sel3.selectedIndex].value==1){            
     sel2[1].disabled = true;
     sel1[1].disabled = true;
  }
  else if(sel3[sel3.selectedIndex].value!=1){
     sel2[1].disabled = false;
     sel1[1].disabled = false;
  }
}
//부서, 회사 추가 시 짝수가 맞는지 검사
function pairCheck(type){
	var pair_flag=false;
	if(type=="company"){
		 //$("input[name=jmnote]").attr("value");
		 for(var i=1; i<=3; i++){
			 var title=$("input[name=dept_title_"+i+"]").prop("value");
			 var head=$("input[name=dept_header_"+i+"]").prop("value");
			 if((!title && head) ||(title && !head)){
				 pair_flag=true;
			 }
		 }
	}else{
		for(var i=1; i<=3; i++){
			 var member=$("input[name=dept_member_"+i+"]").prop("value");
			 var priv=$("select[name=dept_member_priv_"+i+"]").prop("value");
			 if((!member && priv!='0') ||(member && priv=='0')){
				 pair_flag=true;
			 }
		 }
	}
	
	if(pair_flag)
		return false;
	else 
		return true;
}
 