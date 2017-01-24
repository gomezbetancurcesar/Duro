/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function ingresaDetalleOT(){
    var numeroOrden = $("#txt_orden_numero").val();

    var rectificadoPrevio = $("#select_rectificado_previo").val();
    var medidaObtenidaRectPrevio = $("#txt_medida_obtenida_rectprevio").val();        
    var rectificadoPrevioEn = $("#txt_rectificadoprevio_en").val();
    var tornoRectPrevio = $("#select_torno_rect_previo").val();
    var tornoporRectPrevio = $("#txt_tornopor_previo").val();
    
    var cromado = $("#select_cromado").val();
    var espesorPedido = $("#txt_espesor_pedido").val();
    var cromadoEn = $("#txt_cromado_en").val();
    var superficie = $("#txt_superficie").val();
    var corriente = $("#txt_corriente").val();
    var tiempo = $("#txt_tiempo").val();
    var otroBano = $("#txt_otro_tratamiento").val();
    
    var rectificadoFinal = $("#select_rectificado_final").val();
    var medidaObtenidaRectFinal = $("#txt_medida_obtenida_rectfinal").val();
    var rectificadoFinalEn = $("#txt_rectificadofinal_en").val();
    var tornoRectFinal = $("#select_torno_rect_final").val();    
    var tornoporRectFinal = $("#txt_tornopor_final").val();

    var observaciones = $("#txt_observaciones").val();
    var inspeccionFinal = $("#txt_inspeccion_final").val();
    var tratamientoFinaltermico = $("#txt_tratamientofinaltermico").val();

    var metalBase = $("#txt_metalbase_considerar").val();
    var tratamientoTermico = $("#select_tratamiento_termico").val();    
    var superficieDureza = $("#select_superficiedureza").val();
    var superficieEstado = $("#select_superficieestado").val();    
    var superficieSoldadura = $("#select_superficiesoldadura").val();

    var cromadosAnteriores = $("#txt_cromados_anteriores").val();
    var presion = $("#txt_presion").val();    
    var medio = $("#txt_medio").val();
    var desgaste = $("#txt_desgaste").val();

    var temperatura = $("#txt_temperatura").val();
    var suspensionPieza = $("#txt_suspension").val();
    var conexionElectrica = $("#txt_conexion_electrica").val();    

    var pieza = $("#select_ordentaller_pieza").val();    
    var piezaMetalBase = $("#select_metalbase_piezas").val();
    var largo = $("#txt_largo_pieza").val();    
    
    var cantidad = $("#txt_cotizacion_cantidad").val();    
    var medida1 = $("#txt_medidas1_pieza").val();
    var planos = $("#txt_planos_pieza").val();
    
    var estadoPieza = $("#select_estado_piezas").val();
    var medida2 = $("#txt_medidas2_pieza").val();    
    var trabajoRealizar = $("#txt_trabajo_realizar").val();

    var sequence =getUrlParameter('secuencia');
    
    var accion = getUrlParameter('accion');    
    
    if (accion == "modifica") {
        accion = "update";
    } else {
        accion = "insert";
    }
    
    $.ajax({
        url : 'ServletSPOrdenTallerDet', 
        data: "opcion="+accion+"&txt_orden_numero="+numeroOrden+"&txt_cotizacion_pieza="+pieza+"&txt_cotizacion_cantidad="+cantidad+
                "&txt_medidas1_pieza="+medida1+"&txt_medidas2_pieza="+medida2+
                "&txt_largo_pieza="+largo+"&txt_planos_pieza="+planos+"&txt_trabajo_realizar="+trabajoRealizar+
                "&select_rectificado_previo="+rectificadoPrevio+"&txt_rectificadoprevio_en="+rectificadoPrevioEn+
                "&txt_medida_obtenida_rectprevio="+medidaObtenidaRectPrevio+"&txt_torno_rect_previo="+tornoRectPrevio+
                "&txt_tornopor_previo="+tornoporRectPrevio+"&select_cromado="+cromado+"&txt_cromado_en="+cromadoEn+
                "&txt_superficie="+superficie+"&txt_corriente="+corriente+"&txt_tiempo="+tiempo+
                "&txt_otro_tratamiento="+otroBano+"&txt_espesor_pedido="+espesorPedido+"&select_rectificado_final="+rectificadoFinal+
                "&txt_medida_obtenida_rectfinal="+medidaObtenidaRectFinal+"&txt_rectificadofinal_en="+rectificadoFinalEn+
                "&select_torno_rect_final="+tornoRectFinal+"&txt_tornopor_final="+tornoporRectFinal+
                "&txt_observaciones="+observaciones+"&txt_inspeccion_final="+inspeccionFinal+
                "&txt_tratamientofinaltermico="+tratamientoFinaltermico+"&select_metalbase_piezas="+metalBase+
                "&select_tratamiento_termico="+tratamientoTermico+"&select_superficiedureza="+superficieDureza+
                "&select_superficieestado="+superficieEstado+"&select_superficiesoldadura="+superficieSoldadura+
                "&txt_cromados_anteriores="+cromadosAnteriores+"&txt_presion="+presion+"&txt_medio="+medio+
                "&txt_desgaste="+desgaste+"&txt_temperatura="+temperatura+"&txt_suspension="+suspensionPieza+
                "&txt_conexion_electrica="+conexionElectrica+"&txt_estado_piezas="+estadoPieza+
                "&select_metalbase="+piezaMetalBase+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            alert("Registro Guardado");
        }
    });
}


