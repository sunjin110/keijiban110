package jamyto2;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

public class BbsUserEx extends BbsUser{

	public void setLoginName(String strLoginNameArg){
		super.strLoginName = strLoginNameArg;
	}
	public boolean addUser() throws Exception{
		boolean blResult=true;
		if(super.strLoginName.equals("") | 
			super.strNickName.equals("") | 
			super.strEmail.equals("")){
			throw new Exception("ログイン名、ニックネームまたはメールアドレスが未設定です");
		}
		String strPassword = this.getRandomPassword(8);
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "INSERT INTO user (login_name,password,nick_name,email) "
			+ "VALUES ('" + TextConv.beforeSql(super.strLoginName) + "'," 
			+ "password('" + TextConv.beforeSql(strPassword) + "')," 
			+ "'" + TextConv.beforeSql(super.strNickName) +"',"
			+ "'" +  TextConv.beforeSql(super.strEmail) + "')";
		try{
			stmt.executeUpdate(strSql);
		}catch (SQLException e){
			if(e.getErrorCode()==1062){
				blResult=false;
			}else{
				throw new Exception(e.getMessage()+"¥n"+strSql);
			}
		}
		conn.close();
		if(blResult){
			SimpleEmail mail = new SimpleEmail();
			mail.setFrom(BbsSettings.strMailSenderAddress);
			mail.setTo(super.strEmail);
			mail.setSubject(BbsSettings.strBbsName + "ユーザー登録完了");
			StringBuffer sbBody = new StringBuffer();
			sbBody.append("あなたのlogin名は " + super.strLoginName + "¥n")
				.append("初期パスワードは " + strPassword + "です。¥n")
				.append(BbsSettings.strBaseUrl 
					+ "bbs/T/login_1.jsp からログインしてください。¥n")
				.append("ログイン後、パスワードを変更することができます。¥n");
			mail.setBody(sbBody.toString());
			mail.send();
		}
		return blResult;
	}

	public boolean renewPassword(String strEmailArg) throws Exception{
		boolean blResult;
		String strPassword = this.getRandomPassword(8);
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "UPDATE user SET password=password('" + strPassword + "')"
			+ " WHERE email = '" + strEmailArg + "'";
		int intResult = stmt.executeUpdate(strSql);
		if(intResult==1){
			SimpleEmail mail = new SimpleEmail();
			mail.setFrom(BbsSettings.strMailSenderAddress);
			mail.setTo(strEmailArg);
			mail.setSubject(BbsSettings.strBbsName + "よりお知らせ");
			mail.setBody("仮パスワードを " + strPassword + "に設定しました¥n");
			mail.send();
			blResult = true;
		}else{
			blResult = false;
		}
		conn.close();
		return blResult;
	}

	String getRandomPassword(int intLength){
		char[] aryC = {'2','3','4','5','6','7','8','9'
						,'a','b','c','d','e','f','g','h','i','j','k','m','n','o'
						,'p','q','r','s','t','u','v','w','x','y','z'
						,'A','B','C','D','E','F','G','H','J','K','L','M','N','P'
						,'Q','R','S','T','U','V','W','X','Y','Z'
						,'#','$','%','&','!'
					};
		java.util.Random random = new java.util.Random();
		StringBuffer sbPassword = new StringBuffer();
		for(int i=0;i<intLength;i++){
			sbPassword.append(aryC[random.nextInt(aryC.length)]);
		}
		return sbPassword.toString();
	}
}
