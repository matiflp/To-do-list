<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>   
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>To-Do List</title>
        <link rel="stylesheet" href="TO-DO//assets//css//style.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">       
        <script src="https://code.jquery.com/jquery-3.6.0.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-start">
                <div class="col-4">
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-4">
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row justify-content-end">
                <div class="col-4">                    
                    <div class="header">
                        <h1>To-Do list</h1>
                        <h3>Add Item</h3>
                        <div class="input-group mb-3">    
                            <input type="text" id="newItem" name="newItem" class="form-control" placeholder="Add a item..." aria-label="Recipient's username" aria-describedby="basic-addon2">
                            <div class="input-group-append">                                   
                                <a href="#" id="save" class="btn btn-outline-secondary guardar">Add</a>
                            </div>                        
                        </div>   
                    </div> 
                    <ul class="miLista">  
                    </ul>     
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row justify-content-around">
                <div class="col-4">
                </div>
                <div class="col-4">
                </div>
            </div>
            <div class="row justify-content-between">
                <div class="col-4">
                </div>
                <div class="col-4">
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function() {
                
                // Carga los elementos que trae de la base de datos creando elementos dinamicos.
                $.post("Controller", {"accion": ""}, function(responseJson) {  
                    var ul = $(".miLista");
                    $.each(responseJson, function(index, item) { 
                        
                        var itemLista = $("<li id='li"+item.id+"'></li>");                      
                        var label = $("<label for='itemTodoList"+item.id+"' class='itemTodoList"+item.id+"'></label>");
                        
                        $(label).append("<input id='itemTodoList"+item.id+"' name='itemTodoList"+item.id+"' type='checkbox'>");
                        $(label).append(" "+item.itemToDo); 
                        $(itemLista).append(label); 
                        
                        $(itemLista).append("<img id='"+item.id+"' class='action' src='TO-DO/img/Menu2.png' height='10%' width='10%' alt='' />");
                        var span = $("<span id='menu"+item.id+"' class='menu'></span>");
                        $(span).append("<a href='#&id="+item.id+"' class='edit'>edit</a>");
                        $(span).append("<br>");
                        $(span).append("<a href='#&id="+item.id+"' class='remove'>Remove</a>");
                        $(itemLista).append(span);
                        
                        $(itemLista).appendTo(ul);
                        if(item.estado === true)
                        {
                            $("#itemTodoList"+item.id).prop("checked", true);
                            $(".itemTodoList"+item.id).css("text-decoration", "line-through");
                        }
                    });
                });
                
                var guardar = $(".guardar");
                
                // Funcion manejadora de los eventos "guardar", "edit" y "remove".
                function clickHandler() {
                    
                    var elemento = $(this).attr('class');  // Obtengo la clase del elemento para verifiar luego quien disparo el evento.
                    var id = $(this).attr('href').replace('#&id=', ''); // Obtengo el indice que me indica que elemento es en la base de datos.
                    var accion; // Accion a realizar en el Controller.
                    
                    if(elemento === "btn btn-outline-secondary guardar")
                    {                      
                        var newItem = $("#newItem").val();
                        accion = "insertar";
                                    
                        $.post("Controller", {"accion":accion, "itemTodoList":newItem}, function(responseJson) {
                            $("#newItem").val("");
                            var ul = $(".miLista");                        
                            var itemLista = $("<li id='li"+responseJson[(Object.keys(responseJson).length)-1].id+"'></li>");      // Create HTML <li> element, set its text content with currently iterated item and append it to the <ul>.                   
                            var label = $("<label for='itemTodoList"+responseJson[(Object.keys(responseJson).length)-1].id+"' class='itemTodoList"+responseJson[(Object.keys(responseJson).length)-1].id+"'></label>");
                        
                            $(label).append("<input id='itemTodoList"+responseJson[(Object.keys(responseJson).length)-1].id+"' name='itemTodoList"+responseJson[(Object.keys(responseJson).length)-1].id+"' type='checkbox'>");
                            $(label).append(" "+responseJson[(Object.keys(responseJson).length)-1].itemToDo);   
                            $(itemLista).append(label); 
                        
                            $(itemLista).append("<img id='"+responseJson[(Object.keys(responseJson).length)-1].id+"' class='action' src='TO-DO/img/Menu2.png' height='10%' width='10%' alt='' />");
                            var span = $("<span id='menu"+responseJson[(Object.keys(responseJson).length)-1].id+"' class='menu'></span>");
                            $(span).append("<a href='#&id="+responseJson[(Object.keys(responseJson).length)-1].id+"' class='edit'>edit</a>");
                            $(span).append("<br>");
                            $(span).append("<a href='#&id="+responseJson[(Object.keys(responseJson).length)-1].id+"' class='remove'>Remove</a>");
                            $(itemLista).append(span);
                        
                            $(itemLista).appendTo(ul);
                         });
                    }else if(elemento === "edit")
                    {
                        var itemCambiar = $(".itemTodoList"+id).text();
                        $(".itemTodoList"+id).contents().filter(function(){
                            return this.nodeType === 3;
                        }).remove();
                        $("input#itemTodoList"+id).get(0).type = 'text';
                        $("input#itemTodoList"+id).val(itemCambiar);
                        
                        $("input#itemTodoList"+id).bind("enterKey",function(e){
                            
                            var newItem = $("#itemTodoList"+id).val();
                            accion = "actualizar";
                            
                            $.post("Controller", {"accion":accion, "itemTodoList":newItem, "id":id}, function() {
                                // Guardo el nuevo item en la base de datos y actualizo el valor 
                                // de la lista con el item que obtengo del DOM
                                // sin traerlo de la base de datos para no realizar un acceso extra a la base de datos.
                                $("input#itemTodoList"+id).val("");
                                $("input#itemTodoList"+id).get(0).type = 'checkbox';
                                $(".itemTodoList"+id).append(" "+newItem);       
                            });
                        });
                        $("input#itemTodoList"+id).keyup(function(e){
                            if(e.keyCode === 13) // Verifique si se presiono el enter.
                                $(this).trigger("enterKey");
                        }); 
                    }else if(elemento === "remove")
                    {
                        // Elimina el elemento en el documento html y en la base de datos.
                        // No actualizo la lista desde la base de datos con el elemento eliminado ya que 
                        // seria un acceso extra innecesario a la base de datos.
                        accion = "eliminar";
                        $.post("Controller", {"accion":accion, "id":id}, function() {
                            $("#li"+id).remove();
                        });
                    }
                };
                
                // Para que, una vez que se hizo click sobre el menu, desplegar las posibles opciones
                // y si sacamos el mouse de ese elemento el menu de opciones desaparezca.
                $(".miLista").on("click",".action", function(){
                    var id = $(this).attr('id');
                    $("#menu"+id).slideToggle(500);
                    $(".miLista").on("mouseleave","#menu"+id, function(){
                        $("#menu"+id).slideUp(500);     
                    });
                });
                
                // Cuando cambia el estado del checkbox se agrega una linea que atraviesa al item
                // indicando que ya se realizo. Luego, se modifican el estado en la base de datos.
                $(".miLista").on("change", ":checkbox", function() {
                    var id = $(this).attr("id").replace("itemTodoList","");
                    var newItem = $(".itemTodoList"+id).text();
  
                    if (this.checked) {
                        $(".itemTodoList"+id).css("text-decoration", "line-through"); 
                        $.post("Controller", {"accion":"actualizar", "id":id, "itemTodoList":newItem, "estado":true});
                    } else {
                        $(".itemTodoList"+id).css("text-decoration", "none");  
                        $.post("Controller", {"accion":"actualizar", "id":id, "itemTodoList":newItem, "estado":false});
                    }
                });
                
                // Se asigna el handler a los eventos creados dinamicamente.
                $(".miLista").on("click",".edit",clickHandler);
                $(".miLista").on("click",".remove",clickHandler);
                
                // Se asigna el handler al evento guardar.
                guardar.on("click",clickHandler);
            });

        </script>
    </body>
</html>