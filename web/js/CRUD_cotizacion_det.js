function ingresaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var valUnitario=$("#txt_cotizacion_valUnitario").val();
    var totales=$("#txt_cotizacion_totales").val();
    var c_horas=$("#txt_cotizacion_cHora").val();
    var cantHoras=$("#txt_cotizacion_cantHrs").val();
    var totalHoras=$("#txt_cotizacion_totalhoras").val();   
    
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    if ($("#select_cotizacion_pieza").val() == "") {
        FuncionErrores(28);
        $("#select_cotizacion_pieza").focus();
        return false;
    }

    if ($("#txt_cotizacion_cantidad").val() == "") {
        FuncionErrores(29);
        $("#txt_cotizacion_cantidad").focus();
        return false;
    }    

    if ($("#txt_cotizacion_dm").val() == "") {
        FuncionErrores(30);
        $("#txt_cotizacion_dm").focus();
        return false;
    }    

    if ($("#txt_cotizacion_diametro").val() == "") {
        FuncionErrores(31);
        $("#txt_cotizacion_diametro").focus();
        return false;
    }    

    if ($("#txt_cotizacion_largo").val() == "") {
        FuncionErrores(32);
        $("#txt_cotizacion_largo").focus();
        return false;
    }    
    
    
    if ($("#txt_cotizacion_valUniCrom").val() == "") {
        FuncionErrores(33);
        $("#txt_cotizacion_valUniCrom").focus();
        return false;
    }
    
    if ($("#txt_cotizacion_totalCrom").val() == "") {
        FuncionErrores(34);
        $("#txt_cotizacion_totalCrom").focus();
        return false;
    }
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=insert"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_valUnitario="+valUnitario+
                "&txt_cotizacion_totales="+totales+"&txt_cotizacion_cHora="+c_horas+
                "&txt_cotizacion_cantHrs="+cantHoras+"&txt_cotizacion_totalhoras="+totalHoras+
                "&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            cargaDetallePaso();
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
    var valUnitario=$("#txt_cotizacion_valUnitario").val();
    var totales=$("#txt_cotizacion_totales").val();    
    var c_horas=$("#txt_cotizacion_cHora").val();
    var cantHoras=$("#txt_cotizacion_cantHrs").val();
    var totalHoras=$("#txt_cotizacion_totalhoras").val();      
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=asocia_detalle"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+0+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+0+
                "&txt_cotizacion_largo="+0+"&txt_cotizacion_valUniCrom="+0+
                "&txt_cotizacion_totalCrom="+0+"&txt_cotizacion_valUnitario="+0+
                "&txt_cotizacion_totales="+0+"&txt_cotizacion_cHora="+0+
                "&txt_cotizacion_cantHrs="+0+"&txt_cotizacion_totalhoras="+0+
                "&txt_cotizacion_numero="+numeroCotizacion+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
           
        }
    });
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=asocia_detalle"+"&txt_cotizacion_valor="+0+"&txt_cotizacion_margen="+0+
                "&txt_cotizacion_totalmaterial="+0+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
          
        }
    });    
}

function guardaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var valUnitario=$("#txt_cotizacion_valUnitario").val();
    var totales=$("#txt_cotizacion_totales").val();    
    var c_horas=$("#txt_cotizacion_cHora").val();
    var cantHoras=$("#txt_cotizacion_cantHrs").val();
    var totalHoras=$("#txt_cotizacion_totalhoras").val();      
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=guarda_detalle"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+0+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+0+
                "&txt_cotizacion_largo="+0+"&txt_cotizacion_valUniCrom="+0+
                "&txt_cotizacion_totalCrom="+0+"&txt_cotizacion_valUnitario="+0+
                "&txt_cotizacion_totales="+0+"&txt_cotizacion_cHora="+0+
                "&txt_cotizacion_cantHrs="+0+"&txt_cotizacion_totalhoras="+0+
                "&txt_cotizacion_numero="+numeroCotizacion+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
           
        }
    });
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=guarda_detalle"+"&txt_cotizacion_valor="+0+"&txt_cotizacion_margen="+0+
                "&txt_cotizacion_totalmaterial="+0+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo=",
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
                "&txt_cotizacion_totalCrom=0"+"&txt_cotizacion_valUnitario=0"+
                "&txt_cotizacion_totales=0"+"&txt_cotizacion_cHora=0"+
                "&txt_cotizacion_cantHrs=0"+"&txt_cotizacion_totalhoras=0"+
                "&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaDetalle").find("tbody").html(data);  
            $("#txt_cotizacion_cantidad").val("");
            $("#txt_cotizacion_dm").val("");
            $("#txt_cotizacion_diametro").val("");
            $("#txt_cotizacion_largo").val("");
            $("#txt_cotizacion_valUniCrom").val("");
            $("#txt_cotizacion_cHora").val("");
            $("#txt_cotizacion_cantHrs").val("");
            $("#select_cotizacion_pieza").val("--Seleccione--");
            }
    });
}

