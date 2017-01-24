/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function grabarGuiaDespacho(){
    var numeroGuia=$("#txt_guiadespacho_numero").val();
    var numeroCotizacion=$("#txt_guiadespacho_cotizacion").val();
    var fechaEmision2=$("#txt_guiadespacho_fecha").val();
    var guiaEspecial=$("#select_guiadespacho_especial").val();
    var condicionesPago=$("#select_guiadespacho_condicion_pago").val();    
    var aceptoCot=$("#txt_guiadespacho_aceptoCOT").val();    
    var rutCli=$("#txt_guiadespacho_rutcli").val();
    var total=$("#txt_guiadespacho_total").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');    
    
    var dia=fechaEmision2.substring(0, 2);
    var mes=fechaEmision2.substring(3, 5);
    var year=fechaEmision2.substring(6, 10);    

    var fechaEmision = year + "-" + mes + "-" + dia;    
    
    if ($("#txt_guiadespacho_rutcli").val() == "") {
        FuncionErrores(19);
        $("#txt_guiadespacho_rutcli").focus();
        return false;
    }    
    
    if ($("#txt_guiadespacho_cotizacion").val() == "") {
        FuncionErrores(24);
        $("#txt_guiadespacho_cotizacion").focus();
        return false;
    }     
    
    if ($("#select_guiadespacho_condicion_pago").val() == -1) {
        FuncionErrores(24);
        $("#select_guiadespacho_condicion_pago").focus();
        return false;
    }       
    
    if ($("#txt_guiadespacho_aceptoCOT").val() == "") {
        FuncionErrores(24);
        $("#txt_guiadespacho_aceptoCOT").focus();
        return false;
    }     
    
    if ($("#select_guiadespacho_especial").val() == -1) {
        FuncionErrores(24);
        $("#select_guiadespacho_especial").focus();
        return false;
    }     
    
    if ($("#txt_guiadespacho_total").val() == "") {
        FuncionErrores(24);
        $("#txt_guiadespacho_total").focus();
        return false;
    }        
    
    if(accion=="modifica"||numeroGuia!=""){
        accion="update";
    }else{
        accion="insert";
    }
     $.ajax({
        url : 'ServletSPGuiaDespacho', 
        data: "opcion="+accion+"&txt_guiadespacho_numero="+numeroGuia+"&txt_cotizacion_numero="+numeroCotizacion
                +"&txt_guiadespacho_fecha="+fechaEmision+"&txt_guiadespacho_especial="+guiaEspecial
                +"&txt_guiadespacho_condicion_pago="+condicionesPago+"&txt_guiadespacho_rutcli="+rutCli
                +"&txt_guiadespacho_aceptoCOT="+aceptoCot+"&txt_guiadespacho_total="+total
                +"&sequencia="+sequence+"&fecha_desde=&fecha_hasta"+"&estado=Ingresada",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#txt_guiadespacho_numero").val(data);
            asociaDetalleGuia();
            guardaDetalleGuia();
            location.href="svm_Seleccion_GuiaDespacho.jsp";
        }
    });
}

