window.apiKey = 'AIzaSyDYaT7T3kSjUwFtpEs5X02Gmt7jxso2oKU';

//window.apiKey='AIzaSyA3S0UPfddA98CwMEQWLayQDNBrE5YCxsA';
var CV_URL = 'https://vision.googleapis.com/v1/images:annotate?key=' + window.apiKey;

$(document).ready(function(){
	$('.ocr_button_save').click(function(){
		$('#use').val($('#ocr').val());
		$('#use_date').val($('#ocr_date').val());
		$('#cost').val($('#ocr_cost').val());
		$('#ocr_close_btn').click();
	});
	$('.ocr_button_cancel').click(function(){
		$('#ocr').val('');
		$('#ocr_date').val('');
		$('#ocr_cost').val('');
		$('#ocr_close_btn').click();
	});
	
	$('#ocr_button').click(function(){
		var fd = new FormData();
		 fd.append("r_img",$("input[name=r_img]")[0].files[0]);
		 
		 
		 if($('#img').val()==null || $('#img').val()=='파일을 선택'){
			 alert('이미지를 선택해주세요.');
			 return;
		 }
		 
		 var file = $('#fileform [name=r_img]')[0].files[0];
		 var reader = new FileReader();
		 reader.onloadend = processFile;
		 reader.readAsDataURL(file);
		 
	    
		$('#ocr_analy_btn').click();
	});
	$('#img').click(function(){
		$('#r_img').click();
	});
	
	$('#modify_img').click(function(){
		$('#r_modify_img').click();
	});
	
//	
	$(".tab_wrap").on("contextmenu", function() {
	      return false;
	});
	
	
	$(".select_all").click(function(){
	    $(".check_box").prop('checked', true);
	    $(".report_cont_line").css({'background-color':"#39a0c7",'color':'white'});
	    var num = $('input:checkbox:checked').length;
	    $(".num").text(num);
	 });
	
	$(".select_no").click(function(){
		$(".check_box").prop('checked', false);
		$(".report_cont_line").css({'background-color':"white",'color':'black'});

		//location.reload();
		$(".num").text("0");
	 });
	
//	
	//마우스 이벤트
	$('.report_cont_info').mousedown(function(e) {
		var y=$(this).offset().top-$('.tab_wrap').offset().top+$(this).height();
		var x=e.pageX;
		
		if (e.which == 3)
		{
			//alert($('.option').css('display')+"....."+opt_flag);
			if(selected_item!=null){
				selected_item.css({'background-color' : 'white', 'color':'black'});
			}
				
			selected_item=$(this).parent();
			$(".option").css('top', y);
			$(".option").css('left', x);
			if($('.option').css('display')=='none'){
				$(".option").slideToggle(500,function(){});
			}else{
				$(".option").hide();
				$(".option").slideToggle(500,function(){});
			}
				
			
			opt_flag=true;
			$(this).parent().css({'background-color' : '#0078a6', 'color':'white'});
         }else if(e.which==1){
        	 //alert($(this).parent().children('td').eq(3).html());
        	 var chk_box=$(this).parent().children('td').eq(3).children('.check_box');
        	 if(chk_box.prop("checked")){
        		 var k = $(".num").text();
        		 k = Number(k)-1;
        		 $(".num").text(k);
        		 chk_box.parent().parent(".report_cont_line").css({'background-color':"white",'color':'black'});
        		 chk_box.prop('checked', false);  
        	 }else{
        		 var k = $(".num").text();
        		 k = Number(k)+1;
        		 $(".num").text(k);
        		 chk_box.parent().parent(".report_cont_line").css({'background-color':"#39a0c7",'color':'white'});
        		 chk_box.prop('checked', true);  
        	 }   	 
         }
	  });
	
	$('.option div').mouseenter(function(){
		$(this).css({'background-color' : '#353d46', 'color':'white'});
	});
	$('.option div').mouseleave(function(){
		$(this).css({'background-color' : 'white', 'color':'black'});
	});
	
	
	
	$('.detail').click(function(){
		dialogSet('#receipt_detail');
		
		//$('#wrap').css('opacity','0.3');
		//$('#receipt_detail').slideToggle();
		$('#receipt_detail_btn').click();
	});
	   
	
	$('#r_img').change(function(){
        if (this.files[0]) {
            var reader = new FileReader();  
            reader.onload = function (e) {  
                //$('.default_image').parent().css("background-image", "url("+e.target.result+")");
                
                //alert(e.target.result);
            	$('#pic img').attr('src',e.target.result);
            	var url=$('#r_img').val();
            	url=url.substr(url.lastIndexOf("\\"));
            	$('#img').val(url);
            }
            // alert(this.files[0]);
            reader.readAsDataURL(this.files[0]);  
        }else{
        	//alert('cancel');
        	$('#img').val("파일을 선택");
        	$('#pic img').attr('src', '../IMAGES/report.png');
           //$('.default_image').parent().css("background-image", "url('IMAGES/review_default.png')");
        }
   });
	
	$('#r_modify_img').change(function(){
        if (this.files[0]) {
            var reader = new FileReader();  
            reader.onload = function (e) {  
                //$('.default_image').parent().css("background-image", "url("+e.target.result+")");
                
                //alert(e.target.result);
            	$('#modify_pic img').attr('src',e.target.result);
            	var url=$('#r_modify_img').val();
            	url=url.substr(url.lastIndexOf("\\"));
            	$('#modify_img').val(url);
            }
            // alert(this.files[0]);
            reader.readAsDataURL(this.files[0]);  
        }else{
        	$('#modify_img').val("파일을 선택");
        	$('#modify_pic img').attr('src', '../IMAGES/report.png');
           //$('.default_image').parent().css("background-image", "url('IMAGES/review_default.png')");
        }
   });
	
	$('.receipt_img_icon').mouseenter(function(event){
		var url=$(this).parent('td').parent('tr').children('.report_cont_info').eq(1).text();
		//alert(url);
		//alert(event.pageX+"..."+event.pageY);
		$('#receipt_img_detail').children('img').attr('src',url);
		$('#receipt_img_detail').css({'top':$(this).offset().top ,'left':$(this).offset().left+$(this).width()+10-$('#receipt_img_detail').width()});
		
		$('#receipt_img_detail').show();
	});
	
	$('#receipt_img_detail').mouseleave(function(){
		$('#receipt_img_detail').hide();
	});
	
	$('#use_date').dateRangePicker({
		autoClose: true,
		singleDate : true,
		showShortcuts: false, 
		format: 'YYYY.MM.DD HH:mm:ss',
		time: {
			enabled: true
		},
	});
	
	//수정
	$('#modify_use_date').dateRangePicker({
		autoClose: true,
		singleDate : true,
		showShortcuts: false, 
		format: 'YYYY.MM.DD HH:mm:ss',
		time: {
			enabled: true
		},
	});
	
	$('#modify_cost').focusin(function(){
		$(this).val('');
	});
	
	   $(".tab_list").click(function() {
	         $(this).css('border-left','1px solid white');
	         $(this).css('border-top','2px solid #0078a7');
	         $(this).css('border-bottom','1px solid white');
	         $(this).css('border-right','1px solid white');
	         $(this).css('background-color','white');
	         $(this).css('color','black');
	         
	         $(".tab_all").css('background-color','#eeeff3');
	         $(".tab_all").css('color','black');
	         $(".tab_all").css('border-left','2px solid #0078a7');
	         $(".tab_all").css('border-bottom','2px solid #0078a7');
	         $(".tab_all").css('border-top','transparent');
	         $(".tab_all").css('border-right','transparent');
	         
	         $(".tab_plus").css('background-color','#eeeff3');
	         $(".tab_plus").css('color','black');
	         $(".tab_plus").css('border-bottom','2px solid #0078a7');
	         $(".tab_plus").css('border-top','transparent');
	         $(".tab_plus").css('border-left','transparent');
	         
	         $('.tab_wrap').hide();
	         $(".tab_wrap").eq(0).show();
	      });
	      $(".tab_all").click(function() {
	         $(this).css('background-color','white');
	         $(this).css('color','black');
	         $(this).css('border-top','2px solid #0078a7');
	         $(this).css('border-right','2px solid #0078a7');
	         $(this).css('border-left','1px solid white');
	         $(this).css('border-bottom','1px solid white');
	         
	         $(".tab_list").css('background-color','#eeeff3');
	         $(".tab_list").css('color','black');
	         $(".tab_list").css('border-left','transparent');
	         $(".tab_list").css('border-top','transparent');
	         $(".tab_list").css('border-right','2px solid #0078a7');
	         $(".tab_list").css('border-bottom','2px solid #0078a7');
	         
	         $(".tab_plus").css('background-color','#eeeff3');
	         $(".tab_plus").css('color','black');
	         $(".tab_plus").css('border-bottom','2px solid #0078a7');
	         $(".tab_plus").css('border-top','transparent');
	         $(".tab_plus").css('border-left','transparent');
	         $('.tab_wrap').hide();
	         $(".tab_wrap").eq(1).show();
	         $('#calendar').fullCalendar('render');
	      });
	      $(".tab_plus").click(function() {
	         $(this).css('background-color','white');
	         $(this).css('color','black');
	         $(this).css('border-bottom','1px solid white');
	         $(this).css('border-top','2px solid #0078a7');
	         $(this).css('border-left','2px solid #0078a7');
	         
	         $(".tab_list").css('background-color','#eeeff3');
	         $(".tab_list").css('color','black');
	         $(".tab_list").css('border-right','transparent');
	         $(".tab_list").css('border-top','transparent');
	         $(".tab_list").css('border-left','transparent');
	         $(".tab_list").css('border-bottom','2px solid #0078a7');
	         
	         $(".tab_all").css('background-color','#eeeff3');
	         $(".tab_all").css('color','black');
	         $(".tab_all").css('border-top','transparent');
	         $(".tab_all").css('border-bottom','2px solid #0078a7');
	         $(".tab_all").css('border-left','transparent');
	         $(".tab_all").css('border-right','transparent');
	         
	         $('.tab_wrap').hide();
	         $(".tab_wrap").eq(2).show();
	      });
});
var selected_item=null;