function cargaDetalleOT(){
    var desde =$("#txt_filtroComercial_ingreso").val();
    var hasta =$("#txt_filtroComercial_final").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');
 
    var date = new Date();
    var dd=("0" + date.getDate()).slice(-2)
    var mm=("0" + (date.getMonth() + 1)).slice(-2);
    var yy=date.getFullYear();
    
    var fecha=yy+"-"+mm+"-"+dd;
    
    $.ajax({
        url : 'ServletSPOrdenTallerDet', 
        data: "opcion=select"+"&txt_orden_numero=0"+"&txt_cotizacion_pieza=0"+"&txt_cotizacion_cantidad=0"+
                "&txt_medidas1_pieza=0"+"&txt_medidas2_pieza=0"+
                "&txt_largo_pieza=0"+"&txt_planos_pieza=0"+"&txt_trabajo_realizar=0"+
                "&select_rectificado_previo=0"+"&txt_rectificadoprevio_en="+
                "&txt_medida_obtenida_rectprevio=0"+"&txt_torno_rect_previo=0"+
                "&txt_tornopor_previo=0"+"&select_cromado=0"+"&txt_cromado_en="+
                "&txt_superficie=0"+"&txt_corriente=0"+"&txt_tiempo=0"+
                "&txt_otro_tratamiento=0"+"&txt_espesor_pedido=0"+"&select_rectificado_final=0"+
                "&txt_medida_obtenida_rectfinal=0"+"&txt_rectificadofinal_en=0"+
                "&select_torno_rect_final=0"+"&txt_tornopor_final=0"+
                "&txt_observaciones=0"+"&txt_inspeccion_final=0"+
                "&txt_tratamientofinaltermico=0"+"&select_metalbase_piezas=0"+
                "&select_tratamiento_termico=0"+"&select_superficiedureza=0"+
                "&select_superficieestado=0"+"&select_superficiesoldadura=0"+
                "&txt_cromados_anteriores=0"+"&txt_presion=0"+"&txt_medio=0"+
                "&txt_desgaste=0"+"&txt_temperatura=0"+"&txt_suspension=0"+
                "&txt_conexion_electrica=0"+"&txt_estado_piezas=0"+"&sequencia="+sequence+"&correlativo=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            var arrResult=data.split("|");
            
            if(accion=="consulta"){
                $("#btnPiezas").hide();
                $("#select_rectificado_previo").prop("disabled",true);                
                $("#txt_medida_obtenida_rectprevio").attr("readonly","readonly");
                $("#txt_rectificadoprevio_en").attr("readonly","readonly");
                $("#select_torno_rect_previo").prop("disabled",true);                                
                $("#txt_tornopor_previo").attr("readonly","readonly");
                $("#select_cromado").prop("disabled",true);                                                
                $("#txt_espesor_pedido").attr("readonly","readonly");
                $("#txt_cromado_en").attr("readonly","readonly");
                $("#txt_superficie").attr("readonly","readonly");
                $("#txt_corriente").attr("readonly","readonly");
                $("#txt_tiempo").attr("readonly","readonly");
                $("#txt_otro_tratamiento").attr("readonly","readonly");
                $("#select_rectificado_final").prop("disabled",true);                                
                $("#txt_medida_obtenida_rectfinal").attr("readonly","readonly");
                $("#txt_rectificadofinal_en").attr("readonly","readonly");
                $("#select_torno_rect_final").prop("disabled",true);                                
                $("#txt_tornopor_final").attr("readonly","readonly");
                $("#txt_observaciones").attr("readonly","readonly");
                $("#txt_inspeccion_final").attr("readonly","readonly");
                $("#txt_tratamientofinaltermico").attr("readonly","readonly");
                $("#txt_metalbase_considerar").attr("readonly","readonly");                
                $("#select_tratamiento_termico").prop("disabled",true);                                
                $("#select_superficiedureza").prop("disabled",true);                                
                $("#select_superficieestado").prop("disabled",true);                                
                $("#select_superficiesoldadura").prop("disabled",true);                                                
                $("#txt_cromados_anteriores").attr("readonly","readonly");
                $("#txt_presion").attr("readonly","readonly");
                $("#txt_medio").attr("readonly","readonly");
                $("#txt_desgaste").attr("readonly","readonly");
                $("#txt_temperatura").attr("readonly","readonly");                  
                $("#txt_suspension").attr("readonly","readonly");
                $("#txt_conexion_electrica").attr("readonly","readonly");                  
                $("#txt_cotizacion_pieza").attr("readonly","readonly");                                  
                $("#select_metalbase_piezas").prop("disabled",true);                                                                
                $("#txt_largo_pieza").attr("readonly","readonly");   
                $("#select_ordentaller_pieza").prop("disabled",true); 
                $("#txt_cotizacion_cantidad").attr("readonly","readonly");
                $("#txt_medidas1_pieza").attr("readonly","readonly");                  
                $("#txt_planos_pieza").attr("readonly","readonly");                                  
                $("#select_estado_piezas").prop("disabled",true);                                                                
                $("#txt_medidas2_pieza").attr("readonly","readonly");                  
                $("#txt_trabajo_realizar").attr("readonly","readonly");
            }
            $("#txt_cotizacion_pieza").val(arrResult[0] + " " + arrResult[39]);
            $("#txt_cotizacion_cantidad").val(arrResult[1]);
            $("#txt_medidas1_pieza").val(arrResult[2]);
            $("#txt_medidas2_pieza").val(arrResult[3]);            
            $("#txt_largo_pieza").val(arrResult[4]);
            $("#txt_planos_pieza").val(arrResult[5]);
            $("#txt_trabajo_realizar").val(arrResult[6]);            
            $("#select_rectificado_previo").val(arrResult[7]);
            $("#txt_rectificadoprevio_en").val(arrResult[8]);            
            $("#txt_medida_obtenida_rectprevio").val(arrResult[9]);
            $("#select_torno_rect_previo").val(arrResult[10]);
            $("#txt_tornopor_previo").val(arrResult[11]);
            $("#select_cromado").val(arrResult[12]);
            $("#txt_cromado_en").val(arrResult[13]);
            $("#txt_superficie").val(arrResult[14]);
            $("#txt_corriente").val(arrResult[15]);
            $("#txt_tiempo").val(arrResult[16]);
            $("#txt_otro_tratamiento").val(arrResult[17]);
            $("#txt_espesor_pedido").val(arrResult[18]);
            $("#select_rectificado_final").val(arrResult[19]);
            $("#txt_rectificadofinal_en").val(arrResult[20]);            
            $("#txt_medida_obtenida_rectfinal").val(arrResult[21]);
            $("#select_torno_rect_final").val(arrResult[22]);
            $("#txt_tornopor_final").val(arrResult[23]);
            $("#txt_observaciones").val(arrResult[24]);
            $("#txt_inspeccion_final").val(arrResult[25]);
            $("#txt_tratamientofinaltermico").val(arrResult[26]);
            $("#txt_metalbase_considerar").val(arrResult[27]);          
            $("#select_tratamiento_termico").val(arrResult[28]);
            $("#select_superficiedureza").val(arrResult[29]);
            $("#select_superficieestado").val(arrResult[30]);
            $("#select_superficiesoldadura").val(arrResult[31]);
            $("#txt_cromados_anteriores").val(arrResult[32]);
            $("#txt_presion").val(arrResult[33]);
            $("#txt_medio").val(arrResult[34]);
            $("#txt_desgaste").val(arrResult[35]);
            $("#txt_temperatura").val(arrResult[36]);
            $("#txt_suspension").val(arrResult[37]);
            $("#txt_conexion_electrica").val(arrResult[38]);
            $("#select_estado_piezas").val(arrResult[39]);            
            $("#select_metalbase_piezas").val(arrResult[41]);
            $("#select_ordentaller_pieza").val(arrResult[0]);

            
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