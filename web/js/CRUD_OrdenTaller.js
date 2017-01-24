/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function grabarOrdenTaller() {
    var numeroOrden = $("#txt_orden_numero").val();
    var numeroCotizacion = $("#txt_cotizacion_numero").val();
    var fechaEmision2 = $("#txt_orden_fecha").val();
    var fechaDespacho = $("#txt_orden_fecha_desp").val();
    var fechaTermino = $("#txt_orden_fecha_term").val();
    var detalle = $("#txt_detalle").val();
    var numeroFactura = $("#txt_factura_numero").val();
    var numeroGuia = $("#txt_guia_despacho").val();
    var especial = $("#select_especial").val();
    var aceptaCon = $("#txt_acepta_con").val();
    var rutCli = $("#txt_rutcli").val();
    var estado = $("#select_estado").val();
    var sequence = getUrlParameter('secuencia');
    var accion = getUrlParameter('accion');
    
    var dia=fechaEmision2.substring(0, 2);
    var mes=fechaEmision2.substring(3, 5);
    var year=fechaEmision2.substring(6, 10);
    
    var fechaEmision = year + "-" + mes + "-" + dia;
    
    if ($("#txt_rutcli").val() == "") {
        FuncionErrores(19);
        $("#txt_rutcli").focus();
        return false;
    }
    
    if ($("#select_especial").val() == -1) {
        FuncionErrores(24);
        $("#select_especial").focus();
        return false;
    }       

    if ($("#txt_cotizacion_numero").val() == "") {
        FuncionErrores(24);
        $("#txt_cotizacion_numero").focus();
        return false;
    } 
    
    if ($("#txt_detalle").val() == "") {
        FuncionErrores(24);
        $("#txt_detalle").focus();
        return false;
    } 
    if (accion == "modifica" || numeroOrden != "") {
        accion = "update";
    } else {
        accion = "insert";
    }
    
    $.ajax({
        url: 'ServletSPOrdenTaller',
        data: "opcion=" + accion + "&txt_orden_numero=" + numeroOrden + "&txt_ordentaller_fecha=" + fechaEmision
                + "&txt_cotizacion_numero=" + numeroCotizacion
                + "&txt_ordentaller_fechatermino=" + fechaTermino + "&txt_ordentaller_fechadespacho=" + fechaDespacho
                + "&txt_detalle=" + detalle + "&txt_factura_numero=" + numeroFactura + "&txt_guia_despacho=" + numeroGuia
                + "&txt_especial=" + especial + "&txt_acepta_con=" + aceptaCon + "&txt_rutcli=" + rutCli
                + "&select_estado=" + estado + "&sequencia=" + sequence + "&fecha_desde=&fecha_hasta"+"&estado=" + estado,
        type: 'POST',
        dataType: "html",
        success: function (data) {
            $("#txt_orden_numero").val(data);
            ingresaDetalleOT();
            location.href="svm_Seleccion_OT.jsp";
        }
    });
}
function filtraOrdenTaller() {
    var numeroOrden = $("#txt_orden_numero").val();
    var numeroCotizacion = $("#txt_cotizacion_numero").val();
    var fechaEmision = $("#txt_cotizacion_fecha").val();
    var atencion = $("#txt_cotizacion_atencion").val();
    var emitidaPor = $("#slt_filtroComercial_ejecutivo").val();
    var moneda = $("#select_cotizacion_moneda").val();
    var cotEspecial = $("#select_cotizacion_especial").val();


    var rutCli = $("#txt_cotizacion_rutcli").val();
    var nombreCli = $("#txt_cotizacion_cli").val();

    var desde = $("#txt_filtroComercial_ingreso").val();
    var hasta = $("#txt_filtroComercial_final").val();
    
    var diaDesde=desde.substring(0, 2);
    var mesDesde=desde.substring(3, 5);
    var yearDesde=desde.substring(6, 10);
    
    var filtroDesde = yearDesde + "-" + mesDesde + "-" + diaDesde;
    
    var diaHasta=hasta.substring(0, 2);
    var mesHasta=hasta.substring(3, 5);
    var yearHasta=hasta.substring(6, 10);
    
    var filtroHasta = yearHasta + "-" + mesHasta + "-" + diaHasta;    

    var sequence = getUrlParameter('secuencia');
    var accion = getUrlParameter('accion');

    var estado = $("#slt_filtroComercial_estado").val() == "" ? "X_X" : $("#slt_filtroComercial_estado").val();

    $.ajax({
        url: 'ServletSPOrdenTaller',
                data: "opcion=select_all" + "&txt_orden_numero=0" + "&txt_ordentaller_fecha="
                + "&txt_cotizacion_numero=0"
                + "&txt_ordentaller_fechatermino=0" + "&txt_ordentaller_fechadespacho=0" + 
                + "&txt_detalle=0" + "&txt_factura_numero=0" + "&txt_guia_despacho=0" + 
                + "&txt_especial=0" + "&txt_acepta_con=0" + "&txt_rutcli=0" + 
                + "&select_estado=0" + "&sequencia=" + sequence + "&fecha_desde=" + filtroDesde + "&fecha_hasta="+ filtroHasta +"&estado=" + estado,
        type: 'POST',
        dataType: "html",
        success: function (data) {
            $('#tblOrdenTaller').dataTable().fnDestroy();
            $("#tblOrdenTaller").find("tbody").html(data);
            $('#tblOrdenTaller').dataTable({//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
                "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
                bFilter: false, bInfo: false,
                "bLengthChange": false,
                 "bAutoWidth": false,
                "aoColumnDefs": [{'bSortable': false, 'aTargets': [1, 2, 3, 4, 5, 6] }]
            });
        }
    });
}

