$(document).ready(function(){
     // 마우스 오버 색변화
       $('.option div').mouseenter(function(){
   			$(this).css({'background-color' : '#353d46', 'color':'white'});
   		});
       $('.option div').mouseleave(function(){
   			$(this).css({'background-color' : 'white', 'color':'black'});
       });       
});