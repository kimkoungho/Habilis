$(document).ready(function() {
	var open=null;// 열려있는 카드
	
	$('.card_pic').click(function(){
		if ($(this).hasClass("on"))
		{
			var index = $(".card_pic").index(this);
			$(this).css('opacity', 0.3);
			
			//$(this).parent('.card_slide').css('margin-left','25%');
			
			$('.card_make_cont').eq(index).toggle('slide', 'left', 400, function()
			{
				$('.card_pic').eq(index).animate({marginLeft: "30%"},500, function(){});
			});
			
			
			open=null;
			$(this).removeClass("on");
		}
		else
		{
			var time=0;
			if(open!=null){
				open.css('opacity', 0.3);
				open.next().toggle('slide', 'left', 500, function()
				{
					open.animate({marginLeft: "30%"},400,function(){});
				});
				
				(open).removeClass("on");
				time=1000;
			}
			
			var index = $(".card_pic").index(this);
			$(this).css('opacity', 1);
			setTimeout(function()
			{
				
				//$(this).parent('.card_slide').css('margin-left','3%');
				$('.card_pic').eq(index).animate({marginLeft: "10%"},400,function(){
					$('.card_make_cont').eq(index).toggle('slide', 'left', 500);
				});
				open = $('.card_pic').eq(index);
				
				$('.card_pic').eq(index).addClass("on");
			},time);
			
		}
	});
	
	$(".card_pic_plus").click(function() {
		
		if ($(this).hasClass("on")) {
			var index = $(".card_pic").index(this);
			$(this).css('opacity', 0.3);
			
			$('.card_make_cont').eq(index).toggle('slide', 'left', 400, function(){
				$('.card_pic_plus').eq(index).animate({marginLeft: "30%"},500,function(){});
			});
			
			open=null;
			$(this).removeClass("on");
			
		} else {
			var time=0;
			if(open!=null){
				open.css('opacity', 0.3);
				open.next().toggle('slide', 'left', 400,function(){
					open.animate({marginLeft: "30%"},500,function(){});
				});
				
				open.removeClass("on");
				time=1000;
			}
			
			var index = $(".card_pic").index(this);
			$(".card_pic").css('opacity', 0.3);
			$(this).css('opacity', 1);
			setTimeout(function(){
				$('.card_pic_plus').eq(index).animate({marginLeft: "10%"},500,function(){
					$('.card_make_cont').eq(index).toggle('slide', 'left', 500);
				});
				open=$('.card_pic_plus').eq(index);
				$('.card_pic_plus').eq(index).addClass("on");
			},time);
			
		}

	});
});