function ModificaOrdenTaller(id)
{   
    desmarca_registro_ordentaller();
    if($("#habilitaActCom").val() == 0)
    {
        $("#filaTablaOrdenTaller"+id).css("background-color","#58FAF4").removeClass("alt");        
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
        
        $("#corrOT").val(neg);
        $("#caso").val(caso);
    }
}

function desmarca_registro_ordentaller()
{
    $("#corrOT").val("");
    var td = $('#tblOrdenTaller').children('tbody').children('tr').length;           

    for(var i = 0; i<=td;i++)
    {                
        if(i % 2 === 0)
        {
            $("#filaTablaOrdenTaller"+i).addClass("alt");
        }
        if(i % 2 != 0)
        {                    
            $("#filaTablaOrdenTaller"+i).css("background-color","white");
        }
    }
    $("#btn_actComercial_Modifica").show();
    $("#habilitaActCom").val("0");
}

function cargaOrdenTaller(){
    var desde =$("#txt_filtroComercial_ingreso").val();
    var hasta =$("#txt_filtroComercial_final").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');
 
    var date = new Date();
    var dd=("0" + date.getDate()).slice(-2)
    var mm=("0" + (date.getMonth() + 1)).slice(-2);
    var yy=date.getFullYear();
    
    var fecha=dd+"-"+mm+"-"+yy;
    
    $.ajax({
        url : 'ServletSPOrdenTaller', 
        data: "opcion=select"+"&txt_orden_numero=0"+"&txt_ordentaller_fecha="+fecha
                +"&txt_cotizacion_numero=0"
                + "&txt_ordentaller_fechatermino=0" + "&txt_ordentaller_fechadespacho=0"
                + "&txt_detalle=" + "&txt_factura_numero=0" + "&txt_guia_despacho=0"
                + "&txt_especial=" + "&txt_acepta_con=" + "&txt_rutcli=0"
                + "&select_estado=0" + "&sequencia=" + sequence + "&fecha_desde=&fecha_hasta"+"&estado=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            var arrResult=data.split("|");
            
            if(accion=="consulta"){
                $("#btn_ordentaller_grabar").hide();
                $("#btnClientes").hide();
                $("#lanzador").hide();
                $("#txt_orden_fecha").attr("readonly","readonly");
                $("#select_especial").prop("disabled",true);
                $("#txt_rutcli").attr("readonly","readonly");
                $("#txt_cliente").attr("readonly","readonly");
                $("#txt_acepta_con").attr("readonly","readonly");
                $("#txt_cotizacion_numero").attr("readonly","readonly");
                $("#txt_detalle").attr("readonly","readonly");
            }
                       
            if(accion=="modifica" || accion=="consulta") {
                var dia=arrResult[2].substring(8, 10);
                var mes=arrResult[2].substring(5, 7);
                var year=arrResult[2].substring(0, 4);
                var fechaOrden = dia + "-" + mes + "-" + year;                
                $("#txt_orden_fecha").val(fechaOrden);
            }            
            else {
                $("#txt_orden_fecha").val(arrResult[2]);
            }                       
                       
            $("#txt_orden_numero").val(arrResult[0]);
            $("#txt_cotizacion_numero").val(arrResult[1]);
            if (arrResult[11] == "1900-01-01") {
                $("#txt_orden_fecha_desp").val("");
            }
            else {
                $("#txt_orden_fecha_desp").val(arrResult[11]);
            }
            if (arrResult[10] == "1900-01-01") {
                $("#txt_orden_fecha_term").val("");
            }
            else {
                $("#txt_orden_fecha_term").val(arrResult[10]);
            }
            $("#txt_factura_numero").val(arrResult[7]);
            $("#txt_detalle").val(arrResult[9]);            
            $("#txt_guia_despacho").val(arrResult[8]);
            $("#select_especial").val(arrResult[12]);
            $("#txt_acepta_con").val(arrResult[13]);            
            $("#txt_rutcli").val(arrResult[5]);            
            $("#txt_cliente").val(arrResult[6]);                        
            
            if($("#txt_orden_fecha").val()==""){
                $("#txt_orden_fecha").val(fecha);
            }
            cargaDetalleOT();
        }
    });
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
