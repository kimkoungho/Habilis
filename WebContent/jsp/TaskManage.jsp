<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
   ArrayList<HashMap> task_list = (ArrayList<HashMap>)request.getAttribute("task_list");
   ArrayList<String> user_name = (ArrayList<String>)request.getAttribute("user_names");
   int dept_id=Integer.parseInt(request.getParameter("dept_id"));
   String cmd=(String)request.getParameter("cmd");
   String value=(String)request.getParameter("value");   
   String name=(String)session.getAttribute("user_name");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title></title>
   <meta charset="utf-8" />
   <script src="${pageContext.request.contextPath}/include/jquery.js"></script>
   <script src="${pageContext.request.contextPath}/js/TaskManage.js"></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/TaskManage.css">
   <link href='${pageContext.request.contextPath}/include/fullcalendar.css' rel='stylesheet' />
   <link href='${pageContext.request.contextPath}/include/fullcalendar.print.css' rel='stylesheet' media='print' />
   <script src='${pageContext.request.contextPath}/include/moment.min.js'></script>
   <script src='${pageContext.request.contextPath}/include/fullcalendar.min.js'></script>
   <script src="${pageContext.request.contextPath}/bootstrap.min.js"></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap.min.css"/>
   
</head>
<script>
$(document).ready(function()
   {
      var index=-1;
      $('#calendar').fullCalendar({
         header: {
            left: ' prev, today ',
            center: 'title',
            right: ' month next  '
         },
         defaultDate: '2016-11-20',
         navLinks: true, // can click day/week names to navigate views
         selectable: true,
         selectHelper: true,
         editable: true,
         eventLimit: true, // allow "more" link when too many events
         events: [
         <%
         for(int i=0; i<task_list.size(); i++)
         {      
            String title=(String)task_list.get(i).get("task_title");
            String color2=(String)task_list.get(i).get("task_color");
         %>
         //누적인지 확인
             {
                title : '<%=title%>',
                start : '<%=((String)(task_list.get(i).get("task_date"))).substring(0,10)%>',
                color : '<%=(String)task_list.get(i).get("task_color")%>'
             }
         <%
            
               if(i!=task_list.size()-1)
                  out.println(",");
         }
         %>
         ],
         eventClick: function(event)
         {
            title=event.title;
            start=event.start;
            
             var position = $(this).offset();
             $(".option").css('top',position.top);
             $(".option").css('left',position.left+$(this).parent().width());
          
             $(".option").slideToggle(500,function()
             {
                   calendar_flag=true;
              });
               
         }
      });
    
      $("#work_plus").click(function()
                {
                   $('#Task_plus_btn').click();
                   
                });
     
      $("#plus_task").click(function()
       {              
         if($('.table_rank').val()=="menu")
         {
            task_input.table_rank.focus();
            return;
         }
           if($('.table_status').val()=="menu")
         {
            task_input.table_status.focus();
            return;
         }
         task_input.submit(); 
         $('#Task_plus').contents().find('.close').click();
       
       });  
       $('#modi_task').click(function()
          {
             $(".option").hide();
             
             $(".modi_title").val(title);
               var cl = "."+title;
               var modi_id =$.trim($(cl).children("td").eq(0).text());
               var modi_name =$(cl).children("td").eq(1).text();                  
               var modi_title =$(cl).children("td").eq(2).text();                  
               var modi_state =$(cl).children("td").eq(3).text();                  
               var modi_date =$(cl).children("td").eq(4).text();                  
               var modi_rank =$(cl).children("td").eq(5).text();               
               var modi_content =$(cl).children("td").eq(6).text();   
               
               $(".modi_id").val(modi_id);   
               $(".modi_manager").val(modi_name);                  
               $(".modi_state").val(modi_state);            
               $(".modi_rank").val(modi_rank);                                    
               $(".modi_date").val(modi_date);
               $(".modi_area").val(modi_content);
               
             $('#Task_modi_btn').click();
             
            });
       $('#modi_plus_task').click(function()
              {              
                var manager = $(".modi_manager").val();
                var title = $(".modi_title").val();
                   var rank = $(".modi_rank").val();
                   var state = $(".modi_state").val();
                   var color;
                   
                   for(var i = 0; i < $(".chkbox").length; i++)
                      {
                            if($(".chkbox").eq(i).children(".table_color").is(":checked"))
                               {
                                  index = i;
                                  break;
                               }
                      } 
                   if(index==-1){
                	   alert('색상 체크');
                	   return;
                   }
                   
                  switch(index)
                  {
                     case 1: color = "#00a65";  break;
                     case 2: color = "#00cef";  break;
                     case 3: color = "#01ff70"; break;
                case 4: color = "#3c8dbc"; break;
                     case 5: color = "#605ca8"; break;
                 case 6: color = "#777777";   break;
                 case 7: color = "#777777";   break;
                 case 8: color = "#777777";   break;
                  }
                  
                 if($('.modi_rank').val()=="menu")
             {
                 task_modify.table_rank.focus();
                return;
             }
              if($('.modi_status').val()=="menu")
             {
                 task_modify.table_status.focus();
                return;
             }
             task_modify.submit();   
             $('#Task_modi').contents().find('.close').click();
              
              });
            $('#det_task').click(function()
            {
               $(".option").hide();
               $(".detail_title").text(title);
               var cl = "."+title;
               var modi_id =$(cl).children("td").eq(0).text();
               var modi_name =$(cl).children("td").eq(1).text();   
               var modi_title =$(cl).children("td").eq(2).text();                  
               var modi_state =$(cl).children("td").eq(3).text();                  
               var modi_date =$(cl).children("td").eq(4).text();                  
               var modi_rank =$(cl).children("td").eq(5).text();               
               var modi_content =$(cl).children("td").eq(6).text();
               
               $(".detail_title").text(modi_title);
               $(".detail_manager").text(modi_name);       
               $(".detail_state").text(modi_state);            
               $(".detail_rank").text(modi_rank);                                    
               $(".detail_date").text(modi_date);
               $(".detail_area").text(modi_content);
                     
               if(modi_state == "wait")
                  {
                     $(".detail_state").text("진행중");     
                  }
               else if(modi_state == "delay")
                  {
                     $(".detail_state").text("보류");     
                  }
               else if(modi_state == "finish")
                  {
                     $(".detail_state").text("완료");     
                  }
            
               switch(Number(modi_rank))
               {
                  case 0: $(".detail_rank").text("0등급");   break;
                  case 1: $(".detail_rank").text("1등급");   break;
                  case 2: $(".detail_rank").text("2등급");   break;
                  case 3: $(".detail_rank").text("3등급");   break;
               }
                                                         
               $(".detail_date").text(modi_date);
               $(".detail_area").text(modi_content);
             $('#Task_detail_btn').click();
            });
           $('#del_task').click(function()
            {            
                  var cl = "."+title;          
                  var modi_id =$.trim($(cl).children("td").eq(0).text());               
                  var url="./DelTaskAction.cont?dept_id=<%=dept_id %>&cmd=<%=cmd %>&value=<%=value %>&task_id="+modi_id+"";                     
                  location.replace(url);   
            });

            $('#deta_task').click(function()
            {
               $('#Task_detail').contents().find('.close').click();
            });
   });
