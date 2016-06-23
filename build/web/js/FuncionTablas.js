function habilitaModUsr(id){   
    cancelarUsr();
    if($("#habilitaUsr").val() == 0 )
    {         
        $("#filaUsr"+id).css("background-color","#58FAF4").removeClass("alt");
        var elem = $("#usr_tipo"+id).text();
        var elem1= $("#usr_tipoNeg"+id).text();
        var elem2 = $("#usr_supervisor"+id).text();
        $("#txt_usr_rut").val($("#usr_rutUsr"+id).text());
        $("#txt_usr_nom").val($("#usr_nomUsr"+id).text());
        $("#slt_usr_tipo").val(elem);
        $("#slt_usr_tipoNegocio").val(elem1);
        $("#slt_usr_supervisor").val(elem2);
        $("#txt_usr_pass").val($("#usr_pass"+id).text());
        $('#txt_usr_rut').attr("disabled",true);
        $('#btn_usr_ing').hide();
        $('#btn_usr_mod').show();
//        $('#btn_usr_can').show();
        $('#btn_usr_eli').show();
        $("#habilitaUsr").val("1");

    }
}
function cancelarUsr(){
    if($("#habilitaUsr").val() == 1)
    {
        var td = $('#tblUser').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaUsr"+i).addClass( "alt" );
            }else {                    
                $("#filaUsr"+i).css("background-color","white");
            }
        }
        $('#btn_usr_ing').show();
        $('#btn_usr_mod').hide();
//        $('#btn_usr_can').hide();
        $('#btn_usr_eli').hide();
        $("#txt_usr_rut").val("");
        $("#txt_usr_nom").val("");
        $("#slt_usr_tipo").val("");
        $("#txt_usr_pass").val("");
        $("#slt_usr_supervisor").val("");
        $("#slt_usr_tipoNegocio").val("");
        $('#txt_usr_rut').attr("disabled",false);
        $("#habilitaUsr").val("0");
    }
}
function habilitaModTabla(id){  
    cancelarTabla();
    if($("#habilitaTabla").val() == 0 )
    {
        $("#filaTabla"+id).css("background-color","#58FAF4").removeClass("alt");
        var elem = $("#tabla_TablaMae"+id).text();
        var elem2 = $("#tabla_Relacion1"+id).text();
        var elem3 = $("#tabla_Relacion2"+id).text();
        $("#hid_tabla_id").val($("#tabla_Id"+id).val());
        $("#txt_tabla_descripcion").val($("#tabla_descripcion"+id).text());
        $("#slt_tabla_mae").val(elem);
        $("#slt_tabla_rel1").val(elem2);                
        $("#slt_tabla_rel2").val(elem3);
        $("#txt_tabla_mae").attr("disabled",true);
        $("#txt_tabla_rel1").attr("disabled",true);
        $("#txt_tabla_rel2").attr("disabled",true);
        $("#slt_tabla_mae").attr("disabled",true);
        $('#slt_tabla_rel1').prop("disabled","disabled");
        $('#slt_tabla_rel2').prop("disabled","disabled");
        $('#btn_tabla_ing').hide();
        $('#btn_tabla_mod').show();
//        $('#btn_tabla_can').show();
        $('#btn_tabla_eli').show();
        $("#habilitaTabla").val("1");        
	}
}
function cancelarTabla(){
    if($("#habilitaTabla").val() == 1)
    {	
        var td = $('#tblMaeTabla').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaTabla"+i).addClass( "alt" );
            }else {                    
                $("#filaTabla"+i).css("background-color","white");
            }
        }
        $('#btn_tabla_ing').show();
        $('#btn_tabla_mod').hide();
//        $('#btn_tabla_can').hide();
        $('#btn_tabla_eli').hide();
        $("#txt_tabla_mae").attr("disabled",false);
        $("#txt_tabla_rel1").attr("disabled",false);
        $("#txt_tabla_rel2").attr("disabled",false);
        $('#slt_tabla_mae').prop("disabled","");
        $('#slt_tabla_rel1').prop("disabled","");
        $('#slt_tabla_rel2').prop("disabled","");
        $("#txt_tabla_descripcion").val("");
        $("#txt_tabla_mae").val("");
        $("#txt_tabla_rel2").val("");  
        $("#txt_tabla_rel1").val("");
        $("#slt_tabla_mae").val("");
        $("#slt_tabla_rel1").val("");
        $("#slt_tabla_rel2").val("");			
        $("#habilitaTabla").val("0");
    }
}
		
function habilitaModNot(id){
    cancelarNot();
    if($("#habilitaNot").val() == 0 )
    {
        $("#filaNot"+id).css("background-color","#58FAF4").removeClass("alt");
        var elem = $("#not_est"+id).text();
        $("#txt_not_email").val($("#not_email"+id).text());
        $("#txt_not_usr").val($("#not_Usr"+id).text());
        $("#slt_not_est").val(elem);
        $('#btn_not_ing').hide();
        $('#btn_not_mod').show();
//        $('#btn_not_can').show();
        $('#btn_not_eli').show();
        $('#slt_not_est').attr("disabled", true);
        $('#txt_not_usr').attr("disabled",true);
        $("#habilitaNot").val("1");

    }
}
function cancelarNot(){
    if($("#habilitaNot").val() == 1)
    {
        var td = $('#tblNot').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaNot"+i).addClass( "alt" );
            }else {                    
                $("#filaNot"+i).css("background-color","white");
            }
        }
        
        $('#btn_not_ing').show();
        $('#btn_not_mod').hide();