function cargaDetallePaso(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=select_paso"+"&select_cotizacion_pieza=0"+"&txt_cotizacion_cantidad=0"+
                "&txt_cotizacion_dm=0"+"&txt_cotizacion_diametro=0"+
                "&txt_cotizacion_largo=0"+"&txt_cotizacion_valUniCrom=0"+
                "&txt_cotizacion_totalCrom=0"+"&txt_cotizacion_valUnitario=0"+
                "&txt_cotizacion_totales=0"+"&txt_cotizacion_cHora=0"+
                "&txt_cotizacion_cantHrs=0"+"&txt_cotizacion_totalhoras=0"+
                "&txt_cotizacion_numero="+numeroCotizacion+
                "&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaDetalle").find("tbody").html(data);  
            $("#txt_cotizacion_cantidad").val("");
            $("#txt_cotizacion_dm").val("");
            $("#txt_cotizacion_diametro").val("");
            $("#txt_cotizacion_largo").val("");
            $("#txt_cotizacion_valUniCrom").val("");
            $("#txt_cotizacion_cHora").val("");
            $("#txt_cotizacion_cantHrs").val("");
            $("#select_cotizacion_pieza").val("--Seleccione--");
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
        $("#txt_cotizacion_cHora").val($("#cotazacionDet_cHora"+id).text());
        $("#txt_cotizacion_cantHrs").val($("#cotazacionDet_cantHoras"+id).text());
        $("#txt_cotizacion_valUnitario").val($("#cotazacionDet_valUnitario"+id).text());        
        $("#txt_cotizacion_totales").val($("#cotazacionDet_totales"+id).text());        
        
        var accion=getUrlParameter('accion');
        
        if(accion=="consulta"){
            $("#DetalleIngreso").hide(); 
            $("#txt_correlativo").val($("#cotazacionDet_correlativo"+id).text());
            $("#txt_correlativo2").val($("#cotazacionDet_correlativo"+id).text());            
            $("#hidtemp").val(id);
            return;
        }
        $("#SubDetalleIngreso").show();
        $("#SubDetalleModifica").hide();
        $("#SubDetalleElimina").hide();        
        $("#SubDetalleCancela").hide(); 
        $("#DetalleModifica").show();
        $("#CancelaModifica").show();
        $("#DetalleElimina").show();        
        $("#DetalleIngreso").hide();
        $("#habilitaDetCom").val("1");
        $("#txt_correlativo").val($("#cotazacionDet_correlativo"+id).text());
        $("#txt_correlativo2").val($("#cotazacionDet_correlativo"+id).text());
        $("#txt_cotizacion_valor").val("");
        $("#txt_cotizacion_margen").val("");
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
    $("#SubDetalleIngreso").hide();
    $("#DetalleIngreso").show();
    $("#DetalleModifica").hide();
    $("#DetalleElimina").hide();    
    $("#CancelaModifica").hide(); 
    $("#habilitaDetCom").val("0");
    $("#txt_cotizacion_cantidad").val("");
    $("#txt_cotizacion_dm").val("");
    $("#txt_cotizacion_diametro").val("");
    $("#txt_cotizacion_largo").val("");
    $("#txt_cotizacion_valUniCrom").val("");
    $("#txt_cotizacion_cHora").val("");
    $("#txt_cotizacion_cantHrs").val("");
    $("#select_cotizacion_pieza").val("--Seleccione--");    
    
}

