<%-- 
    Document   : register_2
    Created on : 2017/04/23, 1:41:11
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*, java.util.Date"%>

<%@ page import="jamyto2.*"%>


<HTML>
<HEAD><TITLE>ユーザ登録</TITLE></HEAD>
<BODY>
<%
    /*
    
BbsUserEx new_user = new BbsUserEx();
request.setCharacterEncoding("Windows-31J");
new_user.setLoginName(request.getParameter("login_name"));
new_user.setNickName(request.getParameter("nick_name"));
new_user.setEmail(request.getParameter("email"));
boolean blResult = new_user.addUser();

*/
    
    boolean blResult =true;

    Context ctx = new InitialContext();
    DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
    Connection conn = ds.getConnection();
    Statement stmt = conn.createStatement();
    Date dateNow = new Date();
    request.setCharacterEncoding("UTF-8");
    String strLoginName=request.getParameter("login_name");
    String strNickName=request.getParameter("nick_name"); 
    String strEmail=request.getParameter("email"); 
    String strPassword=request.getParameter("password");
    
   String strSql = "INSERT INTO user (login_name,password,nick_name,email) "
			+ "VALUES ('" + TextConv.beforeSql(strLoginName) + "'," 
			+ "'" + TextConv.beforeSql(strPassword) + "'," 
			+ "'" + TextConv.beforeSql(strNickName) +"',"
			+ "'" +  TextConv.beforeSql(strEmail) + "')";
    
   
   try{
       stmt.executeUpdate(strSql);
   }catch (SQLException e){
       blResult =false;
   }
    
    
    
    
    conn.close();
%>

<%if(blResult){%>
ユーザ登録を完了しました。<BR>
<BR>

       
<%}else{%>
	ログイン名またはメールアドレスが既に使われています。
<%}%>
<BR><A HREF="index.jsp">掲示板に戻る</A>
</BODY>
</HTML>
