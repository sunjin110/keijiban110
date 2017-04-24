<%-- 
    Document   : delete_2
    Created on : 2017/04/21, 0:18:03
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*, javax.sql.*, javax.naming.*, java.text.*, jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticle" id="article" scope="session"/>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>掲示板</title>
    </head>
    <body>
       　記事の消去<HR>
        <%
            int intId=Integer.parseInt(request.getParameter("id"));
            boolean blResult;
            if(user.getId()==0){
	String strPassword = request.getParameter("password");
	blResult = article.load(intId,strPassword);
            }else if(user.isAdmin()){
            article.loadAsAdmin(intId);
            blResult = true;
            
}else{
	blResult = article.loadWithUserId(intId,user.getId());
}
            
            
             if(blResult){
          
        
        %>
        
        <FORM ACTION="delete_3.jsp" METHOD="post">
            
            <TABLE>
            変更前
                <TR><TD>番号:</TD><TD><%=article.getId()%></TR>
                <TR><TD>日時:</TD><TD><%=article.getDateTime()%></TD></TR>
                <TR>
                    <TD>名前:</TD>
                    <TD><%=TextConv.beforeHtml(article.getAuthor())%></TD>
                </TR>
                <TR>
                    <TD>件名:</TD>
                    <TD><%=TextConv.beforeHtml(article.getSubject())%></TD>
                    
                </TR>
                <TR valign="top">
                    <TD>本文:</TD>
                    <TD><%=TextConv.embedLink(TextConv.beforeHtml(article.getBody()))
                    .replaceAll("¥n","<BR>")
                    .replaceAll("  "," &nbsp;")
                    .replaceAll("¥t","&nbsp;$nbsp;")%></TD>
                </TR>
            </TABLE>
                <HR>
               
               
            
                <%if(user.getId() == article.getAuthorId()){%>
                この記事を消去する場合は[消去]ボタンを押してください。<BR>
                <INPUT TYPE="submit" VALUE="消去">
                <%}else if (user.isAdmin()){%>
                
                この記事を管理者権限で消去する場合は[管理者権限で消去]ボタンを押してください<BR>
                <INPUT TYPE="submit" VALUE="管理者権限で消去">
                
                <%}%>
                
                
                
                
        </FORM>
        
                    <%}else if(user.getId()==0){%>
                パスワードが違います
        <%}else{%>
     異なるユーザーの記事は消去できません
        
        <%}%>
        <A HREF="javascript:history.back()">戻る</A>
    </body>
</html>