function modificaDetalle(){
    var pieza=$("#select_cotizacion_pieza").val();
    var cantidad=$("#txt_cotizacion_cantidad").val();
    var valorDM=$("#txt_cotizacion_dm").val();
    var valorDiametro=$("#txt_cotizacion_diametro").val();
    var largo=$("#txt_cotizacion_largo").val();
    var valUniCrom=$("#txt_cotizacion_valUniCrom").val();
    var totalCrom=$("#txt_cotizacion_totalCrom").val();
    var valUnitario=$("#txt_cotizacion_valUnitario").val();
    var totales=$("#txt_cotizacion_totales").val();    
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var c_horas=$("#txt_cotizacion_cHora").val();
    var cantHoras=$("#txt_cotizacion_cantHrs").val();   
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();
    
    if ($("#select_cotizacion_pieza").val() == "") {
        FuncionErrores(28);
        $("#select_cotizacion_pieza").focus();
        return false;
    }

    if ($("#txt_cotizacion_cantidad").val() == "") {
        FuncionErrores(29);
        $("#txt_cotizacion_cantidad").focus();
        return false;
    }    

    if ($("#txt_cotizacion_dm").val() == "") {
        FuncionErrores(30);
        $("#txt_cotizacion_dm").focus();
        return false;
    }    

    if ($("#txt_cotizacion_diametro").val() == "") {
        FuncionErrores(31);
        $("#txt_cotizacion_diametro").focus();
        return false;
    }    

    if ($("#txt_cotizacion_largo").val() == "") {
        FuncionErrores(32);
        $("#txt_cotizacion_largo").focus();
        return false;
    }    
    
    
    if ($("#txt_cotizacion_valUniCrom").val() == "") {
        FuncionErrores(33);
        $("#txt_cotizacion_valUniCrom").focus();
        return false;
    }
    
    if ($("#txt_cotizacion_totalCrom").val() == "") {
        FuncionErrores(34);
        $("#txt_cotizacion_totalCrom").focus();
        return false;
    }    
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=update"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_valUnitario="+valUnitario+
                "&txt_cotizacion_totales="+totales+"&txt_cotizacion_numero="+numeroCotizacion+
                "&txt_cotizacion_cHora="+c_horas+"&txt_cotizacion_cantHrs="+cantHoras+              
                "&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#DetalleIngreso").show();
            $("#DetalleModifica").hide();
            $("#CancelaModifica").hide();
            $("#DetalleElimina").hide();
            $("#habilitaDetCom").val("0");
            $("#SubDetalleIngreso").hide();
            cargaDetallePaso();
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
    var valUnitario=$("#txt_cotizacion_valUnitario").val();
    var totales=$("#txt_cotizacion_totales").val();    
    var costoHora=$("#txt_cotizacion_cHora").val();        
    var cantHoras=$("#txt_cotizacion_cHora").val();            
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();
    
    $.ajax({
        url : 'ServletSPCotizacionDet', 
        data: "opcion=delete"+"&select_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_cotizacion_dm="+valorDM+"&txt_cotizacion_diametro="+valorDiametro+
                "&txt_cotizacion_largo="+largo+"&txt_cotizacion_valUniCrom="+valUniCrom+
                "&txt_cotizacion_totalCrom="+totalCrom+"&txt_cotizacion_valUnitario="+valUnitario+
                "&txt_cotizacion_totales="+totales+"&txt_cotizacion_numero="+numeroCotizacion+
                "&txt_cotizacion_cHora="+costoHora+"&txt_cotizacion_cantHrs="+cantHoras+
                "&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#DetalleIngreso").show();
            $("#DetalleModifica").hide();
            $("#DetalleElimina").hide();
            $("#CancelaModifica").hide();
            $("#habilitaDetCom").val("0");
            $("#SubDetalleIngreso").hide();
            cargaDetallePaso();
            eliminaTodoSubDetalle();
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
    var cantHoras = $("#txt_cotizacion_cantHrs").val()==""?"0":$("#txt_cotizacion_cantHrs").val();
    var valorHoras = $("#txt_cotizacion_cHora").val()==""?"0":$("#txt_cotizacion_cHora").val();
    var valormaterial = $("#txt_cotizacion_valor").val()==""?"0":$("#txt_cotizacion_valor").val();
    var margen = $("#txt_cotizacion_margen").val()==""?"0":$("#txt_cotizacion_margen").val();
    
    
    var total=cantidad*valorUniCrom;
    var totalhoras=cantHoras*valorHoras;
    var totalmaterial=valormaterial*margen;
    
    $("#txt_cotizacion_totalCrom").val(total);
    $("#txt_cotizacion_totalhoras").val(totalhoras);
    $("#txt_cotizacion_totalmaterial").val(totalmaterial);
}

