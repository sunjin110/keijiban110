package jamyto2;

import java.sql.*;
import java.util.Date;
import javax.sql.*;
import javax.naming.*;

public class BbsArticleList{
	private Connection connList;
	private Statement stmtList;
	private ResultSet rsList;
	private BbsArticle article = new BbsArticle();

	private int intLimit=0;
	private int intPage=1;
	private int intParentId=0;
	private	boolean blDispTree=true;

	public void setPage(int intPageArg){this.intPage = intPageArg;}
	public void setLimit(int intLimitArg){this.intLimit = intLimitArg;}
	public void setParentId(int intParentIdArg){this.intParentId = intParentIdArg;}
	public void setDispTree(boolean blDispTreeArg){this.blDispTree = blDispTreeArg;}
	public boolean isDispTree(){return this.blDispTree;}

	public void makeList() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		this.connList = ds.getConnection();
		this.stmtList = this.connList.createStatement();
		String strSql="SELECT bbs.*,user.nick_name FROM bbs"
			+" LEFT JOIN user ON bbs.author_id = user.id";
		if(this.blDispTree){
			strSql += " WHERE parent_id=" + this.intParentId;
		}
		strSql +=" ORDER BY id";
                
		if(this.intLimit!=0){
			strSql = strSql + " LIMIT " + (this.intPage-1)*this.intLimit
				+ "," + this.intLimit;
		}
		try{
			this.rsList=stmtList.executeQuery(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "¥n" + strSql);
		}
	}
	public void search(String strSearch) throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		this.connList = ds.getConnection();
		this.stmtList = this.connList.createStatement();
		String strSql="SELECT bbs.*,user.nick_name FROM bbs"
			+" LEFT JOIN user ON bbs.author_id = user.id"
			+" WHERE subject LIKE '%" + strSearch + "%'"
			+ " OR body LIKE '%" + strSearch + "%'";
		try{
			this.rsList=stmtList.executeQuery(strSql);
		}catch (SQLException se){
			throw new Exception(se.getMessage() + "¥n" + strSql);
		}
		
	}

	public boolean next() throws Exception{
		boolean blResult=false;
		if(this.rsList.next()){
			this.article.setId(this.rsList.getInt("id"));
			this.article.setDateTime(new Date(this.rsList.getLong("date_time")));
                        
                        if(this.rsList.getInt("hidden")==0){
                        
			int intAuthorId = this.rsList.getInt("author_id");
			if(intAuthorId!=0){
				this.article.setAuthor(this.rsList.getString("nick_name"));
			}else{
				this.article.setAuthor(this.rsList.getString("author"));
			}
			this.article.setSubject(this.rsList.getString("subject"));
			this.article.setBody(this.rsList.getString("body"));
                        
                        }else{
                            this.article.setAuthor("");
                            this.article.setSubject("[管理者によって消去されました。]");
                            this.article.setBody("");
                        }
                        
			blResult=true;
		}else{
			this.connList.close();
		}
		return blResult;
	}

	public BbsArticle getArticle(){
		return this.article;
	}

	public int getLastPage() throws Exception{
		int intResult = 0;
		if(this.intLimit!=0){
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement();
			String strSql="SELECT COUNT(*) FROM bbs";
			if(this.blDispTree){
				strSql += " WHERE parent_id=" + this.intParentId;
			}
			ResultSet rs = stmt.executeQuery(strSql);
			rs.next();
			int intRowCount = rs.getInt(1);
			intResult = (intRowCount-1) / this.intLimit + 1;
			conn.close();
		}
		return intResult;
	}

	public int getPageFromId(int intIdArg) throws Exception{
		int intPageOfId=0;
		if(this.intLimit!=0){	// intPageを計算する
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
			Connection conn = ds.getConnection();
			Statement stmt = conn.createStatement();
			String strSql;
			if(!this.blDispTree){	//時系列表示の場合
				strSql="SELECT count(*) from bbs WHERE id <= " + intIdArg;
			}else{					//ツリー表示の場合
				int intRoot = this.getRoot(intIdArg);
				strSql="SELECT count(*) from bbs WHERE parent_id = 0 AND id <= " 
					+ intRoot;
			}
			ResultSet rs = stmt.executeQuery(strSql);
			rs.next();
			int intRowCount = rs.getInt(1);
			intPageOfId = (intRowCount-1) / this.intLimit + 1;
			conn.close();
		}
		return intPageOfId;
	}

	int getRoot(int intIdArg) throws Exception{
		int intRootId=intIdArg;
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/jamyto2");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		String strSql="SELECT parent_id FROM bbs WHERE id=" + intIdArg;
		ResultSet rs = stmt.executeQuery(strSql);
		int intParentIdLocal;
		if(rs.next()){
			intParentIdLocal = rs.getInt("parent_id");
		}else{	//指定された番号が削除されている場合
			intParentIdLocal = 0;
		}
		if(intParentIdLocal!=0){
			intRootId = getRoot(intParentIdLocal);
		}
		conn.close();
		return intRootId;//親が0なら自分のIDを返す
	}


}