</script>
<body>
   <div class="total_wrap">
      <div class="content_menu">
         <div class="menu_name">WORKING STATUS REPORT</div>
      </div>
      <div class="report_wrap">
         <div class="report_sub_wrap">
            <div class="select_date_wrap">
               <span id="work_plus" class="append_work"> +새업무 추가 </span> 
            </div>
            <div id='calendar'></div>
         </div>
      </div>
    
   </div>
    <button class="btn btn-primary" id="Task_plus_btn" data-toggle="modal" data-target="#Task_plus" style="display:none"></button>
     <div class="modal fade" id="Task_plus" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg" style="width:45%; margin-top:5%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
                        <span>새업무 추가하기</span>
            </div>
        </div>
               <div class="modal-body">
               <form name="task_input" method=post action="./InsertTaskAction.cont?dept_id=<%=dept_id %>&cmd=<%=cmd %>&value=<%=value %>">
               <div class="new_cont_wrap">
                  <table class="new_block">
                     <tr>
                        <td class ="table_first" >담당자</td>
                        <td class ="table_first">제목</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <input class="table_manager"  type="text" name="task_manager" value="<%=name%>"/>
                        </td>
                        <td class= "table_second">
                           <input class="table_title"  type="text" name="task_title"/>
                        </td>
                     </tr>
                     <tr>
                        <td class ="table_first">상태</td>
                        <td class ="table_first">Create Event</td>
                     </tr>
                     <tr>
                        <td class = "table_second" style="border:none; font-size:10px">
                           <select class="task_state"  name="task_state" style="width:90%; float:left;">
                              <option value="menu">상태를 선택해 주세요</option>
                              <option value="wait">진행중</option>
                              <option value="delay">보류</option>
                              <option value="finish">완료</option>
                           </select>
                        </td>
                        
                        <td class = "table_second" >
                          <div class = "table_event" >
                              <div class="chkbox">
                                 <input type="checkbox" class="table_color"  name="color"  value="#dd4b39"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color1.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#f39c12" />
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color2.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color" name="color"  value="#01ff70"/>
                                 <img src="${pageContext.request.contextPath}/IMAGES/table_color3.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#3c8dbc"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color4.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#605ca8"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color5.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#777777"/>
                                 <img src="${pageContext.request.contextPath}/IMAGES/table_color6.png" />
                              </div>
                              
                               <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#00c0ef"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color7.png" />
                              </div>   
                              
                               <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#00a65a"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color8.png" />
                              </div>                      
                           </div>
                        </td>
                     </tr>
                     <tr>
                        <td class ="table_first">등급</td>
                        <td class ="table_first">내용</td>
                     </tr>
                     <tr>
                        <td class = "table_second" style="border:none; font-size:10px">
                           <select class="table_rank" name="task_rank" style="width:90%; float:left;">
                              <option style="color:#cccccc;" value="menu">등급을 선택해 주세요</option>
                              <option value="0">0등급</option>
                              <option value="1">1등급</option>
                              <option value="2">2등급</option>
                              <option value="3">3등급</option>  
                           </select>
                        </td>
                        <td rowspan="3" class = "table_second">
                            <textarea class="text_area" rows="5" name="task_content"></textarea>
                         </td>
                     </tr>
                     <tr>
                        <td class ="table_first">일자</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <input class="table_date" type="text" name="task_date"/>
                           <input class="table_id"  style="display:none" type="text" name="task_id">
                        </td>
                     </tr>
                     </table>                            
         </div>
         <div id=plus_task class="plus">추가하기</div>
       </form>
       </div>
      </div>
   </div>
  
  <!--  업무 수정 등록 부분 입니다. -->
     <button class="btn btn-primary" id="Task_modi_btn" data-toggle="modal" data-target="#Task_modi" style="display:none"></button>
   <div class="modal fade" id="Task_modi" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg" style="width:45%; margin-top:5%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
                <span>업무 수정</span>
          </div>
        </div>
          <div class="modal-body">
             <form name="task_modify" method=post action="./ModifyTaskAction.cont?dept_id=<%=dept_id %>&cmd=<%=cmd %>&value=<%=value %>" >
             <div class="new_cont_wrap">
                  <table class="new_block">
                     <tr>
                        <td class ="table_first" >담당자</td>
                        <td class ="table_first">제목</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <input class="table_manager modi_manager"  type="text" name="task_manager"/>
                        </td>
                        <td class="table_second">
                           <input class="table_title modi_title"  type="text"  name="task_title" />
                        </td>
                     </tr>
                     <tr>
                        <td class ="table_first">상태</td>
                        <td class ="table_first">Create Event</td>
                     </tr>
                     <tr>
                        <td class = "table_second" style="border:none; font-size:10px">
                           <select class="table_state modi_state"  name="task_state">
                              <option value="menu">상태를 선택해 주세요</option>
                              <option value="wait">진행중</option>
                              <option value="delay">보류</option>
                              <option value="finish">완료</option>
                           </select>
                        </td>
                        
                        <td class = "table_second" >
                          <div class = "table_event" >
                              <div class="chkbox">
                                 <input type="checkbox" class="table_color"  name="color"  value="#dd4b39"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color1.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#f39c12" />
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color2.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color" name="color"  value="#01ff70"/>
                                 <img src="${pageContext.request.contextPath}/IMAGES/table_color3.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#3c8dbc"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color4.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#605ca8"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color5.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#777777"/>
                                 <img src="${pageContext.request.contextPath}/IMAGES/table_color6.png" />
                              </div>
                              
                               <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#00c0ef"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color7.png" />
                              </div>   
                              
                               <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#00a65a"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color8.png" />
                              </div>                      
                           </div>
                        </td>
                     </tr>
                     <tr>
                        <td class ="table_first">등급</td>
                        <td class ="table_first">내용</td>
                     </tr>
                     <tr>
                        <td class = "table_second" style="border:none; font-size:10px">
                           <select class="table_rank modi_rank" name="task_rank">
                              <option style="color:#cccccc;" name="menu">등급을 선택해 주세요</option>
                              <option value="0">0등급</option>
                              <option value="1">1등급</option>
                              <option value="2">2등급</option>
                              <option value="3">3등급</option>  
                           </select>
                        </td>
                        <td rowspan="3" class = "table_second" style="border:none; font-size:10px">
                            <textarea class="text_area modi_area" rows="5" name="tast_content"></textarea>
                         </td>
                     </tr>
                     <tr>
                        <td class ="table_first">일자</td>
                     </tr>
                     <tr>
                        <td class = "table_second" >
                           <input class="table_date modi_date" type="text" name="task_date" />
                           <input class="modi_id" type="text" name="task_id"  style="display:none" size="1">
                        </td>
                     </tr>
                     </table>               
         </div>
         <div id="modi_plus_task" class="modi_plus">수정하기</div>
           </form>
      </div>
   </div>
 </div>

   <!--  업무 자세히 보기  부분 입니다. -->
 <button class="btn btn-primary" id="Task_detail_btn" data-toggle="modal" data-target="#Task_detail" style="display:none"></button>
   <div class="modal fade" id="Task_detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg" style="width:45%; margin-top:5%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white">&times;</button>
                <span>업무 자세히보기</span>
          </div>
        </div>
          <div class="modal-body">
               <div class="new_cont_wrap">
                  <table class="new_block">
                     <tr>
                        <td class ="table_first" >담당자</td>
                        <td class ="table_first">제목</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <div class="table_manager detail_manager" ></div>
                        </td>
                        <td class= "table_second">
                           <div class="table_title detail_title" ></div>
                        </td>
                     </tr>
                     <tr>
                        <td class ="table_first">상태</td>
                        <td class ="table_first">Create Event</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <div class="table_state detail_state" ></div>
                        </td>
                        
                        <td class = "table_second" >
                          <div class = "table_event" >
                             <div class="chkbox">
                                 <input type="checkbox" class="table_color"  name="color"  value="#dd4b39"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color1.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#f39c12" />
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color2.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color" name="color"  value="#01ff70"/>
                                 <img src="${pageContext.request.contextPath}/IMAGES/table_color3.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#3c8dbc"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color4.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color" value="#605ca8"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color5.png" />
                              </div>
                              
                              <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#777777"/>
                                 <img src="${pageContext.request.contextPath}/IMAGES/table_color6.png" />
                              </div>
                              
                               <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#00c0ef"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color7.png" />
                              </div>   
                              
                               <div class="chkbox">
                                 <input type="checkbox"  class="table_color"  name="color"  value="#00a65a"/>
                                 <img  src="${pageContext.request.contextPath}/IMAGES/table_color8.png" />
                              </div>                      
                           </div>
                        </td>
                     </tr>
                     <tr>
                        <td class ="table_first">등급</td>
                        <td class ="table_first">내용</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <div class="table_rank detail_rank" ></div>
                        </td>
                        <td rowspan="3" class = "table_second">
                            <div class="text_area detail_area" ></div>
                         </td>
                     </tr>
                     <tr>
                        <td class ="table_first">일자</td>
                     </tr>
                     <tr>
                        <td class = "table_second">
                           <div class="table_date detail_date"></div>
                        </td>
                     </tr>
                     </table>                             
         </div>
         <div id="deta_task" class="detail_plus">닫기</div>
      </div>
   </div>