function CargaCorrDet(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var correlativo=$("#txt_correlativo2").val();
    var sequence =getUrlParameter('secuencia');

    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=select_detalle"+"&txt_cotizacion_valor="+0+"&txt_cotizacion_margen="+0+
                "&txt_cotizacion_totalmaterial="+0+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaSubDetalle").find("tbody").html(data);
        }
    });
}

function CargaSubDetModifica(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var correlativo=$("#txt_correlativo").val();
    var sequence =getUrlParameter('secuencia');

    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=select"+"&txt_cotizacion_valor="+0+"&txt_cotizacion_margen="+0+
                "&txt_cotizacion_totalmaterial="+0+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
        }
    });
}

function ingresaSubDetalle(){
    var valor=$("#txt_cotizacion_valor").val();
    var margen=$("#txt_cotizacion_margen").val();
    var totalmaterial=$("#txt_cotizacion_totalmaterial").val();
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var correlativo=$("#txt_correlativo").val();    
    var sequence =getUrlParameter('secuencia');

    if ($("#txt_cotizacion_valor").val() == "") {
        FuncionErrores(37);
        $("#txt_cotizacion_valor").focus();
        return false;
    }    

    if ($("#txt_cotizacion_margen").val() == "") {
        FuncionErrores(38);
        $("#txt_cotizacion_margen").focus();
        return false;
    }    

    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=insert"+"&txt_cotizacion_valor="+valor+"&txt_cotizacion_margen="+margen+
                "&txt_cotizacion_totalmaterial="+totalmaterial+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            cargaSubDetalle();
        }
    });
}

function cargaSubDetalle(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var correlativo=$("#txt_correlativo").val();        
    var sequence =getUrlParameter('secuencia');
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=select_detalle"+"&txt_cotizacion_valor="+0+"&txt_cotizacion_margen="+0+
                "&txt_cotizacion_totalmaterial="+0+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaSubDetalle").find("tbody").html(data);
            $("#txt_cotizacion_valor").val("");
            $("#txt_cotizacion_margen").val("");
        }
    });
}

function ModificaSubDetalleComercial(id)
{
    CancelaSubDetalle();
    if($("#habilitaSubDetCom").val() == 0)
    {
        $("#filaTablaSubDetalle"+id).css("background-color","#58FAF4").removeClass("alt");
        $("#txt_cotizacion_valor").val($("#cotazacionSubDet_valor"+id).text());
        $("#txt_cotizacion_margen").val($("#cotazacionSubDet_margen"+id).text());              
        
        var accion=getUrlParameter('accion');
        
        if(accion=="consulta"){
            $("#SubDetalleIngreso").hide(); 
            $("#txt_subitem").val($("#cotazacionSubDet_item"+id).text());
            return;
        }
        $("#SubDetalleIngreso").hide();
        $("#SubDetalleModifica").show();
        $("#SubDetalleElimina").show();        
        $("#SubDetalleCancela").show();                
        $("#DetalleIngreso").hide();
        $("#habilitaSubDetCom").val("1");
        $("#txt_subitem").val($("#cotazacionSubDet_item"+id).text());
        $("#hidtemp").val(id);
    }
}

