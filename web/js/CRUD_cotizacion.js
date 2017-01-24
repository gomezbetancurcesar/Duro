function grabarCotizacion(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision2=$("#txt_cotizacion_fecha").val();
    var emitidaPor=$("#txt_cotizacion_emitida_por").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    var fechaCompromiso2=$("#txt_cotizacion_fechacom").val();
    var sequence =getUrlParameter('secuencia');
    
    var accion=getUrlParameter('accion');
    
    var dia=fechaEmision2.substring(0, 2);
    var mes=fechaEmision2.substring(3, 5);
    var year=fechaEmision2.substring(6, 10);
    
    var fechaEmision = year + "-" + mes + "-" + dia;
    
    dia=fechaCompromiso2.substring(0, 2);
    mes=fechaCompromiso2.substring(3, 5);
    year=fechaCompromiso2.substring(6, 10);
    
    var fechaCompromiso = year + "-" + mes + "-" + dia;
    
    if ($("#txt_cotizacion_rutcli").val() == "") {
        FuncionErrores(19);
        $("#txt_cotizacion_rutcli").focus();
        return false;
    }
    
    if ($("#txt_cotizacion_cli").val() == "") {
        FuncionErrores(20);
        $("#txt_cotizacion_cli").focus();
        return false;
    }    
    
    if ($("#txt_cotizacion_emitida_por").val() == "") {
        FuncionErrores(22);
        $("#txt_cotizacion_emitida_por").focus();
        return false;
    }  
    
    if ($("#select_cotizacion_presupuesto_valido").val() == "") {
        FuncionErrores(25);
        $("#select_cotizacion_presupuesto_valido").focus();
        return false;
    }     
    
    if ($("#select_cotizacion_plazo_entrega").val() == "") {
        FuncionErrores(26);
        $("#select_cotizacion_plazo_entrega").focus();
        return false;
    }    
    
    if ($("#select_cotizacion_condicion_pago").val() == "") {
        FuncionErrores(27);
        $("#select_cotizacion_condicion_pago").focus();
        return false;
    }     
    
    if ($("#cantidad_detalle").val() == "0") {
        FuncionErrores(39);
        $("#select_cotizacion_pieza").focus();
        return false;
    }         

    if ($("#txt_cotizacion_fechacom").val() == "") {
        FuncionErrores(19);
        $("#txt_cotizacion_fechacom").focus();
        return false;
    }

    if(accion=="modifica"||numeroCotizacion!=""){
        accion="update";
    }else{
        accion="insert";
    }
    
    $.ajax({
        url : 'ServletSPCotizacion', 
        data: "opcion="+accion+"&txt_cotizacion_numero="+numeroCotizacion+"&txt_cotizacion_fecha="+fechaEmision
                +"&txt_cotizacion_emitida_por="+emitidaPor+"&txt_cotizacion_fechacom="+fechaCompromiso
                +"&select_cotizacion_presupuesto_valido="+presupuestoValido+"&select_cotizacion_plazo_entrega="+plazoEntrega
                +"&select_cotizacion_condicion_pago="+condicionesPago+"&txt_cotizacion_rutcli="+rutCli
                +"&txt_cotizacion_cli="+nombreCli+"&sequencia="+sequence+"&fecha_desde=&fecha_hasta"+"&estado=Ingresada",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#txt_cotizacion_numero").val(data);
            asociaDetalle();
            guardaDetalle();
            location.href="svm_Seleccion_Cotizacion.jsp";
        }
    });
}

