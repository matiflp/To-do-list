package Modelo;

public class TodoList 
{
    private int id;
    private String itemToDo;
    private boolean estado;
    
    // Constructor
    public TodoList(int id, String itemToDo, boolean estado) 
    {
        this.id = id;
        this.itemToDo = itemToDo;
        this.estado = estado;
    }
    
    // Getters
    public int getId() 
    {
        return id;
    }
    public String getItemToDo() 
    {
        return itemToDo;
    }
    public boolean getEstado()
    {
        return estado;
    }
    
    // Setters
    public void setId(int id) 
    {
        this.id = id;
    }
    public void setItemToDo(String itemToDo) 
    {
        this.itemToDo = itemToDo;
    }
    public void setEstado(boolean estado)
    {
        this.estado = estado;
    }
}
