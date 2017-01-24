<%-- 
    Document   : svm_Actualiza_Factura
    Created on : 23-06-2016, 15:47:57
    Author     : Ivan
    Modificacion : Yethro Villalon
--%>

<%@page import="java.sql.Types"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ingreso Factura</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css"/>
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
<link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="css/bootstrap-3.3.5.min.css">
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.js" /></script>
<script type="text/javascript" src="js/bootstrap-3.3.5.min.js" /></script>
<script type="text/javascript" src="js/jquery.validate-1.14.0.min.js" /></script>
<script type="text/javascript" src="js/jquery-validate.bootstrap-tooltip.js" /></script>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/CRUD_factura.js" type="text/javascript"></script>
<script type="text/javascript">
$( function() {
    $("#theform").validate({
        rules: {
            txt_factura_fecha: {
                required: true
            },
            slt_factura_formaPago: {
                required: true
            },
            slt_factura_excenta: {
                required: true
            },
            select_factura_adicional: {
                required: true
            },
            txt_factura_rutcli: {
                required: true
            }
        },
        tooltip_options: {
            slt_factura_formaPago: {
                trigger: 'focus'
            },
            slt_factura_excenta: {
                trigger: 'focus'
            },
            select_factura_adicional: {
                trigger: 'focus'
            }
        },
        showErrors: function(errorMap, errorList) {

            // Limpia cualquier tooltips para elementos válidos
            $.each(this.validElements(), function (index, element) {
                var $element = $(element);

                $element.data("title", "") // Borrar el título - ya no hay ningún error asociado
                    .removeClass("error")
                    .tooltip("destroy");
            });

            // Crear nuevas sugerencias para elementos no válidos
            $.each(errorList, function (index, error) {
                var $element = $(error.element);

                $element.tooltip("destroy") // Destruye cualquier información de herramientas preexistente para que podamos repoblar con nuevo contenido de información sobre herramientas
                    .data("title", error.message)
                    .addClass("error")
                    .tooltip(); // Crear una nueva información sobre herramientas basada en el mensaje de error que acabamos de establecer en el título
            });
        },
        submitHandler: function(form) {
            grabar();
        }
    });
    
    $( "#dialog_guias" ).dialog({
        modal: true,
        width: 600,
        height:400,
        autoOpen: false,
        buttons: {
            Seleccionar: function() {
                CargaTMPGD();
                $( this ).dialog( "close" );                
            },
            Cancelar: function() {
                $( this ).dialog("close");
            }
        },
        open: function( event, ui ) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            $("#txt_factura_filtro_guia").val("");
            cargaGuiasI();
        }
    });
    
    $( "#dialog_clientes" ).dialog({
        modal: true,
        width: 600,
        height:420,
        autoOpen: false,
        buttons: {
            Seleccionar: function() {
                $("#tblGuiaDespTMP").children("tbody").children("tr").remove();
                $("#tblDetalleFactura").children("tbody").children("tr").remove();
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
});
</script>
<%
    HttpSession s = request.getSession();
    Connection _connMy = null;
    CallableStatement sp_usu = null;
    try
    {
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
    }catch(Exception e)
    {
        out.println("Error:" + e.getMessage());
    }
    
    CallableStatement cStmt = _connMy.prepareCall("{? = call fn_secuencia()}");
    cStmt.registerOutParameter(1,java.sql.Types.VARCHAR);
    cStmt.execute();
    String secuencia = cStmt.getString(1);
%>
</head>
<body id="principal">
<form id="theform" action="" method="post" class="formularioIngresar">
    <table id="header">
        <tr>
            <td>
                    <table >
                        <tr>
                            <td colspan =" 2" >DATOS FACTURA<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                            <td>&nbsp;</td>
                            <td colspan = "2">DATOS CLIENTES<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>                            
                        </tr>
                        <tr>
                            <td>N° Factura:</td>                            
                            <td>                                    
                                <input type="text" value="0" disabled= "disabled" id="txt_factura_numero" maxlength="19" name="txt_factura_numero" />
                            </td> 
                            <td></td>
                            <td>Rut:</td>
                            <td><input type="text" id="txt_factura_rutcli" maxlength="11" name="txt_factura_rutcli" value="" readonly="readonly"/>
                                <input class = "botonera" style="width: 70px" type="button" name="btnClientes" id="btnClientes" value="Clientes" onClick="loadDialogClientes()" />
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha factura:</td>
                            <td>
                                <input type = "text" name = "txt_factura_fecha" readonly id= "txt_factura_fecha"  value="" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador"/>
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({
                                        inputField     :    "txt_factura_fecha",     // id del campo de texto 
                                        ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                        button     :    "lanzador"     // el id del boton que lanzará el calendario 
                                    });
                                </script>	
                            </td>
                            <td></td>
                            <td>Nombre</td>
                            <td rowspan="3">
                                <textarea rows="3" cols="27" id="txt_factura_cli" readonly="readonly">
                                 </textarea>                                
                            </td>                            
                        </tr>
                        <tr>
                            <td>Forma de Pago:</td>
                            <td>
                                <select name = "slt_factura_formaPago" id= "slt_factura_formaPago" >
                                    <option value="">Seleccione...</option>
                                    <%
                                        Statement stmt2 = _connMy.createStatement();
                                        String q2="select descripcion from svm_mae_tablas where tablas='Condiciones_Pago'";
                                        final ResultSet rsQuery2 = stmt2.executeQuery(q2);
                                        while(rsQuery2.next())
                                        {
                                            out.println("<option value='"+rsQuery2.getString("descripcion")+"'>"+rsQuery2.getString("descripcion")+"</option>");
                                        }
                                    %>
                                </select>
                            </td>                            
                        </tr>
                        <tr>
                            <td>Excenta:</td>
                            <td><select name="slt_factura_excenta" id="slt_factura_excenta">
                                    <option value="">Seleccione...</option>
                                    <option value="S">S</option>
                                    <option value="N">N</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Adicional:</td>
                            <td><select name="select_factura_adicional" id="select_factura_adicional">
                                    <option value="">Seleccione...</option>
                                    <%
                                        Statement stmt = _connMy.createStatement();
                                        String q="select descripcion from svm_mae_tablas where tablas='Adicional'";
                                        ResultSet rsQuery = stmt.executeQuery(q);
                                        while(rsQuery.next())
                                        {
                                            out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                        }   
                                    %>
                                </select>                                                        
                        </tr>                       
                        <tr>
                            <td>Comentarios:</td>
                            <td colspan="3">
                                <textarea rows="3" cols="27" id="txt_factura_comentario"  class="required"></textarea>
                            </td>
                        </tr>
                    </table>
                
            </td>
            <td>
                <div id="alineacionEstados" >
                    <div class="etiqueta" >
                        <center><label><b>Historial de Estados</b></label></center>
                    </div>
                    <div class="grillaConf">
                        <table>
                            <thead>
                                <tr>
                                    <th>Estado Anterior</th>
                                    <th>Estado Siguiente</th>
                                    <th>Fecha</th>                                    
                                    <th>Rut Usuario</th>                                    
                                    <th>Nombre Usuario</th>
                                </tr>
                            </thead>				
                            <tbody>      
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>      
        <tr>
            <td>
                <table>
                    <tr>
                        <td id='margen'>
                            <center>GUIAS DE DESPACHO</center>
                            <hr style="margin-bottom: 4px;margin-top: 4px;"/>
                        </td>
                    </tr>
                    <tr>                        
                        <td>
                            <div class="gridConf">
                                <table id="tblGuiaDespTMP">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>N° Guia de Despacho</th>
                                            <th>Fecha de Emision</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </td>
                        <td>
                            <input type="button" class="botonera" style="width: 130px" name="btnTmpGD" id="btnTmpGD" value="Guias de Despacho" onclick="loadDialogGuias()" /> <br/>
                            <a href="javascript: onclick= eliminaGD();"><img style="display:none" id="eliminaGD" src="images/logotipos/eliminar.png" width="30px" height="30px" style="margin-top: 30px;"/></a><br/>
                            <input type="button" class="botonera" style="width: 130px; display:none" name="btnCancelarGD" id="btnCancelarGD" value="Cancelar" onclick="desSeleccionGD(1)" /> 
                            <input type="hidden" id="guiaDespachoHid" />
                        </td>
                    </tr>
                    <tr>
                        <td id='margen' colspan="2">
                            <center>DETALLE DE FACTURA</center>
                            <hr style="margin-bottom: 4px;margin-top: 4px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="gridConf">
                                <table id="tblDetalleFactura">
                                    <thead>
                                        <tr>                                            
                                            <th>N° Guia de Despacho</th>
                                            <th>Descripcion</th>
                                            <th>Valor Unitario</th>
                                            <th>Cantidad</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>                            
                        </td>
                    </tr>
                </table>
            </td>            
        </tr>
    </table>
<input class ="botonera" type="submit" id="btn_cotazacioncial_grabar" name="btn_cotazacioncial_grabar" value="Grabar"/>
<input class = "botonera" type="button" name="btnCancela" value="Cancelar" onClick="goBack()" />
</form>          




<div id="dialog_guias" title="Guias" style="display:none;">
    <div id="contenido_guia">
       Numero de Guia:&nbsp;&nbsp;
       <input type="text" maxlength="11" id="txt_factura_filtro_guia" name="txt_factura_filtro_guia" />
       &nbsp;&nbsp;&nbsp;
       <input style="font-size:12px; height: 23px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Guias" onclick="cargaGuiasI()" />
       <br/>
       <br/>
       <div class="gridConf">
            <table id="tblGuiaDespSelec">
                <thead>
                    <tr>
                        <th><input type="checkbox" name="chkbox" id="select_all" onchange="selectAllchk();" /></th>
                        <th>N° Guia de Despacho</th>
                        <th>Fecha de Emision</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>
        
        
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
    <input type="hidden" value="<%out.print(secuencia);%>" id="secuencia" name="secuencia" />
</body>
</html>
