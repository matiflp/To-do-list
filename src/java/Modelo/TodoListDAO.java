package Modelo;

import java.sql.Connection;
import java.util.List;
import java.util.ArrayList;
import java.sql.ResultSet;
import Conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TodoListDAO 
{
    Connection conexion;
    
    public TodoListDAO() 
    {
        Conexion con = new Conexion();
        conexion = con.getConexion();   
    }
   
    public List<TodoList> listarItems()
    {
        PreparedStatement ps;
        ResultSet rs;
        List<TodoList> lista = new ArrayList<>();
        
        try
        {
            ps = conexion.prepareStatement("SELECT * FROM items");
            rs = ps.executeQuery();

            while(rs.next())
            {
                int id = rs.getInt("iditems");
                String item = rs.getString("item_to_do");
                boolean estado = rs.getBoolean("estado");
                TodoList items = new TodoList(id, item, estado);
                lista.add(items);          
            }
            return lista;
        }
        catch(SQLException e)
        {
            System.out.println(e.toString());
            return null;
        }                                        
    }
    
    public boolean insertarItem(TodoList item)
    {
        PreparedStatement ps;
        
        try
        { 
            ps = conexion.prepareStatement("INSERT INTO items VALUES(null, ?, 0)");
            ps.setString(1, item.getItemToDo());
            ps.execute();
            
            return true;
        }
        catch(SQLException e)
        {
            System.out.println(e.toString());
            return false;
        }         
    }
    
    public boolean eliminarItem(int id)
    {
        PreparedStatement ps;
        
        try
        { 
            ps = conexion.prepareStatement("DELETE FROM items WHERE iditems=?");
            ps.setInt(1, id);
            ps.execute();
            
            return true;
        }
        catch(SQLException e)
        {
            System.out.println(e.toString());
            return false;
        }   
    }
    
    public boolean actualizarItem(TodoList item)
    {
        PreparedStatement ps;
        
        try
        { 
            ps = conexion.prepareStatement("UPDATE items SET item_to_do=?, estado=? WHERE iditems=?");
            ps.setString(1, item.getItemToDo());
            ps.setBoolean(2, item.getEstado());
            ps.setInt(3, item.getId());
            ps.execute();
            
            return true;
        }
        catch(SQLException e)
        {
            System.out.println(e.toString());
            return false;
        }   
    }
}
