package jamyto2;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

public class BbsUser{
	protected int intId=0;
	protected String strLoginName="";
	protected String strNickName="";
	protected String strEmail="";
        protected String strGoAfterLogin="";
        protected boolean blAdmin = false;

	public int getId(){return this.intId;}
        
        
	public String getLoginName(){return this.strLoginName;}
	public String getNickName(){return this.strNickName;}
	public String getEmail(){return this.strEmail;}
	public void setNickName(String strNickNameArg){
		this.strNickName = strNickNameArg;
	}
	public void setEmail(String strEmailArg){
		this.strEmail = strEmailArg;
	}
        
        
        public String getGoAfterLogin(){return this.strGoAfterLogin;}
	public void setGoAfterLogin(String strGoAfterLoginArg){
		this.strGoAfterLogin = strGoAfterLoginArg;
	}
        
        public boolean isAdmin(){return this.blAdmin;}

        
        
	public boolean login(String strLoginName, String strPassword) throws Exception{
		boolean blResult;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "SELECT * FROM user"
			+ " WHERE login_name = '" + TextConv.beforeSql(strLoginName) + "'"
			+ " AND password = '" + TextConv.beforeSql(strPassword) + "'";//変更可能性あり
		ResultSet rs = stmt.executeQuery(strSql);
		if(rs.next()){
			this.intId = rs.getInt("id");
			this.strNickName = rs.getString("nick_name");
			this.strEmail = rs.getString("email");
                        
                        if(rs.getInt("privilege")==1){
                            this.blAdmin=true;
                        }
                        
			blResult = true;
		}else{
			blResult = false;
		}
		return blResult;
	}

	public boolean changePassword(String strOldPassword, String strNewPassword)
			throws Exception{
		if(this.intId==0){
			throw new Exception("セッションが切断されました。");
		}
		boolean blResult;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "UPDATE user SET password = '"
				+ TextConv.beforeSql(strNewPassword) +"'"
				+ " WHERE id = " + this.intId 
				+ " AND password = '"
				+ TextConv.beforeSql(strOldPassword) +"'";
		int intResult = stmt.executeUpdate(strSql);
                
		if(intResult==1){
			blResult = true;
		}else{
			blResult = false;
		}
		return blResult;
	}

	public boolean updateProfile() throws Exception{
		boolean blResult=true;
		if(this.intId==0){
			throw new Exception("セッションが切断されました。");
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "UPDATE user SET email 	= '"
				+ TextConv.beforeSql(this.strEmail) +"',"
				+ " nick_name = '" + TextConv.beforeSql(this.strNickName) + "'"
				+ " WHERE id = " + this.intId ;
		try{
			stmt.executeUpdate(strSql);
		}catch(SQLException e){
			if(e.getErrorCode()==1062){
				blResult=false;
			}else{
				throw new Exception(e.getMessage()+"¥n"+strSql);
			}
		}
		return blResult;
	}
        
        
        
        
}
