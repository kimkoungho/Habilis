<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="kr.pe.hoyanet.mail.SMTPAuthenticator" %>
<%@ page import="java.net.URLEncoder" %>
<%

request.setCharacterEncoding("UTF-8");

String name1 = request.getParameter("name1");//이름입력란
String phone1 = request.getParameter("phone1");//연락처 처음입력란
String phone2 = request.getParameter("phone2");//연락처 두번째입력란
String phone3 = request.getParameter("phone3");//연락처 세번째
String sender = request.getParameter("sender");//E-mail앞입력란
String sender2 = request.getParameter("sender2");//E-mail뒤입력란
String select = request.getParameter("select");//질분구분 선택란
String sub_subject = request.getParameter("sub_subject");//제목입력란
String receiver = request.getParameter("receiver");//받는사람메일
String content = request.getParameter("content");//내용 입력란
String sub_content = request.getParameter("sub_content");//내용 입력란
Properties p = new Properties();

// SMTP 서버의 계정 설정
// Naver와 연결할 경우 네이버 아이디 지정
// Google과 연결할 경우 본인의 Gmail 주소
p.put("mail.smtp.user", "akkdu");

// SMTP 서버 정보 설정
// 네이버일 경우 smtp.naver.com
// Google일 경우 smtp.gmail.com
p.put("mail.smtp.host", "smtp.naver.com");
    
// 아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
if("시스템문의".equals(select)){
   receiver = "30032dongsu@naver.com";
}
else if("사용문의".equals(select)){
   receiver = "akkdu@naver.com";
}
else if("결제문의".equals(select)){
   receiver = "30032dongsu@naver.com";
}
else if("기타".equals(select)){
   receiver = "akkdu@naver.com";
}
try {
    Authenticator auth = new SMTPAuthenticator();
    Session ses = Session.getInstance(p, auth);

    // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
    ses.setDebug(true);
        
    // 메일의 내용을 담기 위한 객체
    MimeMessage msg = new MimeMessage(ses);

    // 제목 설정 
    msg.setSubject("하빌리스 상담문의 입니다.");
        
    // 보내는 사람의 메일주소
    Address fromAddr = new InternetAddress("akkdu@naver.com");
    msg.setFrom(fromAddr);
        
    // 받는 사람의 메일주소
  
   Address toAddr = new InternetAddress(receiver);
   msg.addRecipient(Message.RecipientType.TO, toAddr);
        
    // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
    content=
    "이름 : "+name1+"<br>"+
    "연락처 :"+phone1+"-"+phone2+"-"+phone3+"<br>"+
    "E-mail : "+sender+"@"+sender2+"<br>"+
    "질문구분 : "+select+"<br>"+
    "제목 : "+sub_subject+"<br>"+
    "내용 : "+sub_content;
    msg.setContent(content, "text/html;charset=UTF-8");
        
    // 발송하기
    Transport.send(msg);
        
} catch (Exception mex) {
    mex.printStackTrace();
    String script = "<script type='text/javascript'>\n";
    script += "alert('메일발송에 실패했습니다.');\n";
    script += "history.back();\n";
    script += "</script>";
    out.print(script);
    return;
}
    
String script = "<script type='text/javascript'>\n";
script += "alert('메일발송에 성공했습니다.');\n";
script += "</script>";
script += "<meta http-equiv='refresh' content='0; url=QNA.jsp' />";
out.print(script);
%>