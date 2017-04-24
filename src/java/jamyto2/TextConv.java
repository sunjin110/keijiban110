package jamyto2;
import java.util.regex.*;
public class TextConv{
	public static String beforeHtml(String str){
		return str.replaceAll("&","&amp;")
			.replaceAll("<","&lt;")
			.replaceAll(">","&gt;")
			.replaceAll("\"","&quot;")
			.replaceAll("'","&#39;")
			.replaceAll("  "," &nbsp;")
			.replaceAll("\t","&nbsp;&nbsp;&nbsp;&nbsp;")
			.replaceAll("\n","<BR>");
	}

	public static String beforeSql(String str){
		if(str==null){
			return "";
		}else{
			return str.replaceAll("\\\\","\\\\\\\\")
				.replaceAll("\"","\\\"")
				.replaceAll("'","\\\\'")
				.replaceAll("%","\\%")
				.replaceAll("_","\\_");
		}
	}

	public static String embedLink(String str){
		String strPattern="(http://|https://)[\\w\\[\\]\\-:/?#@!$&'()*+,;=.~%]+";
		Pattern pattern = Pattern.compile(strPattern,Pattern.CASE_INSENSITIVE);
		Matcher matcher=pattern.matcher(str);
		return matcher.replaceAll("<A HREF='$0'>$0</A>");
	}
}
