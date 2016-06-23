function grabarCotizacion(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision=$("#txt_cotizacion_fecha").val();
    var atencion=$("#txt_cotizacion_atencion").val();
    var emitidaPor=$("#txt_cotizacion_emitida_por").val();
    var moneda=$("#select_cotizacion_moneda").val();
    var cotEspecial=$("#select_cotizacion_especial").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    
    var sequence =getUrlParameter('secuencia');
    
    var accion=getUrlParameter('accion');
    
    if(accion=="modifica"||numeroCotizacion!=""){
        accion="update";
    }else{
        accion="insert";
    }
    
    $.ajax({
        url : 'ServletSPCotizacion', 
        data: "opcion="+accion+"&txt_cotizacion_numero="+numeroCotizacion+"&txt_cotizacion_fecha="+fechaEmision
                +"&txt_cotizacion_atencion="+atencion+"&txt_cotizacion_emitida_por="+emitidaPor
                +"&select_cotizacion_moneda="+moneda+"&select_cotizacion_especial="+cotEspecial
                +"&select_cotizacion_presupuesto_valido="+presupuestoValido+"&select_cotizacion_plazo_entrega="+plazoEntrega
                +"&select_cotizacion_condicion_pago="+condicionesPago+"&txt_cotizacion_rutcli="+rutCli
                +"&txt_cotizacion_cli="+nombreCli+"&sequencia="+sequence+"&fecha_desde=&fecha_hasta"+"&estado=Ingresada",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#txt_cotizacion_numero").val(data);
            asociaDetalle();
        }
    });
}

function cargaCotizacion(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision=$("#txt_cotizacion_fecha").val();
    var atencion=$("#txt_cotizacion_atencion").val();
    var emitidaPor=$("#txt_cotizacion_emitida_por").val();
    var moneda=$("#select_cotizacion_moneda").val();
    var cotEspecial=$("#select_cotizacion_especial").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    
    var desde =$("#txt_filtroComercial_ingreso").val();
    var hasta =$("#txt_filtroComercial_final").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');
    
    var date = new Date();
    var dd=pad(date.getDate(),2,'0');
    var mm=pad(date.getMonth()+1,2,'0');
    var yy=date.getFullYear();
    
    var fecha=yy+"-"+mm+"-"+dd;
    
    $.ajax({
        url : 'ServletSPCotizacion', 
        data: "opcion=select"+"&txt_cotizacion_numero=0"+"&txt_cotizacion_fecha="+fecha
                +"&txt_cotizacion_atencion=0"+"&txt_cotizacion_emitida_por=0"
                +"&select_cotizacion_moneda=0"+"&select_cotizacion_especial=0"
                +"&select_cotizacion_presupuesto_valido=0"+"&select_cotizacion_plazo_entrega=0"
                +"&select_cotizacion_condicion_pago=0"+"&txt_cotizacion_rutcli=0"
                +"&txt_cotizacion_cli=0"+"&sequencia="+sequence+"&fecha_desde="+desde+"&fecha_hasta="+hasta+"&estado=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            var arrResult=data.split("|");
            
            if(accion=="consulta"){
                $("#btn_cotazacioncial_grabar").hide();
                $("#btn_cotizacion_aprobar").hide();
                $("#DetalleIngreso").hide();
            }
            
            $("#txt_cotizacion_numero").val(arrResult[0]);
            $("#txt_cotizacion_fecha").val(arrResult[1]);
            $("#txt_cotizacion_atencion").val(arrResult[2]);
            $("#txt_cotizacion_emitida_por").val(arrResult[3]);
            $("#select_cotizacion_moneda").val(arrResult[4]);
            $("#select_cotizacion_especial").val(arrResult[5]);
            $("#select_cotizacion_presupuesto_valido").val(arrResult[6]);
            $("#select_cotizacion_plazo_entrega").val(arrResult[7]);
            $("#select_cotizacion_condicion_pago").val(arrResult[8]);
            $("#txt_cotizacion_rutcli").val(arrResult[9]);
            $("#txt_cotizacion_cli").val(arrResult[10]);           
            
            if($("#txt_cotizacion_fecha").val()==""){
                $("#txt_cotizacion_fecha").val(fecha);
                $("#btn_cotizacion_aprobar").hide();
            }
        }
    });
}