function CancelaSubDetalle()
{
    var td = $('#tablaSubDetalle').children('tbody').children('tr').length;  
    for(var i = 0; i<=td;i++){                
        if(i % 2 === 0){
            $("#filaTablaSubDetalle"+i).addClass("alt");
        }else {                    
            $("#filaTablaSubDetalle"+i).css("background-color","white");
        }
    }
    
    $("#SubDetalleIngreso").show();
    $("#SubDetalleModifica").hide();
    $("#SubDetalleElimina").hide();    
    $("#SubDetalleCancela").hide();                    
    $("#habilitaSubDetCom").val("0");
    $("#txt_cotizacion_valor").val("");
    $("#txt_cotizacion_margen").val("");
}

function modificaSubDetalle(){
    var valor=$("#txt_cotizacion_valor").val();
    var margen=$("#txt_cotizacion_margen").val(); 
    var totalmaterial=$("#txt_cotizacion_totalmaterial").val();    
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo").val();
    var subitem=$("#txt_subitem").val();
    
    if ($("#txt_cotizacion_valor").val() == "") {
        FuncionErrores(37);
        $("#txt_cotizacion_valor").focus();
        return false;
    }    

    if ($("#txt_cotizacion_margen").val() == "") {
        FuncionErrores(38);
        $("#txt_cotizacion_margen").focus();
        return false;
    }        
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=update"+"&txt_cotizacion_valor="+valor+"&txt_cotizacion_margen="+margen+
                "&txt_cotizacion_totalmaterial=0"+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+subitem+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#SubDetalleIngreso").show();
            $("#SubDetalleModifica").hide();
            $("#SubDetalleElimina").hide();
            $("#SubDetalleCancela").hide();                            
            $("#btn_detalleComercial_cancela").hide();
            $("#habilitaSubDetCom").val("0");
            cargaSubDetalle();
        }
    });
}

function eliminaSubDetalle(){
    var valor=$("#txt_cotizacion_valor").val();
    var margen=$("#txt_cotizacion_margen").val(); 
    var totalmaterial=$("#txt_cotizacion_totalmaterial").val(); 
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo2").val();
    var subitem=$("#txt_subitem").val();    
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=delete"+"&txt_cotizacion_valor=0"+"&txt_cotizacion_margen=0"+
                "&txt_cotizacion_totalmaterial=0"+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+subitem+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#SubDetalleIngreso").show();
            $("#SubDetalleModifica").hide();
            $("#SubDetalleElimina").hide();
            $("#SubDetalleCancela").hide();                            
            $("#habilitaSubDetCom").val("0");
            cargaSubDetalle();
        }
    });
}

function LimpiaSubDetalle(){
    var numeroCotizacion=0;
    var correlativo=0;        
    var sequence =0;
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=select_detalle"+"&txt_cotizacion_valor="+0+"&txt_cotizacion_margen="+0+
                "&txt_cotizacion_totalmaterial="+0+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem="+0+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tablaSubDetalle").find("tbody").html(data);
            $("#txt_cotizacion_valor").val("");
            $("#txt_cotizacion_margen").val("");
            $("#SubDetalleModifica").hide();
            $("#SubDetalleElimina").hide();
            $("#SubDetalleCancela").hide();                            
            $("#habilitaSubDetCom").val("0");
        }
    });
}

function eliminaTodoSubDetalle(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var sequence =getUrlParameter('secuencia');
    var correlativo=$("#txt_correlativo2").val();
    var subitem=$("#txt_subitem").val();    
    
    $.ajax({
        url : 'ServletSPCotizacionSubDet', 
        data: "opcion=delete"+"&txt_cotizacion_valor=0"+"&txt_cotizacion_margen=0"+
                "&txt_cotizacion_totalmaterial=0"+"&txt_cotizacion_numero="+numeroCotizacion+
                "&subitem=0"+"&sequencia="+sequence+"&correlativo="+correlativo,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#SubDetalleIngreso").show();
            $("#SubDetalleModifica").hide();
            $("#SubDetalleElimina").hide();
            $("#SubDetalleCancela").hide();                            
            $("#habilitaSubDetCom").val("0");
            LimpiaSubDetalle();
        }
    });
}