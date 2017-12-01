var dept_text_flag=false;
$(document).ready(function(){
	$("#add_dept").click(function(){
		$('#department_pro_btn', top.document).click();
	});
	
	$(".my_info_modify").click(function()
	{
	   $(top.document).find('#modi_pro_btn').click();
	});
	
	$('body').css('height', $(window).innerHeight());
	
	$("input").focus(function()
	{
		$("input").text(" ");
	});
	var st_date=new Date();
	var end_date=new Date();
	st_date.setMonth(end_date.getMonth()-1);
	
	st_date=st_date.format("yyyy-MM-dd");
	end_date=end_date.format("yyyy-MM-dd");
	
	
	$('.report_status_list').click(function()
	{
		var url=$('#center', top.document).attr('src');		
		var cmd_menu=$(this).parent('.report_option_sub_wrap').siblings('.report_option_select').children("span").eq(0).text();
		alert(cmd_menu);
		cmd_menu = cmd_menu.trim();
		var value=$(this).children().eq(0).text();
		value.trim();
		var cmd="";
		
		if(cmd_menu=='상태별 조회')
		{
			cmd="state";
			if(value=="대기") 
				value="wait";
			else if(value=="진행") 
				value="delay";
			else if(value=="승인") 
				value="finish";
			else
				value="delay";
		}
		else if(cmd_menu=='사용자별 조회')
		{
			cmd="user";
			value=$(this).children().eq(1).text();
		}
		else if(cmd_menu=='분류별 조회')
		{
			cmd="type";
		}
		
		url=url.substring(0,url.indexOf("page"))+"page=1&cmd="+cmd+"&value="+value;
		
		//alert(url);
		$('#center', top.document).attr('src',url);
	});
	
	//한 달전 ~ 현재 날짜로 초기화 
	$('.search_date').text(st_date+"~"+end_date);
	
	
	$('.term_cri').click(function(){
		var val=$(this).text();
		
		var now_select=$(this).parent('.term_cri_wrap').next('.search_date').text();
		now_select=now_select.split("~")[1];
		
		var now_date=new Date(now_select);
		var priv_date=new Date(now_select);
		if(val=="1주")
		{
			priv_date.setDate(priv_date.getDate()-7);
		}
		else if(val=="15일")
		{
			priv_date.setDate(priv_date.getDate()-15);
		}
		else if(val=="1개월")
		{
			priv_date.setMonth(priv_date.getMonth()-1);
		}
		else if(val=="3개월")
		{
			priv_date.setMonth(priv_date.getMonth()-3);
		}
		else
		{
			priv_date.setMonth(priv_date.getMonth()-6);
		}
		priv_date=priv_date.format("yyyy-MM-dd");
		now_date=now_date.format("yyyy-MM-dd");
		
		var url=$('#center', top.document).attr('src');
		url=url.substring(0, url.indexOf("page"));
		url+="page=1&cmd=term&value="+priv_date+"~"+now_date;
		
	
		$('#center', top.document).attr('src', url);
	});
	//한 달전 ~ 현재 날짜로 초기화 
	$(".add_team").click(function()
	{
		var wint = $(top.document).width();
		var winl = $(top.document).height();
		
		var windt = $(top.document).find(".team_make_toggle").width();
		var windl = $(top.document).find(".team_make_toggle").height();
		
		var lpo = wint/2-(windt/2);
		var tpo = winl/2-(windl/2);
		$(top.document).find(".center").css('opacity','0.3');
		$(top.document).find(".left_side").css('opacity','0.3');
		$(top.document).find(".team_make_toggle").css('left', '35%');
		$(top.document).find(".team_make_toggle").css('top', '35%');
		$(top.document).find(".team_make_toggle").toggle();		
	});
	
	
	//달력 api 
	$('.search_date').click(function()
	{
		var id=$(this).attr('id');
		
		$('#'+id, top.document).offset({top:$(this).offset().top, left:$(this).offset().left});
		$('#'+id, top.document).css('width',$(this).width());
		$('#'+id, top.document).show();
		$('#'+id, top.document).click();
		//$(this).hide();
	});
	
    //접기 펴기 아이콘 클릭

   
    
    $('.fold_menu_img').click(function()
    {
    	//alert(scnd_item.html());
    	
    	scnd_item.slideToggle();
    	//$(this).parent('.report_option_select').parent('.report_option_wrap').children('.report_option_sub_wrap').eq(second_index).slideToggle();
    });
    
    $('.menu').click(function()
    {
    	//alert(animate_flag);
    	if(animate_flag) return;
    	
    	$(".menu").css('background-color','#1d232a');
    	$(this).css('background-color','#20242c');
    	
    	var index=$(this).index();
    	var item=$('#first_side').children('.menu_sub').eq(index);
    	
    	if(index==7){
    		alert(top.document);
    		top.document.location.replace("LogOutAction.cont");
    		return;
    	}
    	
    	var dept_id=$('#first_side').children('.menu_sub').children('.sub_team_list').children('.sep_team').eq(0).children().eq(0).text();
    	var url="";
    	switch(index)
    	{
	    	case 0:url=""; break;
	    	case 1:url="../DeptInfoAction.cont?dept_id="+dept_id;break;
	    	case 2:url="../ChartListAction.cont?dept_id="+dept_id+'&page='+1+"&cmd=&value=";break;
	    	case 3:url='../TaskListAction.cont?dept_id='+dept_id+'&page='+1+"&cmd=&value=";break;
	    	case 4:url='../ReceiptListAction.cont?dept_id='+dept_id+'&page='+1+"&cmd=&value="; break;
	    	case 5:url='../ReportListAction.cont?dept_id='+dept_id+'&page='+1+"&cmd=&value="; break;
	    	case 6:url="QNA.jsp"; break;
    	}
    	
    	//if(index!=0)
    		//$(top.document).find(".center").attr('src',url);
    	if(index==6){
    		$(top.document).find(".center").attr('src',url);
    		
    		return;
    	}
    		
    	
    	if(first_item==null)
    	{
    		
    		if(index==0){
    			$('.side_bar').css('width','16.67%');
        		top.userToggle(true);
    			$('#first_side').css('width', '83.33%');
    		}else{
    			$('.side_bar').css('width','23%');
        		top.leftSideToggle1(true);
    			$('#first_side').css('width', '73%');
    		}
			
			animate_flag=true;
			item.toggle('slide','left',500, function(){
    			first_item=item;
    			animate_flag=false;
        	});
    	}
    	else if(first_index==index)
    	{
    		
    		animate_flag=true;
    		//alert(scnd_item.html());
    		if(scnd_item!=null){
    			var sub_cont;
    			if(first_index==1)
    			{
    				sub_cont=scnd_item.parent('.member_detail_list').parent('.sub_cont');
    			}
    			else
    			{
    				sub_cont=scnd_item.parent('.report_option_wrap').parent('.report_option_list').parent('.sub_cont');
    			}
    			
    			sub_cont.toggle('slide','left',300,function()
    			{
    				if(scnd_item.hasClass('on')){
    					scnd_item.removeClass('on');
    				}
    				
    				scnd_item.hide();
        			scnd_item=null;
    				top.leftSideToggle2(false);
    				$('.side_bar').css('width','25%');
    				$('#first_side').css('width', '75%');
    				
    				item.toggle('slide','left',500, function(){
    	    			first_item=null;
    					$('.side_bar').css('width','100%');
    					top.leftSideToggle1(false);
    					animate_flag=false;
    	        	});
        		});
    			
    		}
    		else
    		{
    			item.toggle('slide','left',500, function(){
        			first_item=null;
    				$('.side_bar').css('width','100%');
    				top.leftSideToggle1(false);
    				animate_flag=false;
            	});
    		}
    	}
    	else
    	{
    		if(index==0)
    		{
    			$('.side_bar').css('width','16.67%');
        		top.userToggle(true);
    			$('#first_side').css('width', '83.33%');
    		}
    		if(first_index==0)
    		{
    			$('.side_bar').css('width','25%');
        		top.leftSideToggle1(true);
    			$('#first_side').css('width', '75%');
    		}
    		
			animate_flag=true;
			if(scnd_item!=null){
				var sub_cont;
    			if(first_index==1){
    				sub_cont=scnd_item.parent('.member_detail_list').parent('.sub_cont');
    			}else{
    				sub_cont=scnd_item.parent('.report_option_wrap').parent('.report_option_list').parent('.sub_cont');
    			}
				
				sub_cont.toggle('slide','left',300,function(){
        			scnd_item=null;
    				top.leftSideToggle2(false);
    				$('.side_bar').css('width','25%');
    				$('#first_side').css('width', '75%');
    				
    				first_item.toggle('slide','left',500, function(){
    					if(index==0){
        	    			$('.side_bar').css('width','16.67%');
        	        		top.userToggle(true);
        	    			$('#first_side').css('width', '83.33%');
        	    		}
    	    			item.toggle('slide','left',500, function(){
    	    				first_item=item;
    	    				animate_flag=false;
    	            	});
    	        	});
				});
			}
			else
			{
				first_item.toggle('slide','left',500, function(){
	    			item.toggle('slide','left',500, function(){
	    				first_item=item;
	    				animate_flag=false;
	            	});
	        	});
			}
    		
    	}
    	first_index=index;
    });
    
    $('.sep_team').click(function()
    {
    	if(animate_flag) return;   	
    	var index=$(this).index();//부서의 인덱스    	
    	var sub_cont=$('#second_side').children('.sub_cont').eq(first_index);  	
    	var member_opt=null;
    	if(first_index==1)
    	{
    		member_opt=sub_cont.children('.member_detail_list').children('.team_member');
    		var dept_id=$('#first_side').children('.menu_sub').children('.sub_team_list').children('.sep_team').eq(index).children().eq(0).text();
    		$(top.document).find(".center").attr('src','../DeptInfoAction.cont?dept_id='+dept_id);
    	}
    	else if(first_index==2)
    	{
    		member_opt=sub_cont.children('.report_option_list').children('.report_option_wrap').eq(1).children('.report_option_sub_wrap');
    		var dept_id=$('#first_side').children('.menu_sub').children('.sub_team_list').children('.sep_team').eq(index).children().eq(0).text();
    		$(top.document).find(".center").attr('src','../ChartListAction.cont?dept_id='+dept_id+"&page="+1);
    	}
    	else if(first_index==3)
    	{
    		member_opt=sub_cont.children('.report_option_list').children('.report_option_wrap').eq(1).children('.report_option_sub_wrap');
    		var dept_id=$('#first_side').children('.menu_sub').children('.sub_team_list').children('.sep_team').eq(index).children().eq(0).text();
    		$(top.document).find(".center").attr('src','../TaskListAction.cont?dept_id='+dept_id+"&page="+1);
    	}
    	else if(first_index==4)
    	{
    		member_opt=sub_cont.children('.report_option_list').children('.report_option_wrap').eq(3).children('.report_option_sub_wrap');    		
    		var dept_id=$('#first_side').children('.menu_sub').children('.sub_team_list').children('.sep_team').eq(index).children().eq(0).text();
    		$(top.document).find(".center").attr('src','../ReceiptListAction.cont?dept_id='+dept_id+"&page="+1);
    	}
    	else if(first_index==5)
    	{
    		member_opt=sub_cont.children('.report_option_list').children('.report_option_wrap').eq(2).children('.report_option_sub_wrap');		
    		var dept_id=$('#first_side').children('.menu_sub').children('.sub_team_list').children('.sep_team').eq(index).children().eq(0).text();
    		$(top.document).find(".center").attr('src','../ReportListAction.cont?dept_id='+dept_id+"&page="+1);
    	}
    	else if(first_index==6)
    	{
    		
    	}
    	
    	if(scnd_item==null){//체크 된게 없음 + 열기
    		if(first_index==1)
    		{
    			member_opt.eq(index).show();
    		}
    		else
    		{
    			member_opt.eq(index).addClass('on');//체크
    		}
    		
    		top.leftSideToggle2(true);
    		$('.side_bar').css('width','12.5%');
    		$('#first_side').css('width', '37.5%');
    		$('#second_side').css('width', '50%');
    		animate_flag=true;
    		sub_cont.toggle('slide','left',500,function(){
        		scnd_item=member_opt.eq(index);
        		animate_flag=false;
        	});
    	}else if(scnd_item.html()==member_opt.eq(index).html()){//지금 이놈 체크 지우기
    		if(first_index==1){
    			member_opt.eq(index).hide();
    		}else{
    			member_opt.eq(index).removeClass('on');
    		}
    		
    		animate_flag=true;
    		sub_cont.toggle('slide','left',500,function(){
    			scnd_item=null;
				top.leftSideToggle2(false);
				$('.side_bar').css('width','25%');
				$('#first_side').css('width', '75%');
				animate_flag=false;
    		});
    	}
    	else
    	{//체크 지우고 지금 이놈 체크
    		if(first_index==1)
    		{
    			scnd_item.hide();
    			member_opt.eq(index).toggle('slide','left', 500, function(){
    				scnd_item=member_opt.eq(index);
    			});
    		}
    		else
    		{
    			scnd_item.removeClass('on');
        		member_opt.eq(index).addClass('on');//체크
    			if(scnd_item.css('display')!='none'){
    				scnd_item.hide();
    				animate_flag=true;
    				member_opt.eq(index).toggle('slide','left', 500, function(){
        				scnd_item=member_opt.eq(index);
        				animate_flag=false;
    				});
    			}else{
            		scnd_item=member_opt.eq(index);
    			}
    		}
    	}
    	
		
    	
    });

});
var menu_flag=false;
var first_item=null, scnd_item=null, animate_flag=false;
var first_index=-1;

function sucWriteReport(){
	var item=$('#first_side').children('.menu_sub').eq(5);
	var sub_cont=scnd_item.parent('.report_option_wrap').parent('.report_option_list').parent('.sub_cont');
	
	sub_cont.toggle('slide','left',300,function(){
		scnd_item=null;
		top.leftSideToggle2(false);
		$('.side_bar').css('width','25%');
		$('#first_side').css('width', '75%');
		
		first_item.toggle('slide','left',500, function(){
			item.toggle('slide','left',500, function(){
				first_item=item;
				animate_flag=false;
        	});
    	});
	});
	first_index=5;
}

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};