var opt_flag=false, calendar_flag=false;
$(document).on("click", function(){
	if(opt_flag){
		$('.option').hide();
		opt_flag=false;
		
	}
	if(calendar_flag){
		$('#schedule_detail').hide();
		calendar_flag=false;
	}
});

function dialogSet(dialog_id){
	var container;
	if(dialog_id=='#receipt_modify'){
		container=$(dialog_id).children('.modal-dialog').children('.modal-content').children('.modal-body').children().children('.content_info');
		$('#receipt_modify_id').val(selected_item.attr('id'));
	}else{
		container=$(dialog_id).children('.modal-dialog').children('.modal-content').children('.modal-body').children('.content_info');
	}
	
	//alert(selected_item.attr('id'));
	var num=selected_item.children('td').eq(0).text();
	container.children('.member_title').text("NO. "+num);//제목
	var tr_list=container.children('.member_sub_wrap').children().children('tr');
	
	
	for(var i=0; i<tr_list.length; i++){
		var value="";
		
		switch(i){
		case 0:value=selected_item.children('.report_cont_info').eq(0).text();break;//담당자
		case 1:value=selected_item.children('.report_cont_info').eq(3).text();break;//업체
		case 2:value=selected_item.children('.report_cont_info').eq(2).text();break;//일시
		case 3:value=selected_item.children('.report_cont_info').eq(6).text();break;//금액
		case 4:value=selected_item.children('.report_cont_info').eq(4).text();break;//분류
		case 5:value=selected_item.children('.report_cont_info').eq(5).text();break;//방법
		case 6:value=selected_item.children('.report_cont_info').eq(8).text();break;//등급
		case 7:value=selected_item.children('.report_cont_info').eq(9).text();break;//메모
		}
		
		if(i==0){
			tr_list.eq(i).children('.member_second').eq(0).text(value);
			var url=selected_item.children('.report_cont_info').eq(1).text();
			if(dialog_id=='#receipt_modify'){
				tr_list.eq(1).children('.member_pic').children('#modify_pic').children().attr('src', url);
				//alert(tr_list.eq(i).children('.member_second').eq(1).children('.member_textfield').val());
				tr_list.eq(i).children('.member_second').eq(1).children('.member_textfield').val(url);
			}else{
				tr_list.eq(0).children('.member_pic').children().attr('src',url);
			}
			
		}else if(i<=3){
			tr_list.eq(i).children('.member_second').children().val(value);
		}else if(i<=6){
			//alert(value);
			//$("#select_id").val("1").prop("selected", true);
			if(i==5){
				if(value=='개인카드')
					value='per';
				else
					value='cor';
			}
			tr_list.eq(i).children('.member_second').children('.member_Thrid').val(value).prop('selected', true);
		}else if(i==7){
			tr_list.eq(i).children('.member_text').children('.member_textarea').val(value);
		}
	}	
}


