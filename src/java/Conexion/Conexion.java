package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Conexion 
{
    public Connection getConexion()
    {
        String url = "jdbc:mysql://localhost:3306/todo_list";
        String driver = "com.mysql.cj.jdbc.Driver";
        String usuario = "root";
        String clave = "c23e1234";
        Connection conexion;
        
        try 
        {
            Class.forName(driver);
        }catch (ClassNotFoundException ex) 
        {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
        try
        {
            conexion = DriverManager.getConnection(url,usuario,clave);
            return conexion;
        }catch(SQLException e)
        {
            System.out.println(e.toString());
            return null;
        }
    }
}