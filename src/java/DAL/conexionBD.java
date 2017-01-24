package DAL;

import java.sql.*;
import static java.lang.System.out;
import javax.naming.Context;
import javax.naming.InitialContext;

public class conexionBD {
  
    public static Connection Conectar(String database)throws Exception
    {
        Connection con = null;
        try
        {           
           Context env = (Context)new InitialContext().lookup("java:comp/env");
           String user = "root";//(String)env.lookup("user");//root
           String pass = "123456";//(String)env.lookup("pass");//admin
           String driverClassName = "com.mysql.jdbc.Driver";
           String driverUrl = "jdbc:mysql://127.0.0.1:3306/sisventasmetal";
           Class.forName(driverClassName);
           con = DriverManager.getConnection(driverUrl, user, pass);
        }
        catch(Exception e)
        {
            System.out.print(e.getMessage());
        }
        return con;
    }
    public static String agregaCaracter(String texto)
    {
        String cadena= "";
        int nroCaracter= texto.length();
        int diferencia = 20 - nroCaracter;
        int i=0;        
        cadena=texto;
        while( i <= diferencia)
        {
            cadena += "&nbsp;";
            i++;
        }        
        return cadena;
    }
}
