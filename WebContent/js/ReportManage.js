$(document).ready(function(){
	$(".wrap").on("contextmenu", function() {
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
	$('.report_cont_info').mousedown(function(e) {
		var y=$(this).offset().top-$('.report_wrap').offset().top+$(this).height();
		var x=e.pageX;
		if (e.which == 3) {
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
        	 var chk_box=$(this).parent().children('td').eq(0).children('.check_box');
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
	
});
var selected_item=null;
var opt_flag=false;
$(document).on("click", function(){
	if(opt_flag){
		$('.option').hide();
		opt_flag=false;
		
	}
});