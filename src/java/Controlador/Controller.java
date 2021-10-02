package Controlador;

import Modelo.TodoList;
import Modelo.TodoListDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet 
{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        TodoListDAO todoListDAO = new TodoListDAO();        
        String accion;
        //RequestDispatcher dispatcher = null;
        
        accion = request.getParameter("accion"); 
        if(accion == null || accion.isEmpty()) 
        {
            List<TodoList> listar =  todoListDAO.listarItems();
            String json = new Gson().toJson(listar);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }else if("insertar".equals(accion))
        {
            String item = request.getParameter("itemTodoList");
            TodoList addItem= new TodoList(0, item, false);
            todoListDAO.insertarItem(addItem);
            
            List<TodoList> listar =  todoListDAO.listarItems();
            String json = new Gson().toJson(listar);
            
            // Analizar si es necesario realizar esto ya que los datos necesarios ya los tengo del lado de jsp.
            // En principio si debido a que necesito guardar el nuevo id, aunque podria obtenerse con alternativas mas simples.
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);             
        }else if("actualizar".equals(accion))
        {
            String item = request.getParameter("itemTodoList");
            int id = Integer.parseInt(request.getParameter("id"));
            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
            System.out.println(estado);
            System.out.println(item);
            TodoList addItem= new TodoList(id, item, estado);
            todoListDAO.actualizarItem(addItem);
            
            List<TodoList> listar =  todoListDAO.listarItems();
            String json = new Gson().toJson(listar);
            
            // Analizar si es necesario realizar esto ya que los datos necesarios ya los tengo del lado de jsp.
            // Solamente habria que escribir actualizar el valor en la base de datos.
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);  
            //request.setAttribute("lista", listar); 
        }else if("eliminar".equals(accion))
        {
            int id = Integer.parseInt(request.getParameter("id"));
            todoListDAO.eliminarItem(id);
            //dispatcher = request.getRequestDispatcher("index.jsp");
            //List<TodoList> listar =  todoListDAO.listarItems();
            //request.setAttribute("lista", listar);          
        }
        
        //dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        doGet(request, response);        
        //JOptionPane.showMessageDialog(null, "El crs esta vacio");
    }

    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }

}
