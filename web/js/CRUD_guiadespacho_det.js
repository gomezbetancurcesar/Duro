/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function ingresaDetalleGuia(){
    var numeroGuia = $("#txt_guiadespacho_numero").val();
    var numeroOT = $("#txt_guiadespacho_numeroOT").val();
    var itemGuia = $("#txt_guiadespacho_itemnumero").val();    
    var cantidad = $("#txt_guiadespacho_cantidad").val();
    var detalleGuia = $("#txt_guiadespacho_detalle").val();
    var valorUnitario = $("#txt_guiadespacho_valor").val();
    var totalItem = $("#txt_guiadespacho_totalitem").val();    
    var itemOT = $("#txt_guiadespacho_itemnumero").val();
    
    if ($("#txt_guiadespacho_numeroOT").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_numeroOT").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_itemnumero").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_itemnumero").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_cantidad").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_cantidad").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_detalle").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_detalle").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_valor").val() == "") {
        FuncionErrores(29);
        $("#txt_cotizacion_cantidad").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_totalitem").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_totalitem").focus();
        return false;
    }     
    
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPGuiaDespachoDet', 
        data: "opcion=insert"+"&txt_guia_numero="+numeroGuia+"&txt_OT_numero="+numeroOT+"&txt_guia_item="+itemGuia+
                "&txt_guia_cantidad="+cantidad+"&txt_guia_detalle="+detalleGuia+"&txt_guia_nroitem="+itemOT+
                "&txt_guia_valor="+valorUnitario+"&txt_guia_totalitem="+totalItem+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            cargaDetalleGuia();
            $("#txt_guiadespacho_numeroOT").val("");
            $("#txt_guiadespacho_itemnumero").val("");
            $("#txt_guiadespacho_cantidad").val("");
            $("#txt_guiadespacho_detalle").val("");
            $("#txt_guiadespacho_valor").val("");
            $("#txt_guiadespacho_totalitem").val("");
            $("#txt_guiadespacho_itemnumero").val("");
        }
    });
}

function guardaDetalleGuia(){
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPGuiaDespachoDet', 
        data: "opcion=guarda_detalle"+"&txt_guia_numero=0"+"&txt_OT_numero=0"+"&txt_guia_item=0"+
                "&txt_guia_cantidad=0"+"&txt_guia_detalle=0"+"&txt_guia_nroitem=0"+
                "&txt_guia_valor=0"+"&txt_guia_totalitem=0"+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
           alert("Registro Guardado");
        }
    });
}


function cargaDetalleGuia(){
    var numeroGuia=$("#txt_guiadespacho_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPGuiaDespachoDet', 
        data: "opcion=select_detalle"+"&txt_guia_numero=0"+"&txt_OT_numero=0"+"&txt_guia_item=0"+
                "&txt_guia_cantidad=0"+"&txt_guia_detalle="+"&txt_guia_nroitem=0"+
                "&txt_guia_valor=0"+"&txt_guia_totalitem=0"+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaDetalleGuia").find("tbody").html(data);  
        }
    });
}

function ModificaDetalleGuia(id)
{
    CancelaDetalleGuia();
    if($("#habilitaDetCom").val() == 0)
    {
        $("#filaTablaDetalle"+id).css("background-color","#58FAF4").removeClass("alt");
        $("#txt_guiadespacho_numeroOT").val($("#guiadespachoDet_OT"+id).text());
        $("#txt_guiadespacho_itemnumero").val($("#guiadespachoDet_Item"+id).text());        
        $("#txt_guiadespacho_cantidad").val($("#guiaDet_cantidad"+id).text());
        $("#txt_guiadespacho_detalle").val($("#guiaDet_detalleguia"+id).text());
        $("#txt_guiadespacho_valor").val($("#guiaDet_valorunit"+id).text());
        $("#txt_guiadespacho_totalitem").val($("#guiaDet_totalitem"+id).text());        
        $("#txt_correlativo").val($("#guiadespachoDet_correlativo"+id).text());

        var accion=getUrlParameter('accion');
                       
        if(accion=="consulta"){
            $("#DetalleIngresoGuia").hide(); 
            return;
        }
        $("#DetalleModificaGuia").show();
        $("#DetalleEliminaGuia").show();        
        $("#CancelaModificaGuia").show();
        $("#DetalleIngresoGuia").hide();
        $("#habilitaDetCom").val("1");
        $("#hidtemp").val(id);
    }
}

function CancelaDetalleGuia()
{
    var td = $('#tblDetalleGuia').children('tbody').children('tr').length;           
    for(var i = 0; i<=td;i++){                
        if(i % 2 === 0){
            $("#filaTablaDetalle"+i).addClass("alt");
        }else {                    
            $("#filaTablaDetalle"+i).css("background-color","white");
        }
    }
    $("#DetalleIngresoGuia").show();
    $("#DetalleModificaGuia").hide();
    $("#DetalleEliminaGuia").hide();    
    $("#CancelaModificaGuia").hide();
    $("#habilitaDetCom").val("0");
    $("#txt_guiadespacho_numeroOT").val("");
    $("#txt_guiadespacho_itemnumero").val("");
    $("#txt_guiadespacho_cantidad").val("");
    $("#txt_guiadespacho_detalle").val("");
    $("#txt_guiadespacho_valor").val("");
    $("#txt_guiadespacho_totalitem").val("");
    $("#txt_guiadespacho_itemnumero").val("");    
}