function cargaCotizacion(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision=$("#txt_cotizacion_fecha").val();
    
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
    
    var fecha=dd+"-"+mm+"-"+yy;
    
    $.ajax({
        url : 'ServletSPCotizacion', 
        data: "opcion=select"+"&txt_cotizacion_numero=0"+"&txt_cotizacion_fecha="+fecha
                +"&txt_cotizacion_emitida_por=0"+"&txt_cotizacion_fechacom="+fecha
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
                $("#SubDetalleIngreso").hide();
                $("#btnClientes").hide();
                $("#lanzador").hide();
                $("#lanzador2").hide();
                $("#btnPiezas").hide();
                $("#txt_cotizacion_rutcli").attr("readonly","readonly");
                $("#txt_cotizacion_cli").attr("readonly","readonly");
                $("#txt_cotizacion_cantidad").attr("readonly","readonly");
                $("#txt_cotizacion_dm").attr("readonly","readonly");
                $("#txt_cotizacion_diametro").attr("readonly","readonly");
                $("#txt_cotizacion_largo").attr("readonly","readonly");
                $("#txt_cotizacion_valUniCrom").attr("readonly","readonly");
                $("#txt_cotizacion_cHora").attr("readonly","readonly");
                $("#txt_cotizacion_cantHrs").attr("readonly","readonly");
                $("#txt_cotizacion_valor").attr("readonly","readonly");
                $("#txt_cotizacion_margen").attr("readonly","readonly");
                $("#txt_cotizacion_emitida_por").prop("disabled",true);
                $("#select_cotizacion_presupuesto_valido").prop("disabled",true);
                $("#select_cotizacion_plazo_entrega").prop("disabled",true);
                $("#select_cotizacion_condicion_pago").prop("disabled",true);
                $("#select_cotizacion_pieza").prop("disabled",true);
                var dia=arrResult[1].substring(8, 10);
                var mes=arrResult[1].substring(5, 7);
                var year=arrResult[1].substring(0, 4);
                var fechaCoti = dia + "-" + mes + "-" + year;                
                $("#txt_cotizacion_fecha").val(fechaCoti);
                dia=arrResult[8].substring(8, 10);
                mes=arrResult[8].substring(5, 7);
                year=arrResult[8].substring(0, 4);
                var fechaComp = dia + "-" + mes + "-" + year;                
                $("#txt_cotizacion_fechacom").val(fechaComp);                
            }
            
            if(accion=="modifica") {
                var dia=arrResult[1].substring(8, 10);
                var mes=arrResult[1].substring(5, 7);
                var year=arrResult[1].substring(0, 4);
                var fechaCoti = dia + "-" + mes + "-" + year;                
                $("#txt_cotizacion_fecha").val(fechaCoti);
                dia=arrResult[8].substring(8, 10);
                mes=arrResult[8].substring(5, 7);
                year=arrResult[8].substring(0, 4);
                var fechaComp = dia + "-" + mes + "-" + year;                
                $("#txt_cotizacion_fechacom").val(fechaComp);                  
            }            
            else {
                //$("#txt_cotizacion_fecha").val(arrResult[1]);
            }

            $("#txt_cotizacion_numero").val(arrResult[0]);
            $("#txt_cotizacion_emitida_por").val(arrResult[2]);
            $("#select_cotizacion_presupuesto_valido").val(arrResult[3]);
            $("#select_cotizacion_plazo_entrega").val(arrResult[4]);
            $("#select_cotizacion_condicion_pago").val(arrResult[5]);
            $("#txt_cotizacion_rutcli").val(arrResult[6]);
            $("#txt_cotizacion_cli").val(arrResult[7]);           
            
            if($("#txt_cotizacion_fecha").val()==""){
                $("#txt_cotizacion_fecha").val(fecha);
                $("#btn_cotizacion_aprobar").hide();
            }
            $("#SubDetalleIngreso").hide();
            CargaSubDetModifica();
        }
    });
}

