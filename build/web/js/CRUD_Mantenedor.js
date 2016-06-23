function Error(id)
{
    if($("#txt_err_id").val() == "")
    {
        FuncionErrores(101);
        $("#txt_err_id").focus();
        return false;
    }
    if($("#txt_err_tipo").val() == "")
    {
        FuncionErrores(102);
        $("#txt_err_tipo").focus();
        return false;
    }
    if($("#txa_err_descripcion").val() == "")
    {
        FuncionErrores(103);
        $("#txa_err_descripcion").focus();
        return false;
    } 
    if(id == 'ingreso')
    {
        var td = $('#tblErr').children('tbody').children('tr').length; 
        for(var i = 0; i<td;i++)
        {                
            if($("#err_id"+i).text() === $("#txt_err_id").val())
            {
                FuncionErrores(127);
                $("#txt_err_id").focus();
                return false;
            }
        }
    }
    FuncionError(id);
}
function Escritorio(id)
{
    if($("#txt_esc_autor").val() == "")
    {
        FuncionErrores(104);
        $("#txt_esc_autor").focus();
        return false;
    }
    if($("#txt_esc_fecha").val() == "")
    {
        FuncionErrores(105);
        $("#txt_esc_fecha").focus();
        return false;
    }
    if($("#txt_esc_titulo").val() == "")
    {
        FuncionErrores(106);
        $("#txt_esc_titulo").focus();
        return false;
    } 
    if($("#txa_esc_cont").val() == "")
    {
        FuncionErrores(107);
        $("#txa_esc_cont").focus();
        return false;
    }
    if(id == 'ingreso')
    {
        var td = $('#tblEsc').children('tbody').children('tr').length; 
        for(var i = 0; i<td;i++)
        {                
            if($("#esc_titulo"+i).text() === $("#txt_esc_titulo").val())
            {
                FuncionErrores(129);
                $("#txt_err_id").focus();
                return false;
            }
        }
    }
    FuncionEscritorio(id);
}
function MaeTablas(id)
{        
    if($("#slt_tabla_mae").val() == "" && $("#txt_tabla_mae").val() == "")
    {
        FuncionErrores(108);
        $("#slt_tabla_mae").focus();
        return false;
    }
    if($("#slt_tabla_mae").val() != "" && $("#txt_tabla_mae").val() != "")
    {
        FuncionErrores(109);
        $("#slt_tabla_mae").focus();
        return false;
    }
    if($("#slt_tabla_rel1").val() != "" && $("#txt_tabla_rel1").val() != "")
    {
        FuncionErrores(110);
        $("#slt_tabla_rel1").focus();
        return false;
    }
    if($("#slt_tabla_rel2").val() != "" && $("#txt_tabla_rel2").val() != "")
    {
        FuncionErrores(111);
        $("#slt_tabla_rel2").focus();
        return false;
    }
    if($("#txt_tabla_descripcion").val() == "")
    {
        FuncionErrores(112);
        $("#txt_tabla_descripcion").focus();
        return false;
    }
    if(id == 'ingreso')
    {
        var juntadatos = "";
        var juntatabla = "";
                
        if ($("#slt_tabla_mae").val() != "")
        {
           juntadatos = $("#slt_tabla_mae").val();
        }
        if ($("#txt_tabla_mae").val() != "")
        {
           juntadatos = $("#txt_tabla_mae").val();
        }
        if ($("#slt_tabla_rel1").val() != "")
        {
           juntadatos = juntadatos.concat($("#slt_tabla_rel1").val());
        }
        if ($("#txt_tabla_rel1").val() != "")
        {
           juntadatos = juntadatos.concat($("#txt_tabla_rel1").val());
        }
        if ($("#slt_tabla_rel2").val() != "")
        {
           juntadatos = juntadatos.concat($("#slt_tabla_rel2").val());
        }
        if ($("#txt_tabla_rel2").val() != "")
        {
           juntadatos = juntadatos.concat($("#txt_tabla_rel2").val());
        }
        juntadatos = juntadatos.concat($("#txt_tabla_descripcion").val());
                
        var td = $('#tblMaeTabla').children('tbody').children('tr').length;           
        for(var i = 0; i<td;i++)
        {                
            juntatabla = "";
            juntatabla = $('#tabla_TablaMae'+i).text();
            juntatabla = juntatabla.concat($('#tabla_Relacion1'+i).text());
            juntatabla = juntatabla.concat($('#tabla_Relacion2'+i).text());
            juntatabla = juntatabla.concat($('#tabla_descripcion'+i).text());
            if (juntadatos === juntatabla)
            {
                FuncionErrores(128);
                $("#slt_tabla_mae").focus();
                return false;
            }
        }
    }
    FuncionMaeTabla(id);
}
function Usuarios(id)
{
    var valido = new RegExp("[^0-9kK-]"); 
    var rut = $("#txt_usr_rut").val();  
    var posicion = rut.indexOf('-'); 
    var tmp = VerificaRut(rut);
    if(rut == "")
    {
        FuncionErrores(113);
        $("#txt_usr_rut").focus();
        return false;
    }
    if (valido.test(rut)) 
    {
        FuncionErrores(114);
        $("#txt_usr_rut").focus();
        return false;
    }
    if(posicion == -1) 
    {
        FuncionErrores(115);
        $("#txt_usr_rut").focus();
        return false;
    }
    if(tmp == false) 
    {
        FuncionErrores(116);
        $("#txt_usr_rut").focus();
        return false;
    }
    if($("#txt_usr_nom").val() == "") 
    {
        FuncionErrores(117);
        $("#txt_usr_nom").focus();
        return false;
    }
    if($("#slt_usr_tipo").val() == "") 
    {
        FuncionErrores(118);
        $("#slt_usr_tipo").focus();
        return false;
    }
    if($("#txt_usr_pass").val() == "") 
    {
        FuncionErrores(119);
        $("#txt_usr_pass").focus();
        return false;
    }            
    /*if(id == 'ingreso')
    {
        var td = $('#tblUser').children('tbody').children('tr').length;
        for(var i = 0; i<td;i++)
        {
            if($("#usr_rutUsr"+i).text() === $("#txt_usr_rut").val())
            {
                FuncionErrores(126);
                $("#txt_usr_pass").focus();
                return false;
            }
        }
    }*/
    FuncionUsuarios(id);            
}
function Notificaciones(id)
{        
    var exemplist =/^[a-zA-Z][\w\.-]*[a-zA-Z0-9]*@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]*\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
    if($("#slt_not_est").val() == "")
    {
        FuncionErrores(120);
        $("#slt_not_est").focus();
        return false;
    }
    if($("#txt_not_usr").val() == "")
    {
        FuncionErrores(121);
        $("#txt_not_usr").focus();
        return false;
    }
    if($("#txt_not_email").val() == "")
    {
        FuncionErrores(122);
        $("#txt_not_email").focus();
        return false;
    }
    if(!exemplist.test($("#txt_not_email").val()))
    {
        FuncionErrores(123);
        $("#txt_not_email").focus();
        return false;
    }
    if(id == 'ingreso')
    {
        var juntadatos = "";
        var juntatabla = "";
                
        juntadatos = $("#slt_not_est").val();
        juntadatos = juntadatos.concat($("#txt_not_usr").val());
        juntadatos = juntadatos.concat($("#txt_not_email").val());

        var td = $('#tblNot').children('tbody').children('tr').length;           
        for(var i = 0; i<td;i++)
        {                
            juntatabla = "";
            juntatabla = $('#not_est'+i).text();
            juntatabla = juntatabla.concat($('#not_Usr'+i).text());
            juntatabla = juntatabla.concat($('#not_email'+i).text());
            if (juntadatos === juntatabla)
            {
                FuncionErrores(130);
                $("#slt_not_est").focus();
                return false;
            }
        }
    }
    FuncionNotificaciones(id);
}
function WorkFlow(id)
{
    var valido = new RegExp("[^0-9kK-]");
    var rut = $("#txt_work_rut").val();  
    var posicion = rut.indexOf('-'); ;
    var tmp = VerificaRut(rut);    
    var tmp = VerificaRut(rut);
    var x_id = $("#hid_workflow_id").val();
    var tmp = VerificaRut(rut);
    var x_id = $("#hid_work_id").val();
    
    if($("#slt_work_estAct").val() == "")
    {
        FuncionErrores(124);
        $("#slt_work_estAct").focus();
        return false;
    }
    if($("#slt_work_estSig").val() == "")
    {
        FuncionErrores(125);
        $("#slt_work_estSig").focus();
        return false;
    }
    if(rut == "")
    {
        FuncionErrores(113);
        $("#txt_work_rut").focus();
        return false;
    }
    if (valido.test(rut)) {
        FuncionErrores(114);
        $("#txt_work_rut").focus();
        return false;
    }
    if(posicion == -1)
    {
        FuncionErrores(115);
        $("#txt_work_rut").focus();
        return false;
    }
    if(tmp == false)
    {
        FuncionErrores(116);
        $("#txt_work_rut").focus();
        return false;
    }              
    if(id == 'ingreso')
    {
        var juntadatos = "";
        var juntatabla = "";
                
        juntadatos = $("#slt_work_estAct").val();
        juntadatos = juntadatos.concat($("#slt_work_estSig").val());
        juntadatos = juntadatos.concat($("#txt_work_rut").val());

        var td = $('#tblWork').children('tbody').children('tr').length;           
        for(var i = 0; i<td;i++)
        {                
            juntatabla = "";
            juntatabla = $('#work_estAct'+i).text();
            juntatabla = juntatabla.concat($('#work_estSig'+i).text());
            juntatabla = juntatabla.concat($('#work_usr'+i).text());
            if (juntadatos === juntatabla)
            {
                FuncionErrores(131);
                $("#slt_work_estAct").focus();
                return false;
            }
        }
    }
    
    FuncionWorkFlow(id);
};
function FuncionMaeTabla(id)
{        
    var tablamae = "";
    var rel1 = "";
    var rel2 = "";
    var desc = "";
    var x_id = "";
    
    if(id === 'ingreso')
    {        
        if($("#slt_tabla_mae").val() === "")
        {
            tablamae= $("#txt_tabla_mae").val();
        }else
        {
            tablamae = $("#slt_tabla_mae").val();
        }
        if($("#slt_tabla_rel1").val() === "")
        {
            rel1= $("#txt_tabla_rel1").val();
        }else
        {
            rel1 = $("#slt_tabla_rel1").val();
        }
        if($("#slt_tabla_rel2").val() === "")
        {
            rel2= $("#txt_tabla_rel2").val();
        }else
        {
            rel2 = $("#slt_tabla_rel2").val();
        }
        desc = $("#txt_tabla_descripcion").val();
        x_id = $("#hid_tabla_id").val();
        
    }else
    {        
        tablamae = $("#slt_tabla_mae").val();
        rel1 = $("#slt_tabla_rel1").val();
        rel2 = $("#slt_tabla_rel2").val();
        desc = $("#txt_tabla_descripcion").val();
        x_id = $("#hid_tabla_id").val();
    }    
    $.ajax({
        url : 'ServletSPTablas', 
        data : "opcion_MaeTablas="+id+"&hid_tabla_id="+x_id+"&slt_tabla_mae="+tablamae+"&slt_tabla_rel1="+rel1+"&slt_tabla_rel2="+rel2+"&txt_tabla_descripcion="+desc,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            location.href="svm_Mantencion_Configuracion.jsp";
        }
    });
}
function FuncionNotificaciones(id)
{         
    var estado = "";
    var user = "";
    var email = "";
   
    estado = $("#slt_not_est").val();
    user = $("#txt_not_usr").val();
    email = $("#txt_not_email").val();
    $.ajax({
        url : 'ServletSPNotificacion', 
        data : "opcion_Notificaciones="+id+"&slt_not_est="+estado+"&txt_not_usr="+user+"&txt_not_email="+email,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            location.href="svm_Mantencion_Configuracion.jsp";
        }
    });
}
function FuncionWorkFlow(id)
{       
    var estActual = "";
    var estSig = "";
    var rut = "";
    var x_id = "";
    estActual = $("#slt_work_estAct").val();
    estSig = $("#slt_work_estSig").val();
    rut = $("#txt_work_rut").val();	
    x_id = $("#hid_workflow_id").val(); 
    x_id = $("#hid_workflow_id").val();    
    x_id = $("#hid_work_id").val();    
    if(estActual === estSig)
        {
            alert("El Estado Actual No puede ser igual al siguiente");
            $("#slt_work_estSig").focus();
            return false;
        }
    $.ajax({
        url : 'ServletSPWorkFlow', 
        data : "opcion_WorkFlow="+id+"&hid_work_id="+x_id+"&slt_work_estAct="+estActual+"&slt_work_estSig="+estSig+"&txt_work_rut="+rut,
        type : 'POST',
        dataType : "html",
        
        success : function(data) {
            location.href="svm_Mantencion_Configuracion.jsp";
        }
    });
}
function FuncionUsuarios(id)
{
    var nom = "";
    var rut = "";
    var tipo = "";
    var pass = "";
    var tipNegocio = "";
    var supervisor = "";
    rut = $("#txt_usr_rut").val();
    nom = $("#txt_usr_nom").val();
    tipo = $("#slt_usr_tipo").val();
    pass = $("#txt_usr_pass").val();
    tipNegocio = $("#slt_usr_tipoNegocio").val();
    supervisor = $("#slt_usr_supervisor").val();
    $.ajax({
        url : 'ServletSPUsuario', 
        data : "opcion_Usuario="+id+"&txt_usr_rut="+rut+"&txt_usr_nom="+nom+"&slt_usr_tipo="+tipo+
                "&txt_usr_pass="+pass+"&slt_usr_tipoNegocio="+tipNegocio+"&slt_usr_supervisor="+supervisor,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            
            if(data == "ok"){
                location.href="svm_Mantencion_Configuracion.jsp";
            }else{
                alert(data);
            }
        }
    });
}
function FuncionEscritorio(id)
{    
    var autor = "";
    var fecha = "";
    var titulo = "";
    var contenido = "";
    var check = "";
    
    autor = $("#txt_esc_autor").val();
    fecha = $("#txt_esc_fecha").val();
    titulo = $("#txt_esc_titulo").val();
    contenido = $("#txa_esc_cont").val();
    if($("#ckbox_esc_vig").is(':checked'))
    {
        check= "si";
    }else 
    {
        check = "no";
    }
    $.ajax({
        url : 'ServletSPEscritorio', 
        data : "opcion_Escritorio="+id+"&txt_esc_autor="+autor+"&txt_esc_fecha="+fecha+"&txt_esc_titulo="+titulo+
                "&txa_esc_cont="+contenido+"&ckbox_esc_vig="+check,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            location.href="svm_Mantencion_Configuracion.jsp";
        }
    });
}
function FuncionError(id)
{    
    var x_id = "";
    var tipo = "";
    var descripcion = "";   
    x_id = $("#txt_err_id").val();
    tipo = $("#txt_err_tipo").val();
    descripcion = $("#txa_err_descripcion").val();
    $.ajax({
        url : 'ServletSPErrores', 
        data : "opcion_Errores="+id+"&txt_err_id="+x_id+"&txt_err_tipo="+tipo+"&txa_err_descripcion="+descripcion,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            location.href="svm_Mantencion_Configuracion.jsp";                        
        }
    });
}
