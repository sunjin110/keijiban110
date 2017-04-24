<%-- 
    Document   : delete_1
    Created on : 2017/04/21, 0:05:39
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*, javax.sql.*, javax.naming.*, java.text.*, jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<%if(user.getId()!=0){%>
	<jsp:forward page="delete_2.jsp"/>
<%}%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>掲示板</title>
    </head>
    <body>
        記事の消去<HR>
        <%
            String strId=request.getParameter("id");
            %>
            
            <FORM ACTION="delete_2.jsp" METHOD="post">
                <INPUT TYPE="hidden" NAME="id" VALUE="<%=strId%>">
                パスワードを入力してください<BR>
                <INPUT TYPE="password" NAME="password">
                <INPUT TYPE="submit" VALUE="送信">
  
            </FORM>
                <A HREF="javascript:history.back()">戻る</A>
                
    </body>
</html>
