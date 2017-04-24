package jamyto2;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author yunsunjin
 */

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
public class SimpleEmail {
    private String strFrom;
    private String strTo;
    private String strSubject;
    private String strBody;
    private String strSmtpServer="localhost";
    
    public void setFrom(String strFromArg){this.strFrom = strFromArg;}
    public void setTo(String strToArg){this.strTo = strToArg;}
    public void setSubject(String strSubjectArg){this.strSubject = strSubjectArg;}
    public void setBody(String strBodyArg){this.strBody = strBodyArg;}
    
    void send(){
        Properties props = new Properties();
        props.put("mail.smtp.host",this.strSmtpServer);
        try{
            Session mailSession = Session.getInstance(props);
            MimeMessage message = new MimeMessage(mailSession);
            InternetAddress from = new InternetAddress(this.strFrom);
            message.setFrom(from);
            InternetAddress to = new InternetAddress(this.strTo);
            message.addRecipient(Message.RecipientType.TO, to);
            message.setSubject(this.beforeEmail(this.strSubject),"iso-2022-jp");
            message.setText( this.beforeEmail(this.strBody),"iso-2022-jp");
            Transport.send(message);
            
        }catch(Exception e){
            Log.write("Error-------------¥n");
            Log.write(new Date().toString());
            Log.write(e.getMessage()+"¥n");
        }
    }
    public static String beforeEmail(String str) {
        StringBuffer sbReturn = new StringBuffer();
        for (int i = 0; i < str.length(); i++){
            char c = str.charAt(i);
            switch (c) {
                default: sbReturn.append(c);
            }
        }
        return sbReturn.toString();
    }
}
