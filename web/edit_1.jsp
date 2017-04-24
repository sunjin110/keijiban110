<%-- 
    Document   : edit_1
    Created on : 2017/04/21, 9:27:14
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<%if(user.getId()!=0){%>
	<jsp:forward page="edit_2.jsp"/>
<%}%>
<HTML>
<HEAD>
<TITLE>掲示板</TITLE>
</HEAD>
<BODY>
記事の編集<HR>
<%
String strId = request.getParameter("id");
%>
<FORM ACTION="edit_2.jsp" METHOD="post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%=strId%>">
パスワードを入力して［送信］ボタンを押してください。<BR>
<INPUT TYPE="hidden" NAME="id" VALUE="<%=request.getParameter("id")%>">
<INPUT TYPE="password" NAME="password">
<INPUT TYPE="submit" VALUE="送信">
</FORM>

<A HREF="javascript:history.back()">戻る</A>
</BODY>
</HTML>