function modificarDetalleGuia(){
    var numeroGuia = $("#txt_guiadespacho_numero").val();
    var numeroOT = $("#txt_guiadespacho_numeroOT").val();
    var itemGuia = $("#txt_guiadespacho_itemnumero").val();    
    var cantidad = $("#txt_guiadespacho_cantidad").val();
    var detalleGuia = $("#txt_guiadespacho_detalle").val();
    var valorUnitario = $("#txt_guiadespacho_valor").val();
    var totalItem = $("#txt_guiadespacho_totalitem").val();    
    var itemOT = $("#txt_guiadespacho_itemnumero").val();
    
    if ($("#txt_guiadespacho_numeroOT").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_numeroOT").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_itemnumero").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_itemnumero").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_cantidad").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_cantidad").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_detalle").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_detalle").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_valor").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_valor").focus();
        return false;
    } 
    
    if ($("#txt_guiadespacho_totalitem").val() == "") {
        FuncionErrores(29);
        $("#txt_guiadespacho_totalitem").focus();
        return false;
    }     

    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();

    $.ajax({
        url : 'ServletSPGuiaDespachoDet', 
        data: "opcion=update"+"&txt_guia_numero="+numeroGuia+"&txt_OT_numero="+numeroOT+"&txt_guia_item="+itemGuia+
                "&txt_guia_cantidad="+cantidad+"&txt_guia_detalle="+detalleGuia+"&txt_guia_nroitem="+itemOT+
                "&txt_guia_valor="+valorUnitario+"&txt_guia_totalitem="+totalItem+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',        
        dataType : "html",
        success : function(data) {
            $("#DetalleIngresoGuia").show();
            $("#DetalleModificaGuia").hide();
            $("#DetalleEliminaGuia").hide();
            $("#CancelaModificaGuia").hide();
            $("#btn_detalleComercial_cancela").hide();
            $("#habilitaDetCom").val("0");
            cargaDetalleGuia();
            $("#txt_guiadespacho_numeroOT").val("");
            $("#txt_guiadespacho_itemnumero").val("");
            $("#txt_guiadespacho_cantidad").val("");
            $("#txt_guiadespacho_detalle").val("");
            $("#txt_guiadespacho_valor").val("");
            $("#txt_guiadespacho_totalitem").val("");
            $("#txt_guiadespacho_itemnumero").val("");
        }
    });
}

function asociaDetalleGuia(){
    var numeroGuia=$("#txt_guiadespacho_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPGuiaDespachoDet', 
        data: "opcion=asocia_detalle"+"&txt_guia_numero="+numeroGuia+"&txt_OT_numero=0"+"&txt_guia_item=0"+
                "&txt_guia_cantidad=0"+"&txt_guia_detalle="+"&txt_guia_nroitem=0"+
                "&txt_guia_valor=0"+"&txt_guia_totalitem=0"+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
           
        }
    });
    
}

function eliminarDetalleGuia(){
    var numeroGuia = $("#txt_guiadespacho_numero").val();
    var numeroOT = $("#txt_guiadespacho_numeroOT").val();
    var itemGuia = $("#txt_guiadespacho_itemnumero").val();    
    var cantidad = $("#txt_guiadespacho_cantidad").val();
    var detalleGuia = $("#txt_guiadespacho_detalle").val();
    var valorUnitario = $("#txt_guiadespacho_valor").val();
    var totalItem = $("#txt_guiadespacho_totalitem").val();    
    var itemOT = $("#txt_guiadespacho_itemnumero").val();
    
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();    
    
    $.ajax({
        url : 'ServletSPGuiaDespachoDet', 
        data: "opcion=delete"+"&txt_guia_numero="+numeroGuia+"&txt_OT_numero="+numeroOT+"&txt_guia_item="+itemGuia+
                "&txt_guia_cantidad="+cantidad+"&txt_guia_detalle="+detalleGuia+"&txt_guia_nroitem="+itemOT+
                "&txt_guia_valor="+valorUnitario+"&txt_guia_totalitem="+totalItem+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#DetalleIngresoGuia").show();
            $("#DetalleModificaGuia").hide();
            $("#DetalleEliminaGuia").hide();
            $("#CancelaModificaGuia").hide();
            $("#btn_detalleComercial_cancela").hide();
            $("#habilitaDetCom").val("0");
            cargaDetalleGuia();
            $("#txt_guiadespacho_numeroOT").val("");
            $("#txt_guiadespacho_itemnumero").val("");
            $("#txt_guiadespacho_cantidad").val("");
            $("#txt_guiadespacho_detalle").val("");
            $("#txt_guiadespacho_valor").val("");
            $("#txt_guiadespacho_totalitem").val("");
            $("#txt_guiadespacho_itemnumero").val("");
        }
    });
}