</div>
    <div class="option" id="option" style="display:none; position:absolute; width:100px;">
            <div id="modi_task" class="modify">수정하기</div>
            <div id="del_task" class="delete">삭제하기</div>
            <div id="det_task" class="detail">정보보기</div>
    </div>
    <table class="data_house"  style="display:none">
    <%
         for(int i=0; i<task_list.size(); i++)
         {            
   %>
        <tr class="<%=(String)task_list.get(i).get("task_title") %>">
           <td class="id" ><%=(Integer)task_list.get(i).get("task_id")%></td>
           <td class="name" ><%=(String)task_list.get(i).get("writer_name") %></td>
           <td class="title" ><%=(String)task_list.get(i).get("task_title")%></td>
           <td class="state" ><%=(String)task_list.get(i).get("task_state") %></td>
           <td class="date" ><%=((String)(task_list.get(i).get("task_date"))).substring(0,10)%></td>
           <td class="rank"><%=(Integer)task_list.get(i).get("level")%></td>
           <td class="content" ><%=task_list.get(i).get("task_content")%></td>
        </tr>
     <%
         }
     %>
     </table>
    <script>
    $('.chkbox').click(function ()
              {
                 
               if($(this).hasClass("on"))
                  {
                    $(this).children(".table_color").prop('checked',true);
                    for(var i =0; i < 8; i++)
                    {   m = i+1;
                       var checkname = '${pageContext.request.contextPath}/IMAGES/table_color'+m+'.png';
                       $(".chkbox").eq(i).children("img").attr('src',checkname);
                    }
                    
                      $(this).removeClass("on");              
                  }
               else
                  {
                     index = $(".table_event").children(this).index(this)+1;
                  
                     if(index >=9 && index <17 )
                        index = index-8;
                     if(index >=17 )
                        index = index -16;
                     
                     len = $(".chkbox").length/3;
                     $("input[name=color]:checkbox").attr("checked", false);
                     $(this).children("input").prop("checked", true);
                    if($(this).children("input").is(":checked"))
                       {
                          alert("체크됬슈!");
                       }
                     if(index < 9)
                    {
                       for(var i =1; i < 9; i++)
                        {   
                           var checkname = '${pageContext.request.contextPath}/IMAGES/table_color'+i+'.png';
                           $(".table_event").children(".chkbox").eq(i-1).children("img").attr('src',checkname);
                        }   
                    }
                    else if(index >=9 && index <17 )
                        {
                           for(var i =1; i < 9; i++)
                           {   
                              var checkname = '${pageContext.request.contextPath}/IMAGES/table_color'+i+'.png';
                              $(".table_event").children(".chkbox").eq((i+8)-1).children("img").attr('src',checkname);
                           }
                        }
                    else if(index >=9 && index <17 )
                    {
                        for(var i =1; i < 9; i++)
                        {   
                           var checkname = '${pageContext.request.contextPath}/IMAGES/table_color'+i+'.png';
                           $(".table_event").children(".chkbox").eq((i+16)-1).children("img").attr('src',checkname);
                        }
                    }
                     
                     var checkname1 = '${pageContext.request.contextPath}/IMAGES/table_color'+index+'k.png';           
                     //이미지 바꿔주고
                     $(this).children("img").attr('src',checkname1);
                      //클래스 제거
                     $('.chkbox div').removeClass("on");
                      //누른애만 에드
                      $(this).addClass("on");
                  }
              
              });
    </script>
</body>
</html>