function filtraCotizacion(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision=$("#txt_cotizacion_fecha").val();
    var emitidaPor=$("#slt_filtroComercial_ejecutivo").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    
    var desde =$("#txt_filtroComercial_ingreso").val();
    var hasta =$("#txt_filtroComercial_final").val();
    
    var diaDesde=desde.substring(0, 2);
    var mesDesde=desde.substring(3, 5);
    var yearDesde=desde.substring(6, 10);
    
    var filtroDesde = yearDesde + "-" + mesDesde + "-" + diaDesde;
    
    var diaHasta=hasta.substring(0, 2);
    var mesHasta=hasta.substring(3, 5);
    var yearHasta=hasta.substring(6, 10);
    
    var filtroHasta = yearHasta + "-" + mesHasta + "-" + diaHasta;
    
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');
    
    var estado=$("#slt_filtroComercial_estado").val()== "" ? "X_X" : $("#slt_filtroComercial_estado").val();
    
    $.ajax({
        url : 'ServletSPCotizacion', 
        data: "opcion=select_all"+"&txt_cotizacion_numero=0"+"&txt_cotizacion_fecha=2016-04-04"
                +"&txt_cotizacion_emitida_por="+emitidaPor+"&txt_cotizacion_fechacom=2016-04-04"
                +"&select_cotizacion_presupuesto_valido=0"+"&select_cotizacion_plazo_entrega=0"
                +"&select_cotizacion_condicion_pago=0"+"&txt_cotizacion_rutcli=0"
                +"&txt_cotizacion_cli=0"+"&sequencia="+sequence+"&fecha_desde="+filtroDesde+"&fecha_hasta="+filtroHasta
                +"&estado="+estado,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $('#tblActComercial').dataTable().fnDestroy(); 
            $("#tblActComercial").find("tbody").html(data);  
            $('#tblActComercial').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
                "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
                bFilter: false, bInfo: false,
                "bLengthChange": false,
                "bAutoWidth": false,
               "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7,8] }]
            });
            //$("#tblActComercial").find("tbody").html(data);  
        }
    });
}

function aprobarCotiza(){
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    var fechaEmision2=$("#txt_cotizacion_fecha").val();
    var emitidaPor=$("#txt_cotizacion_emitida_por").val();
    
    var presupuestoValido=$("#select_cotizacion_presupuesto_valido").val();
    var plazoEntrega=$("#select_cotizacion_plazo_entrega").val();
    var condicionesPago=$("#select_cotizacion_condicion_pago").val();
    
    var rutCli=$("#txt_cotizacion_rutcli").val();
    var nombreCli=$("#txt_cotizacion_cli").val();
    var fechaCompromiso2=$("#txt_cotizacion_fechacom").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion="modifica";
    
    var dia=fechaEmision2.substring(0, 2);
    var mes=fechaEmision2.substring(3, 5);
    var year=fechaEmision2.substring(6, 10);
    
    var fechaEmision = year + "-" + mes + "-" + dia;
    
    dia=fechaCompromiso2.substring(0, 2);
    mes=fechaCompromiso2.substring(3, 5);
    year=fechaCompromiso2.substring(6, 10);
    
    var fechaCompromiso = year + "-" + mes + "-" + dia;    
    
    if(accion=="modifica"){
        accion="update"
    }else{
        accion="insert";
    }
    
    if(confirm("Una vez aprobada la cotizacion no puede volver a modificarla")){
        $.ajax({
            url : 'ServletSPCotizacion', 
            data: "opcion="+accion+"&txt_cotizacion_numero="+numeroCotizacion+"&txt_cotizacion_fecha="+fechaEmision
                    +"&txt_cotizacion_emitida_por="+emitidaPor+"&txt_cotizacion_fechacom="+fechaCompromiso
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
                    GeneraOrdenTaller();
                    location.href="svm_Seleccion_Cotizacion.jsp";
                    
                }else{
                    alert("Cotizacion Aprobada");
                    
                }
            }
        });
    }
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

function ModificaActComercial(id)
{   
    desmarca_registro_ActComercial();
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

function desmarca_registro_ActComercial()
{
    $("#corrOT").val("");
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

function GeneraOrdenTaller()
{
    var numeroCotizacion=$("#txt_cotizacion_numero").val();
    $.ajax({
            url : 'ServletSPGeneraOT', 
            data: "txt_cotizacion_numero="+numeroCotizacion,
            type : 'POST',
            dataType : "html",
            success : function(data) {

            }
        });
}