<%-- 
    Document   : index
    Created on : 2017/04/20, 16:46:08
    Author     : yunsunjin
--%>


<%@page import="java.sql.*,javax.sql.*,javax.naming.*"%>

<%@page import="java.text.*" %>
<%@page import="jamyto2.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:useBean class="jamyto2.BbsArticleList" id="articleList" scope="session"/>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<HTML>
<HEAD>
<TITLE>掲示板</TITLE>
</HEAD>
<%!
void getChildren(StringBuffer sbHtml,int intParentId,int intDepth) throws Exception{
	DateFormat df = new SimpleDateFormat("yyyy'年'MM'月'dd'日' E'曜日' HH'時'mm'分'");
	BbsArticleList articleList = new BbsArticleList();
	articleList.setParentId(intParentId);
	articleList.makeList();
	while(articleList.next()){
		BbsArticle article = articleList.getArticle();
		sbHtml.append("	<A NAME=\""+article.getId()+"\">")
	.append("<TABLE STYLE=\"margin-left:" + intDepth*30 + ";\">")
	.append("<TR><TD>No." + article.getId() + "</TD>")
	.append("<TD>" + TextConv.beforeHtml(article.getAuthor()))
	.append("/" + df.format(article.getDateTime()))
	.append("<A HREF=\"delete_1.jsp?id=" + article.getId()+"\">[削除]</A>")
	.append("<A HREF=\"edit_1.jsp?id=" + article.getId() + "\">[編集]</A>")
	.append("</TD></TR>")
	.append("<TR><TD>【件名】</TD>" )
	.append("<TD>" + TextConv.beforeHtml(article.getSubject()) + "</TD></TR>")
	.append("<TR valign=\"top\">")
	.append("<TD>【本文】</TD>")
	.append("<TD>" + TextConv.embedLink(TextConv.beforeHtml(article.getBody())))
	.append("</TD></TR>")
	.append("<TR><TD colspan=\"2\">")
	.append("<A HREF=\"write_1.jsp?parent_id=" + article.getId() + "\">")
	.append("コメントを書く</A></TD>")
	.append("</TABLE>")
	.append("<HR>");
        
		getChildren(sbHtml,article.getId(),intDepth+1);
	}
}
%>
<BODY>
    【<%=BbsSettings.strBbsName%>】<BR>
<%if(user.getId()>0){%>
	ニックネーム[<%=user.getNickName()%>]さん
	<A HREF="change_password_1.jsp">[パスワードを変更する]</A>
	<A HREF="change_profile_1.jsp">[ユーザ設定を変更する]</A>
	<A HREF="logout.jsp">[ログアウトする]</A>
<%}else{%>
	<A HREF="register_1.jsp">[ユーザー登録する]</A>
	<A HREF="login_1.jsp">[ログインする]</A>
<%}%>
<HR>
【掲示板】<BR>
<A HREF="write_1.jsp">投稿する</A><HR>
<BR>
<A HREF="search_1.jsp">検索する</A><HR>
<%
    
    String strDispTree = request.getParameter("disp_tree");
    if(strDispTree!=null){
        if(strDispTree.equals("true")){
            articleList.setDispTree(true);
            
        }else{
            articleList.setDispTree(false);
        }
    }
    if(articleList.isDispTree()){
        %><A HREF="index.jsp?disp_tree=false">[時系列表示]</A><%
    }else{
        %><A HREF="index.jsp?disp_tree=true">[ツリー表示]</A><%
    }
    
    
    
    
    
    
articleList.setLimit(5);
int intPage;
String strJumpTo=request.getParameter("jump_to");
String strPage=request.getParameter("page");
if(strJumpTo!=null){
	intPage=articleList.getPageFromId(Integer.parseInt(strJumpTo));
	articleList.setPage(intPage);
}else if(strPage!=null){
	intPage = Integer.parseInt(strPage);
	articleList.setPage(intPage);
}else{
	intPage = articleList.getLastPage();
	articleList.setPage(intPage);
}
if(intPage > 1){%>
	<A HREF="index.jsp?page=<%=intPage-1%>">前のページ</A> 
<%}%>
<%for(int i=1;i<=articleList.getLastPage();i++){
	if(i!=intPage){%>
		 <A HREF="index.jsp?page=<%=i%>"><%=i%></A>
	<%}else{	//現在のページ%>
		【<%=i%>】
	<%}
}%>
<%if(articleList.getLastPage()>intPage){%>
	<A HREF="index.jsp?page=<%=intPage+1%>">次のページ</A>
<%}%>
<HR>
<%
DateFormat df = new SimpleDateFormat("yyyy'年'MM'月'dd'日' E'曜日' HH'時'mm'分'");
StringBuffer sbHtml = new StringBuffer();
articleList.setParentId(0);
articleList.makeList();	
while(articleList.next()){	//親の表示
	BbsArticle article = articleList.getArticle();
	sbHtml.append("	<A NAME=\""+article.getId()+"\">")
	.append("<TABLE>")
	.append("<TR><TD>No." + article.getId() + "</TD>")
	.append("<TD>" + TextConv.beforeHtml(article.getAuthor()))
	.append("/" + df.format(article.getDateTime()))
	.append("<A HREF=\"delete_1.jsp?id=" + article.getId()+"\">[削除]</A>")
	.append("<A HREF=\"edit_1.jsp?id=" + article.getId() + "\">[編集]</A>")
	.append("</TD></TR>")
	.append("<TR><TD>【件名】</TD>" )
	.append("<TD>" + TextConv.beforeHtml(article.getSubject()) + "</TD></TR>")
	.append("<TR valign=\"top\">")
	.append("<TD>【本文】</TD>")
	.append("<TD>" + TextConv.embedLink(TextConv.beforeHtml(article.getBody())))
	.append("</TD></TR>")
	.append("<TR><TD colspan=\"2\">")
	.append("<A HREF=\"write_1.jsp?parent_id=" + article.getId() + "\">")
	.append("コメントを書く</A></TD>")
	.append("</TABLE>")
	.append("<HR>");
	this.getChildren(sbHtml,article.getId(),1);	//子の表示
}
%>
<%=sbHtml.toString()%>
</BODY>
</HTML>