function cargaGuiaDespacho(){
    var numeroGuia=$("#txt_guiadespacho_numero").val();
    var fechaEmision=$("#txt_guiadespacho_fecha").val();
    var cotizanumero=$("txt_guiadespacho_cotizacion").val();
    var condicionesPago=$("#select_guiadespacho_condicion_pago").val();    
    var aceptoCOT=$("txt_guiadespacho_aceptoCOT").val();
    var guiaEspecial=$("#select_guiadespacho_especial").val();
    var rutCli=$("#txt_guiadespacho_rutcli").val();
    var nombreCli=$("#txt_guiadespacho_cli").val();
    
    var desde =$("#txt_filtroGuia_ingreso").val();
    var hasta =$("#txt_filtroGuia_final").val();
    
    var sequence =getUrlParameter('secuencia');
    var accion=getUrlParameter('accion');
 
    var date = new Date();
    var dd=("0" + date.getDate()).slice(-2)
    var mm=("0" + (date.getMonth() + 1)).slice(-2);
    var yy=date.getFullYear();
    
    var fecha=dd+"-"+mm+"-"+yy;    
    
    $.ajax({
        url : 'ServletSPGuiaDespacho', 
        data: "opcion=select"+"&txt_guiadespacho_numero=0"+"&txt_guiadespacho_fecha="+fecha
                +"&txt_cotizacion_numero=0"+"&txt_guiadespacho_especial=0"+"&txt_guiadespacho_aceptoCOT=0"
                +"&txt_guiadespacho_condicion_pago=0"+"&txt_guiadespacho_rutcli=0"+"&txt_guiadespacho_total=0"
                +"&sequencia="+sequence+"&fecha_desde="+desde+"&fecha_hasta="+hasta+"&estado=",
        type : 'POST',
        dataType : "html",
        success : function(data) {
            var arrResult=data.split("|");
            
            if(accion=="consulta"){
                $("#btn_guiadespacho_grabar").hide();
                $("#DetalleIngreso").hide();
                $("#DetalleIngresoGuia").hide();
                $("#btn_guiadespacho_clientes").hide();
                $("#lanzador").hide();
                $("#txt_guiadespacho_cotizacion").attr("readonly","readonly");
                $("#select_guiadespacho_condicion_pago").prop("disabled",true);
                $("#txt_guiadespacho_aceptoCOT").attr("readonly","readonly");
                $("#select_guiadespacho_especial").prop("disabled",true);
                $("#txt_guiadespacho_rutcli").attr("readonly","readonly");
                $("#txt_guiadespacho_cli").attr("readonly","readonly");
                $("#txt_guiadespacho_numeroOT").attr("readonly","readonly");
                $("#txt_guiadespacho_itemnumero").attr("readonly","readonly");
                $("#txt_guiadespacho_total").attr("readonly","readonly");
                $("#txt_guiadespacho_cantidad").attr("readonly","readonly");
                $("#txt_guiadespacho_detalle").attr("readonly","readonly");
                $("#txt_guiadespacho_valor").attr("readonly","readonly");
                $("#txt_guiadespacho_totalitem").attr("readonly","readonly");
                
            }
            
            if (accion=="modifica" || accion=="consulta") {
                var dia=arrResult[1].substring(8, 10);
                var mes=arrResult[1].substring(5, 7);
                var year=arrResult[1].substring(0, 4);
                var fechaOrden = dia + "-" + mes + "-" + year;                
                $("#txt_guiadespacho_fecha").val(fechaOrden);
            }            
            else {
                $("#txt_guiadespacho_fecha").val(arrResult[1]);
            }   
            
            $("#txt_guiadespacho_numero").val(arrResult[0]);
            $("#txt_guiadespacho_rutcli").val(arrResult[2]);
            $("#txt_guiadespacho_cli").val(arrResult[3]);
            $("#txt_guiadespacho_cotizacion").val(arrResult[4]);
            $("#select_guiadespacho_especial").val(arrResult[5]);
            $("#select_guiadespacho_condicion_pago").val(arrResult[6]);            
            $("#txt_guiadespacho_aceptoCOT").val(arrResult[7]);
            $("#txt_guiadespacho_total").val(arrResult[8]);
            if($("#txt_guiadespacho_fecha").val()==""){
                $("#txt_guiadespacho_fecha").val(fecha);
            }
        }
    });
}

function filtraGuiaDespacho(){
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
    
    var desde =$("#txt_filtroGuia_ingreso").val();
    var hasta =$("#txt_filtroGuia_final").val();
    
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
        url : 'ServletSPGuiaDespacho', 
        data: "opcion=select_all"+"&txt_cotizacion_numero=0"+"&txt_guiadespacho_fecha=2016-04-04"+"&txt_guiadespacho_numero=0"
                +"&txt_guiadespacho_aceptoCOT=0"+"&txt_guiadespacho_especial=0"
                +"&txt_guiadespacho_total=0"+"&txt_guiadespacho_condicion_pago=0"+"&txt_guiadespacho_rutcli=0"
                +"&sequencia="+sequence+"&fecha_desde="+filtroDesde+"&fecha_hasta="+filtroHasta
                +"&estado="+estado,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $('#tblGuiaDespacho').dataTable().fnDestroy(); 
            $("#tblGuiaDespacho").find("tbody").html(data); 
            $('#tblGuiaDespacho').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
            "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
            bFilter: false, bInfo: false,
            "bLengthChange": false,
            "bAutoWidth": false,
            "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7] }]
            });
         }        
    });
}

function ModificaGuiaDespacho(id)
{
    desmarca_registro_guiaDespacho();
    if($("#habilitaGuiaDesp").val() == 0) {
    
    $("#filaTablaGuiaDespacho"+id).css("background-color","#58FAF4").removeClass("alt");            
       
    $("#habilitaGuiaDesp").val("1");
    var neg =  $("#secuencia"+id).text();        
    var caso = $("#ActCom_Caso"+id).text();
    var estado=$("#estado"+id).text();
      
    $("#corrGuia").val(neg);
    $("#caso").val(caso);
    }
}

function desmarca_registro_guiaDespacho()
{
    $("#corrGuia").val("");
    var td = $('#tblGuiaDespacho').children('tbody').children('tr').length;    
    for(var i = 0; i<=td;i++)
    {                
        if(i % 2 === 0)   {
            $("#filaTablaGuiaDespacho"+i).addClass("alt");
        }
        else {
            $("#filaTablaGuiaDespacho"+i).css("background-color","white");
        }
    }

    $("#btn_actComercial_Modifica").show();
    $("#habilitaGuiaDesp").val("0");
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