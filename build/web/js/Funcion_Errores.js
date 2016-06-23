function FuncionErrores(id)
{
    $.ajax({
        url : 'ServletErrores', 
        data : "idError="+id,
        type : 'POST',
        dataType : "html",
        success : function(data) {
             alert(data);
           
        }
    });
}