//vision
function processFile (event) {
	var content = event.target.result;
	sendFileToCloudVision(content.replace('data:image/jpeg;base64,', ''));
}

/**
 * Sends the given file contents to the Cloud Vision API and outputs the
 * results.
 */
function sendFileToCloudVision (content) {
  var type = $('#fileform [name=type]').val();

  // Strip out the file prefix when you convert to json.
  var request = {
    requests: [{
      image: {
        content: content
      },
      features: [{
        type: "TEXT_DETECTION",
        maxResults: 200
      }]
    }]
  };

  $('#results').text('Loading...');
  $.post({
    url: CV_URL,
    data: JSON.stringify(request),
    contentType: 'application/json'
  }).fail(function (jqXHR, textStatus, errorThrown) {
    $('#results').text('ERRORS: ' + textStatus + ' ' + errorThrown);
  }).done(displayJSON);
}

/**
 * Displays the results.
 */
function displayJSON (data) {
	  var contents = JSON.stringify(data, null, 4);
	  
	  var JSONData = $.parseJSON(contents);
	  var text=JSONData.responses[0].textAnnotations[0].description;
	  alert(text);
	  
	  var name, date, cost, card;

      var text_arr=text.split("\n");
      var regname=/((상)|(삼))(\s*)(호)/;
      var regdate=/((19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]))|((19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1]))|((19[7-9][0-9]|20\d{2})년(0[0-9]|1[0-2])월(0[1-9]|[1-2][0-9]|3[0-1])일)/;
      var regcost=/((금)(\s*)(액))|(합)(\s*)(계)/;
      var reg_cost_format=/([1-9][0-9]{0,2}(,[0-9]{3})*)/;
      var regcard=/(카)(\s*)(드)(\s*)(명)/;

      var cost_flag=false;
      for(var i=0; i<text_arr.length; i++){
    	  if(i==0){
    		  name=text_arr[i];
    	  }
          if(regname.test(text_arr[i])){
              name=text_arr[i].substring(text_arr[i].search(regname));
          }
          else if(regdate.test(text_arr[i])){
             date=text_arr[i];
             if(date.includes("일시")){
            	date=date.split("일시")[1];
             }
             if(date.includes("밀시")){
            	 date=date.split("밀시")[1];
             }
             if(date.includes("일자")){
             	date=date.split("일자")[1];
              }
             if(date.includes("시간")){
             	date=date.split("시간")[1];
              }
             
              if(date.includes('년')){
            	  date=date.replace('년','-');
            	  date=date.replace('월','-');
            	  date=date.replace('일','');
              }
              if(date.includes('/')){
            	  date=date.replace('/','-');
            	  date=date.replace('/','-');
              }
              
              if(date.length>20){
            	  date=date.substring(0,20);
              }
          }
          else if(regcost.test(text_arr[i])){
        	  if(reg_cost_format.test(text_arr[i]))
        		  cost=text_arr[i].substring(text_arr[i].search(regcost));
        	  else
        		  cost=text_arr[i+1];
          }
          else if(regcard.test(text_arr[i])){
              card=text_arr[i].substring(text_arr[i].search(regcard));
          }
      }
      console.log(text);
      $('#ocr').val(name);
      $('#ocr_date').val(date);
      $('#ocr_cost').val(cost);
      
      alert(name+"||"+date+"||"+cost);
	  //$('#results').text(contents);
	  
	  var evt = new Event('results-displayed');
	  evt.results = contents;
	  document.dispatchEvent(evt);
}


