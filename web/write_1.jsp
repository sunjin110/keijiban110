<%-- 
    Document   : write_1
    Created on : 2017/04/20, 18:36:52
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticle" id="article" scope="session"/>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>


<%if(user.getId()==0){

String strGoAfterLogin = "write_1.jsp";
	String strParentId = request.getParameter("parent_id");
	if(strParentId != null){
		strGoAfterLogin += "?parent_id=" + strParentId;
	}
	user.setGoAfterLogin(strGoAfterLogin);


%>
<jsp:forward page="info.jsp"/>
<%}%>

<!DOCTYPE html>

<%
    
   String strAuthor="";
   //String strEmail="";//最終的に使わん
   
   if(user.getId()==0){
   
    Cookie[] aryCoo = request.getCookies();
    for(int i=0;i<aryCoo.length;i++){
        if(aryCoo[i].getName().equals("auther")){
            strAuthor=java.net.URLDecoder.decode(aryCoo[i].getValue(), "UTF-8");
        }
    
    }
   
   }
    
    %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=BbsSettings.strBbsName%></title>
        
        <SCRIPT type="text/javascript">
            function func_check(){
            
            if(document.form1.subject.value==""){
                alert("件名を入力してください");
                return false;
            }
            
            
        <%if(user.getId()==0){%>
            if(document.form1.author.value==""){
                alert("名前を入力してください");
                return false;
            }
            
            
           if(document.form1.password.value==""){
               alert("パスワードを入力してください");
               return false;
           }
           if(document.form1.password.value!=document.form1.password2.value){
               alert("確認用のパスワードが違います");
               return false;
           }
           
          <%}%>
            
        }
        
        
        
        </script>
        
    </head>
    <body>
       <%=BbsSettings.strBbsName%><BR>
        
        <%
        
       String strParentId = request.getParameter("parent_id");
       
       //------------------------------------
       
if(strParentId != null){
	int intParentId = Integer.parseInt(strParentId);
	article.setParentId(intParentId);
	String strParentSubject = article.getParentSubject();
	if(strParentSubject.startsWith("RE:")){
		article.setSubject(strParentSubject);
	}else{
		article.setSubject("RE:" + strParentSubject);
	}
}else{
	article.setParentId(0);
	article.setSubject("");
}

//-----------------------------------


       
        %>
        
        
        
        <FORM NAME="form1" ACTION="write_2.jsp" METHOD="post"
            ONSUBMIT="return func_check()">
            
            
            <%if(user.getId()==0){%>
            
            名前:<INPUT TYPE="text" NAME="author" SIZE="80" value="<%=strAuthor%>"><BR>
            <%}%>
            
            
            件名:<INPUT TYPE="text" NAME="subject" SIZE="80"><BR>
            本文:<TEXTAREA COLS="60" ROWS="5" NAME="body"></TEXTAREA><BR>




<BR>

<%if(user.getId()==0){%>
パスワード (記事を編集/消去するときに使います)<BR>
<INPUT TYPE="password" NAME="password" SIZE="20"><BR>
確認用パスワード(上のパスワードと同じものを入力してください)<BR>
<INPUT TYPE="password" NAME="password2" SIZE="20"><BR>

<%}%>

<INPUT TYPE="submit" VALUE="送信">
            
        </FORM>
    </body>
</html>