function filtraCotizacion(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision=$("#txt_cotizacion_fecha").val();
    var atencion=$("#txt_cotizacion_atencion").val();
    var emitidaPor=$("#slt_filtroComercial_ejecutivo").val();
    var moneda=$("#select_cotizacion_moneda").val();
    var cotEspecial=$("#select_cotizacion_especial").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    
    var desde =$("#txt_filtroComercial_ingreso").val();
    var hasta =$("#txt_filtroComercial_final").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');
    
    var estado=$("#slt_filtroComercial_estado").val()== "" ? "X_X" : $("#slt_filtroComercial_estado").val();
    
    $.ajax({
        url : 'ServletSPCotizacion', 
        data: "opcion=select_all"+"&txt_cotizacion_numero=0"+"&txt_cotizacion_fecha=2016-04-04"
                +"&txt_cotizacion_atencion=0"+"&txt_cotizacion_emitida_por="+emitidaPor+
                +"&select_cotizacion_moneda=0"+"&select_cotizacion_especial=0"
                +"&select_cotizacion_presupuesto_valido=0"+"&select_cotizacion_plazo_entrega=0"
                +"&select_cotizacion_condicion_pago=0"+"&txt_cotizacion_rutcli=0"
                +"&txt_cotizacion_cli=0"+"&sequencia="+sequence+"&fecha_desde="+desde+"&fecha_hasta="+hasta
                +"&estado="+estado,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            alert(data);
            $('#tblActComercial').dataTable().fnDestroy(); 
            $("#tblActComercial").find("tbody").html(data);  
            $('#tblActComercial').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
                "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
                bFilter: false, bInfo: false,
                "bLengthChange": false,
               "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7,8,9,10,11] }]
            });
            //$("#tblActComercial").find("tbody").html(data);  
        }
    });
}

function aprobarCotiza(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision=$("#txt_cotizacion_fecha").val();
    var atencion=$("#txt_cotizacion_atencion").val();
    var emitidaPor=$("#txt_cotizacion_emitida_por").val();
    var moneda=$("#select_cotizacion_moneda").val();
    var cotEspecial=$("#select_cotizacion_especial").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion="modifica";
    
    if(accion=="modifica"){
        accion="update"
    }else{
        accion="insert";
    }
    
    if(confirm("Una vez aprobada la cotizacion no puede volver a modificarla")){
        $.ajax({
            url : 'ServletSPCotizacion', 
            data: "opcion="+accion+"&txt_cotizacion_numero="+numeroCotizacion+"&txt_cotizacion_fecha="+fechaEmision
                    +"&txt_cotizacion_atencion="+atencion+"&txt_cotizacion_emitida_por="+emitidaPor
                    +"&select_cotizacion_moneda="+moneda+"&select_cotizacion_especial="+cotEspecial
                    +"&select_cotizacion_presupuesto_valido="+presupuestoValido+"&select_cotizacion_plazo_entrega="+plazoEntrega
                    +"&select_cotizacion_condicion_pago="+condicionesPago+"&txt_cotizacion_rutcli="+rutCli
                +"&txt_cotizacion_cli="+nombreCli+"&sequencia="+sequence+"&fecha_desde=&fecha_hasta"+"&estado="+"Aprobada",
            type : 'POST',
            dataType : "html",
            success : function(data) {
                $("#btn_cotazacioncial_grabar").hide();
                $("#btn_cotizacion_aprobar").hide();
                
                var creaOT=confirm("Desea crear las OT para esta cotizaci\u00F3n");
                
                if(creaOT){
                    
                }else{
                    alert("Cotizacion Aprobada");
                }
            }
        });
    }
}

function ModificaActComercial(id)
{
    desmarca_registro_actividadComercial();
    if($("#habilitaActCom").val() == 0)
    {
        $("#filaTablaActComercial"+id).css("background-color","#58FAF4").removeClass("alt");        
        $("#habilitaActCom").val("1");
        var neg =  $("#secuencia"+id).text();        
        var caso = $("#ActCom_Caso"+id).text();
        var estado=$("#estado"+id).text();
        if($("#ActCom_estadoCierre"+id).text() == "DE")
        {
            $("#btn_actComercial_Modifica").hide();
        }
        
        if(estado=="Aprobada"){
            $("#btn_actComercial_Modifica").hide();
        }else{
            $("#btn_actComercial_Modifica").show();
        }
        
        $("#corrCotiza").val(neg);
        $("#caso").val(caso);
    }
}
function desmarca_registro_actividadComercial()
{
    $("#corrCotiza").val("");
    var td = $('#tblActComercial').children('tbody').children('tr').length;           
    for(var i = 0; i<=td;i++)
    {                
        if(i % 2 === 0)
        {
            $("#filaTablaActComercial"+i).addClass("alt");
        }
        if(i % 2 != 0)
        {                    
            $("#filaTablaActComercial"+i).css("background-color","white");
        }
    }
    $("#btn_actComercial_Modifica").show();
    $("#habilitaActCom").val("0");
}

function pad(n, width, z) {
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function filtraClientes(){
    var rut=$("#txt_filtro_cliente_rut").val();
    var nombre=$("#txt_filtro_cliente_nombre").val();
    $.ajax({
        url : 'ServletSPCliente', 
        data : "mod=select_all"+"&txt_cliente_codigo="+"&txt_cliente_rut="+rut+"&txt_cliente_nombre="+nombre
                       +"&txt_sigla_cliente="+"&txt_cliente_direccion="+"&txt_cliente_comuna="
                       +"&txt_cliente_ciudad="+"&txt_cliente_fono1="+"&txt_cliente_fono2="
                       +"&txt_cliente_fax="+"&txt_cliente_rubro="+"&txt_cliente_contacto="
                       +"&txt_cliente_casilla="+"&txt_cliente_ejecutivo="+"&txt_cliente_estado=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#select_cliente_filter").html(data);
        }
    });
}