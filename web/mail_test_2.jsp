<%-- 
    Document   : mail_test_2
    Created on : 2017/04/22, 22:55:43
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="javax.mail.*,javax.mail.internet.*,java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
String strFrom = request.getParameter("from");
String strTo = request.getParameter("to");
String strSubject = request.getParameter("subject");
String strBody = request.getParameter("body");

Properties props = new Properties();
String strSmtpServer="localhost";
props.put("mail.smtp.host",strSmtpServer);
Session mailSession = Session.getInstance(props);
MimeMessage message = new MimeMessage(mailSession);
InternetAddress from = new InternetAddress(strFrom);
message.setFrom(from);
InternetAddress to = new InternetAddress(strTo);
message.addRecipient(Message.RecipientType.TO, to);
message.setSubject(strSubject,"iso-2022-jp");
message.setText(strBody,"iso-2022-jp");
Transport.send(message);
%>
<HTML>
<HEAD><TITLE>メールテスト</TITLE></HEAD>
<BODY>
メールを送信しました。
</BODY>
</HTML>
