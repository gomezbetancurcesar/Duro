<%-- 
    Document   : svm_gridguiasfactura
    Created on : 12-01-2017, 11:27:39
    Author     : YV
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAL.conexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
        <link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
        <link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
        <link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>
        <link href="css/calendario.css" type="text/css" rel="stylesheet" />
        <link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>
        <script src="js/calendar.js" type="text/javascript"></script>
        <script src="js/calendar-es.js" type="text/javascript"></script>
        <script src="js/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js" ></script>
        <script src="js/CRUD_factura.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#txt_nrofactura').keydown(function (e) {
                    // Allow: backspace, delete, tab, escape, enter and .
                    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                         // Allow: Ctrl+A, Command+A
                        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
                         // Allow: home, end, left, right, down, up
                        (e.keyCode >= 35 && e.keyCode <= 40)) {
                             // let it happen, don't do anything
                             return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });
                
                $( "#dialog_clientes" ).dialog({
                    modal: true,
                    width: 600,
                    height:420,
                    autoOpen: false,
                    buttons: {
                        Seleccionar: function() {
                            CargaClienteFactura();
                            $( this ).dialog( "close" );
                        },
                        Cancelar: function() {
                            $( this ).dialog("close");
                        }
                    },
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
                        $("#txt_filtro_cliente_rut").val("");
                        $("#txt_filtro_cliente_nombre").val("");
                        cargaClientes();
                    }
                });
                
                $( "#dialog_msg" ).dialog({
                    modal: true,
                    width: 350,
                    height: 200,
                    autoOpen: false,
                    buttons: {
                        Cerrar: function() {
                            $( this ).dialog("close");
                        }
                    },
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
                    }
                });
                
                $( "#btnFacturar" ).click(function() {
                    var fdesde = $("#txt_fechadesde").val();
                    var fhasta = $("#txt_fechahasta").val();
                    var cliente = $("#txt_factura_rutcli").val();
                    var nrofact = $("#txt_nrofactura").val();

                    if(fdesde == ""){
                        openDialog("Debe ingresar la fecha desde");
                        $("txt_fechadesde").focus();
                        return false;
                    }

                    if(fhasta == ""){
                        openDialog("Debe ingresar la fecha hasta");
                        $("txt_fechahasta").focus();
                        return false;
                    }

                    if(!(dateCheck(fdesde,fhasta))){
                        openDialog("La fecha desde debe ser menor a la fecha hasta");
                        return false;
                    }

                    if(cliente == ""){
                        openDialog("Debe seleccionar a un cliente");
                        $("txt_factura_rutcli").focus();
                        return false;
                    }                

                    if(nrofact == ""){
                        openDialog("Debe ingresar un numero de factura");
                        $("txt_nrofactura").focus();
                        return false;
                    }

                    var flag = "valnrofact";
                    $.ajax({
                        url : 'ServletFacturaGDtmp', 
                        data: "flag="+flag+"&nroFact="+nrofact,
                        type : 'POST',
                        dataType : "html",
                        success : function(data) {
                            if(data == "0"){
                                $("#theform").submit();
                            }else{
                                openDialog("El numero de factura ya existe");
                                $("txt_nrofactura").focus();
                                return false;
                            }
                        }
                    });
                });
                
                $('#btnSalir').click(function(){
                    parent.history.back();
                    return false;
                });
            });
            //dateCheck("02-07-2013","02-09-2013")
            function dateCheck(from,to) {

                var dateFrom = from.replace(/-|_/g,'/');
                var dateTo = to.replace(/-|_/g,'/');

                var d1 = dateFrom.split("/");
                var d2 = dateTo.split("/");

                var from = new Date(d1[2], parseInt(d1[1])-1, d1[0]);
                var to   = new Date(d2[2], parseInt(d2[1])-1, d2[0]);
                
                if(from <= to) {
                    return true;
                }
                return false;
            }
        </script>
        <title>Facturaci&oacute;n</title>
    </head>
    <body>
        <form id="theform" action="svm_gridguiasfactura.jsp" method="post" class="formularioIngresar">
            <table>
                <tr>
                    <td>Fecha Desde</td>
                    <td>
                        <input type = "text" id="txt_fechadesde" name="txt_fechadesde" readonly />
                        <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Desde" id="fechadesde"/>
                        <!-- script que define y configura el calendario--> 
                        <script type="text/javascript"> 
                            Calendar.setup({
                                inputField  : "txt_fechadesde",     // id del campo de texto 
                                ifFormat    : "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                button      : "fechadesde"     // el id del boton que lanzará el calendario 
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>Fecha Hasta</td>
                    <td>
                        <input type = "text" id="txt_fechahasta" name="txt_fechahasta" readonly />
                        <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Hasta" id="fechahasta"/>
                        <!-- script que define y configura el calendario--> 
                        <script type="text/javascript"> 
                            Calendar.setup({
                                inputField  : "txt_fechahasta",     // id del campo de texto 
                                ifFormat    : "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                button      : "fechahasta"     // el id del boton que lanzará el calendario 
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>Cliente</td>
                    <td>
                        <input type="text" id="txt_factura_rutcli" name="txt_factura_rutcli" value="" readonly="readonly"/>
                        <input class = "botonera" type="button" name="btnClientes" id="btnClientes" value="Clientes" onClick="loadDialogClientes()" />
                    </td>
                </tr>
                <tr>
                    <td>N&deg; Factura</td>
                    <td><input type="text" id="txt_nrofactura" name="txt_nrofactura" /> </td>
                </tr>
            </table>
            <div class="right">
                <input class ="botonera" type="button" id="btnFacturar" name="btnFacturar" value="Facturar" />
                <input class = "botonera" type="button" id ="btnSalir" name="btnSalir" value="Salir" />
            </div>
        </form>
        <div id="dialog_clientes" title="Clientes" style="display:none;" >
            <div id="contenido_clientes">
                <table width="100%">
                    <tr>
                        <td>Rut de cliente:</td>
                        <td><input type="text" style="width: 160px" id="txt_filtro_cliente_rut" name="txt_filtro_cliente_rut" /></td>
                        <td>&nbsp;&nbsp;<input style="font-size:12px; height: 23px; width: 120px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Clientes" onclick="cargaClientes()" /></td>
                    </tr>
                    <tr>
                        <td>Nombre de cliente</td>
                        <td><input type="text" style="width: 160px" id="txt_filtro_cliente_nombre" name="txt_filtro_cliente_nombre" /></td>
                        <td></td>
                    </tr>
                </table>
               <br/>
                <select size="10" style="width: 560px;" id="select_cliente_filter" name="select_cliente_filter">
                </select>
            </div>
        </div>
        <div id="dialog_msg" title="Mensaje" style="display:none;" ></div>
    </body>
</html>
