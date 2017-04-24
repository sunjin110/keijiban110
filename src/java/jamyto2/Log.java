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
import java.io.*;


    public class Log {
        public static void main(String[] args){
            write(args[0]);
        }
        public static void write(String strMessage){
            try{
                FileWriter fw = new FileWriter("c:/jamyto2/error.log",true);
                fw.write(strMessage);
                fw.write("¥n");
                fw.close();
                
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }
    

