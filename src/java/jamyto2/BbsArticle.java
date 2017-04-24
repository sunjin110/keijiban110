package jamyto2;
import java.sql.*;
import java.util.*;
import java.util.Date;
import javax.sql.*;
import javax.naming.*;

public class BbsArticle{
	private int intId=0;
        private int intParentId=-1;
        private int intAuthorId=0;
	private Date dateTime;
	private String strAuthor="";
	private String strSubject="";
	private String strBody="";
        private String strPassword="";
        private String strEmail="";//最終的に変更の可能性
        

	public int getId(){return this.intId;}
        public int getParentId(){return this.intParentId;}
        public int getAuthorId(){return this.intAuthorId;}
	public Date getDateTime(){return this.dateTime;}
	public String getAuthor(){return this.strAuthor;}
	public String getSubject(){return this.strSubject;}
	public String getBody(){return this.strBody;}
        

	public void setId(int intIdArg){this.intId = intIdArg;}
        public void setParentId(int intParentIdArg){this.intParentId = intParentIdArg;}
        public void setAuthorId(int intAuthorIdArg){this.intAuthorId = intAuthorIdArg;}
	public void setDateTime(Date dateTimeArg){this.dateTime = dateTimeArg;}
	public void setAuthor(String strAuthorArg){this.strAuthor = strAuthorArg;}
	public void setSubject(String strSubjectArg){this.strSubject = strSubjectArg;}
	public void setBody(String strBodyArg){this.strBody = strBodyArg;}
        public void setEmail(String strEmailArg){this.strEmail = strEmailArg;}//変更の可能性
        //public void setPassword(String strPasswordArg){this.strPassword = strPasswordArg;}//書き込みました

	public void add(String strPassword) throws Exception{
		this.dateTime = new Date();
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql="INSERT INTO bbs"
			+ " (parent_id,author_id,date_time,author,subject,body,password)"
			+ " VALUES ("+ this.intParentId + ","
                        + this.intAuthorId + ","
                        +this.dateTime.getTime() +","
			+ "'" + TextConv.beforeSql(this.strAuthor) + "',"
			+ "'" + TextConv.beforeSql(this.strSubject) + "',"
			+ "'" + TextConv.beforeSql(this.strBody) + "','"
                        
                        + strPassword + "');";
               
                        
		try{
			stmt.executeUpdate(strSql);
                        strSql = "SELECT last_insert_id()";
			ResultSet rs = stmt.executeQuery(strSql);
			rs.next();
			this.intId = rs.getInt(1);
                        
                        
                        
                      
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "\n" + strSql);
		}
		conn.close();
	}

        
        public boolean load(int intIdArg, String strPassword) throws Exception{
		this.intId = intIdArg;
		String strSql="SELECT * FROM bbs WHERE id =" + intId
			+ " AND author_id = 0"
			+ " AND password = '" + strPassword + "'";
		boolean blResult=loadBase(strSql);
		return blResult;
	}

	public boolean loadWithUserId(int intIdArg, int intUserId) throws Exception{
		this.intId = intIdArg;
		String strSql="SELECT * FROM bbs WHERE id =" + intId
			+ " AND author_id = "+intUserId ;
		boolean blResult=loadBase(strSql);
		return blResult;
	}

	private boolean loadBase(String strSql) throws Exception{
		boolean blResult=false;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		try{
			ResultSet rs=stmt.executeQuery(strSql);
			if(rs.next()){
				this.intAuthorId = rs.getInt("author_id");
				this.intParentId = rs.getInt("parent_id");
				this.dateTime = new java.util.Date(rs.getLong("date_time"));
				this.strAuthor=rs.getString("author");
				this.strSubject=rs.getString("subject");
				this.strBody=rs.getString("body");
				blResult = true;
			}
			if(this.intAuthorId!=0){
				strSql="SELECT nick_name FROM user WHERE id = " + this.intAuthorId;
				rs = stmt.executeQuery(strSql);
				if(rs.next()){
					this.strAuthor=rs.getString("nick_name");
				}
			}
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "¥n" + strSql);
		}
		conn.close();
		return blResult;
                
                
                
                
                
	}
        
        public void loadAsAdmin(int intIdArg) throws Exception{
		this.intId = intIdArg;
		String strSql="SELECT * FROM bbs WHERE id =" + intId;
		loadBase(strSql);
	}


	public void delete() throws Exception{
            /*
            if(this.intId==0){
                throw new SessionTimeoutException();
            }
            */
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "DELETE FROM bbs WHERE id=" + this.intId;
		try{
			stmt.executeUpdate(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "\n" + strSql);
		}
		conn.close();
	}

	public void update() throws Exception{
            
            
         
            this.dateTime = new Date();
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql="UPDATE bbs SET"
			+" date_time=" + this.dateTime.getTime() + ","
			+" subject='" + TextConv.beforeSql(this.strSubject) + "',"
			+" body='" + TextConv.beforeSql(this.strBody) + "'"
			+" WHERE id=" + this.intId;
		try{
			stmt.executeUpdate(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "¥n" + strSql);
		}
		conn.close();
            
            
            
            
	}
       public String getParentSubject() throws Exception{
		String strResult="";
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql="SELECT * FROM bbs WHERE id =" + this.intParentId;
		try{
			ResultSet rs=stmt.executeQuery(strSql);
			if(rs.next()){
				strResult=rs.getString("subject");
			}else{
				throw new Exception("指定された記事がありません。");
			}
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "\n" + strSql);
		}
		conn.close();
		return strResult;
	}
        
    
        
        public void hide() throws SessionTimeoutException,Exception{
		if(this.intId==0){
			throw new SessionTimeoutException();
		}
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql = "UPDATE bbs SET hidden = 1 WHERE id=" + this.intId;
		try{
			stmt.executeUpdate(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "\n" + strSql);
		}
		conn.close();
	}
        
        
}
