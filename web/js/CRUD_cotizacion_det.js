function ingresaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=insert"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            cargaDetalle();
        }
    });
}

function asociaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=asocia_detalle"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            alert("Registro Guardado");
        }
    });
}

function cargaDetalle(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=select"+"&select_cotizacion_pieza=0"+"&txt_cotizacion_cantidad=0"+
                "&txt_cotizacion_dm=0"+"&txt_cotizacion_diametro=0"+
                "&txt_cotizacion_largo=0"+"&txt_cotizacion_valUniCrom=0"+
                "&txt_cotizacion_totalCrom=0"+"&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaDetalle").find("tbody").html(data);  
        }
    });
}

function ModificaDetalleComercial(id)
{
    CancelaDetalle();
    if($("#habilitaDetCom").val() == 0)
    {
        $("#filaTablaDetalle"+id).css("background-color","#58FAF4").removeClass("alt");
        $("#select_cotizacion_pieza").val($("#cotazacionDet_codPieza"+id).text());
        $("#txt_cotizacion_cantidad").val($("#cotazacionDet_cantidad"+id).text());        
        $("#txt_cotizacion_dm").val($("#cotazacionDet_valorDm"+id).text());
        $("#txt_cotizacion_diametro").val($("#cotazacionDet_diametro"+id).text());
        $("#txt_cotizacion_largo").val($("#cotazacionDet_largo"+id).text());
        $("#txt_cotizacion_valUniCrom").val($("#cotazacionDet_valUniCrom"+id).text());        
        $("#txt_cotizacion_totalCrom").val($("#cotazacionDet_totalCrom"+id).text());
        
        var accion=getUrlParameter('accion');
        
        if(accion=="consulta"){
            $("#DetalleIngreso").hide(); 
            return;
        }
        
        $("#DetalleModifica").show();
        $("#DetalleElimina").show();        
        $("#DetalleIngreso").hide();
        $("#habilitaDetCom").val("1");
        $("#txt_correlativo").val($("#cotazacionDet_correlativo"+id).text());
        $("#hidtemp").val(id);
    }
}

function CancelaDetalle()
{
    var td = $('#tblDetalleComer').children('tbody').children('tr').length;           
    for(var i = 0; i<=td;i++){                
        if(i % 2 === 0){
            $("#filaTablaDetalle"+i).addClass("alt");
        }else {                    
            $("#filaTablaDetalle"+i).css("background-color","white");
        }
    }
    $("#DetalleIngreso").show();
    $("#DetalleModifica").hide();
    $("#DetalleElimina").hide();    
    $("#habilitaDetCom").val("0");
}

function modificaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=update"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#DetalleIngreso").show();
            $("#DetalleModifica").hide();
            $("#DetalleElimina").hide();
            $("#btn_detalleComercial_cancela").hide();
            $("#habilitaDetCom").val("0");
            cargaDetalle();
        }
    });
}

function eliminaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=delete"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#DetalleIngreso").show();
            $("#DetalleModifica").hide();
            $("#DetalleElimina").hide();
            $("#btn_detalleComercial_cancela").hide();
            $("#habilitaDetCom").val("0");
            cargaDetalle();
        }
    });
}

function cargaValorDetalle(){
    var codigo=$("#select_cotizacion_pieza").val();
    $.ajax({
        url : 'ServletSPPieza', 
        data: "opcion=get_valor&codigo="+codigo+"&nombre=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#txt_cotizacion_valUniCrom").val(data);
            calculaTotal();
        }
    });
}

function filtraPiezas(){
    var nombre=$("#txt_cotizacion_filtro_pieza").val();
    $.ajax({
        url : 'ServletSPPieza', 
        data: "opcion=filter&codigo=&nombre="+nombre,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#select_cotizacion_pieza_filter").html(data);
        }
    });
}

function calculaTotal(){
    var cantidad = $("#txt_cotizacion_cantidad").val()==""?"0":$("#txt_cotizacion_cantidad").val();
    var valorUniCrom = $("#txt_cotizacion_valUniCrom").val()==""?"0":$("#txt_cotizacion_valUniCrom").val();
    
    var total=cantidad*valorUniCrom;
    
    $("#txt_cotizacion_totalCrom").val(total);
}