//        $('#btn_not_can').hide();
        $('#btn_not_eli').hide();
        $('#slt_not_est').attr("disabled", false);
        $('#txt_not_usr').attr("disabled",false);
        $("#txt_not_email").val("");
        $("#txt_not_usr").val("");
        $("#slt_not_est").val("");			
        $("#habilitaNot").val("0");
    }
}
function habilitaModWork(id){     
    cancelarWork();
    if($("#habilitaWork").val() == 0 )
    {
        $("#filaWork"+id).css("background-color","#58FAF4").removeClass("alt");
        var elem1 = $("#work_estAct"+id).text();
        var elem2 = $("#work_estSig"+id).text();
        $("#hid_work_id").val($("#work_id"+id).val());        
        $("#txt_work_rut").val($("#work_usr"+id).text());
        $("#slt_work_estAct").val(elem1);
        $("#slt_work_estSig").val(elem2);
        $("#txt_work_rut").attr("disabled",true);
        $('#btn_work_ing').hide();
        $('#btn_work_mod').show();
//        $('#btn_work_can').show();
        $('#btn_work_eli').show();
        $("#habilitaWork").val("1");           
    }
}
function cancelarWork(){
    if($("#habilitaWork").val() == 1)
    {
        var td = $('#tblWork').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaWork"+i).addClass( "alt" );
            }else {                    
                $("#filaWork"+i).css("background-color","white");
            }
        }
        $('#btn_work_ing').show();
        $('#btn_work_mod').hide();
//        $('#btn_work_can').hide();
        $('#btn_work_eli').hide();
        $("#txt_work_rut").attr("disabled",false);
        $("#txt_work_rut").val("");
        $("#slt_work_estAct").val("");
        $("#slt_work_estSig").val("");			
        $("#habilitaWork").val("0");
    }
}
function habilitaModEsc(id){
    cancelarEsc();
    if($("#habilitaEsc").val() == 0 )
    {
        $("#filaEsc"+id).css("background-color","#58FAF4").removeClass("alt");
        var elem = $("#esc_vigencia"+id).text();
        $("#txt_esc_fecha").val($("#esc_fecha"+id).text());
        $("#txt_esc_autor").val($("#esc_autor"+id).text());
        if(elem == "no")
        {
            $("#ckbox_esc_vig").prop("checked","");
        }
        $('#txt_esc_titulo').attr("disabled",true);
        $("#txt_esc_titulo").val($("#esc_titulo"+id).text());
        $("#txa_esc_cont").val($("#esc_noticia"+id).text());
        $('#btn_esc_ing').hide();
        $('#btn_esc_mod').show();
//        $('#btn_esc_can').show();
        $('#btn_esc_eli').show();
        $("#habilitaEsc").val("1");

    }
}
function cancelarEsc(){
    if($("#habilitaEsc").val() == 1)
    {		
        var td = $('#tblEsc').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaEsc"+i).addClass( "alt" );
            }else {                    
                $("#filaEsc"+i).css("background-color","white");
            }
        }
        $('#btn_esc_ing').show();
        $('#btn_esc_mod').hide();
//        $('#btn_esc_can').hide();
        $('#btn_esc_eli').hide();
        $("#txt_esc_fecha").val("");
        $("#txt_esc_autor").val("");
        $("#txt_esc_titulo").val("");
        $('#txt_esc_titulo').attr("disabled",false);
        $("#txa_esc_cont").val("");
        $("#ckbox_esc_vig").prop("checked","checked");
        $("#habilitaEsc").val("0");
    }
}
function habilitaModErr(id){  
    cancelarErr();
    if($("#habilitaErr").val() == 0 )
    {
        $("#filaErr"+id).css("background-color","#58FAF4").removeClass("alt");
        $("#txt_err_tipo").val($("#err_tipo"+id).text());
        $("#txa_err_descripcion").val($("#err_descripcion"+id).text());              
        $("#txt_err_id").val($("#err_id"+id).text());
        $('#btn_err_ing').hide();
        $('#btn_err_mod').show();
//        $('#btn_err_can').show();
        $('#txt_err_id').attr("disabled",true);
        $('#btn_err_eli').show();
        $("#habilitaErr").val("1");

    }
}
function cancelarErr(){
    if($("#habilitaErr").val() == 1)
    {	
        var td = $('#tblErr').children('tbody').children('tr').length;           
        for(var i = 0; i<=td;i++){                
            if(i % 2 === 0){
                $("#filaErr"+i).addClass( "alt" );
            }else {                    
                $("#filaErr"+i).css("background-color","white");
            }
        }
        $('#btn_err_ing').show();
        $('#btn_err_mod').hide();
//        $('#btn_err_can').hide();
        $('#btn_err_eli').hide();
        $('#txt_err_id').attr("disabled",false);;
        $("#txt_err_tipo").val("");
        $("#txa_err_descripcion").val("");
        $("#txt_err_id").val("");
        $("#habilitaErr").val("0");
    }
}
   