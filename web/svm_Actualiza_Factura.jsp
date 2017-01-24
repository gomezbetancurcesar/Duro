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
            grabarActualiza();
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
            cargaGuiasM();
        }
    });
    
    $( "#dialog_msg" ).dialog({
        modal: true,
        width: 350,
        height: 200,
        autoOpen: false,
        resizable: false,        
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
    //TipoUser, Rut y Nombre Ejecutivo PAra actualiza Actividad comercial.    
    HttpSession s = request.getSession();
    Connection _connMy = null;    
    CallableStatement sp_usu = null;
    String nomCli = "";
    String rutCli = "";
    String fechFactura = "";
    String formPago = "";
    String excenta = "";
    String adicional = "";
    String comentarios= "";
    String var = "";
    int nroFact = 0;
    String secuencia = "";
    nroFact = request.getParameter("nroFactura") != null ? Integer.parseInt(request.getParameter("nroFactura")) : 0;                       
    try {     
            _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
            var = "CONSULTA";
            ResultSet rs = null;
            sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
            sp_usu.setString(1,var);
            sp_usu.setInt(2,nroFact);
            sp_usu.setString(3,"");
            sp_usu.setString(4,"");
            sp_usu.setString(5,"");
            sp_usu.setString(6,"");
            sp_usu.setString(7,"");
            sp_usu.setString(8,"");
            sp_usu.setString(9,"");                               
            sp_usu.setInt(10,0);
            sp_usu.setInt(11,0);
            sp_usu.execute();

            rs = sp_usu.getResultSet();                                                    
            while(rs.next())
            {
                fechFactura=rs.getString("fecha_factura");
                excenta=rs.getString("exenta");
                adicional=rs.getString("adicional");
                formPago= rs.getString("forma_pago");
                comentarios = rs.getString("comentario");
                nomCli = rs.getString("cliente");
                rutCli = rs.getString("rutCli");
            }       
            
            var = "INGRESOTMPGUIAS";
            sp_usu = null;
            sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
            sp_usu.setString(1,var);
            sp_usu.setInt(2,nroFact);
            sp_usu.setString(3,"");
            sp_usu.setString(4,"");
            sp_usu.setString(5,"");
            sp_usu.setString(6,"");
            sp_usu.setString(7,"");
            sp_usu.setString(8,"");
            sp_usu.setString(9,"");                               
            sp_usu.setInt(10,0);
            sp_usu.setInt(11,0);
            sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
            sp_usu.execute();
            secuencia = sp_usu.getString(1);
        } catch (Exception e) {
            System.out.println("Error:"+e.getMessage());
        }          
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
                                <input type="text" value="<%=nroFact%>" disabled= "disabled" id="txt_factura_numero" maxlength="19" name="txt_factura_numero" />
                            </td> 
                            <td></td>
                            <td>Rut:</td>
                            <td><input type="text" id="txt_factura_rutcli" maxlength="11" name="txt_factura_rutcli" value="<%=rutCli%>" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha factura:</td>
                            <td>
                                <input type = "text" name = "txt_factura_fecha" readonly id= "txt_factura_fecha"  value="<%=fechFactura%>" size="12" />
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
                                <textarea rows="3" cols="27" id="txt_factura_cli" disabled="disabled"><%=nomCli%>
                                 </textarea>                                
                            </td>                            
                        </tr>
                        <tr>
                            <td>Forma de Pago:</td>
                            <td>
                                <select id="slt_factura_formaPago" name="slt_factura_formaPago">
                                    <option value="">Seleccione...</option>
                                    <%
                                        Statement stmt2 = _connMy.createStatement();
                                        String q2="select descripcion from svm_mae_tablas where tablas='Condiciones_Pago'";
                                        final ResultSet rsQuery2 = stmt2.executeQuery(q2);
                                        while(rsQuery2.next())
                                        {
                                            if(formPago.equals(rsQuery2.getString("descripcion"))){
                                                out.println("<option value='"+rsQuery2.getString("descripcion")+"' selected>"+rsQuery2.getString("descripcion")+"</option>");
                                            }else{
                                                out.println("<option value='"+rsQuery2.getString("descripcion")+"'>"+rsQuery2.getString("descripcion")+"</option>");
                                            }
                                        }
                                    %>
                                </select>
                            </td>                            
                        </tr>
                        <tr>
                            <td>Excenta:</td>
                            <td><select id="slt_factura_excenta" name="slt_factura_excenta" >
                                    <option value="">Seleccione...</option>
                                    <%
                                        Statement stmt3 = _connMy.createStatement();
                                        String q3="select valor from svm_mae_parametros where tipo='EXCENTA'";
                                        final ResultSet rsQuery3 = stmt2.executeQuery(q3);
                                        while(rsQuery3.next())
                                        {
                                            if(excenta.equals(rsQuery3.getString("valor"))){
                                                out.println("<option value='"+rsQuery3.getString("valor")+"' selected>"+rsQuery3.getString("valor")+"</option>");
                                            }else{
                                                out.println("<option value='"+rsQuery3.getString("valor")+"'>"+rsQuery3.getString("valor")+"</option>");
                                            }
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Adicional:</td>
                            <td><select id="select_factura_adicional" name="select_factura_adicional" >
                                    <option value="">Seleccione...</option>
                                    <%
                                        Statement stmt = _connMy.createStatement();
                                        String q="select descripcion from svm_mae_tablas where tablas='Adicional'";
                                        ResultSet rsQuery = stmt.executeQuery(q);
                                        while(rsQuery.next())
                                        {
                                            if(adicional.equals(rsQuery.getString("descripcion"))){
                                                out.println("<option value='"+rsQuery.getString("descripcion")+"' selected>"+rsQuery.getString("descripcion")+"</option>");
                                            }else{
                                                out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                            }
                                        }   
                                    %>
                                </select>                                                        
                        </tr>                       
                        <tr>
                            <td>Comentarios:</td>
                            <td colspan="3">
                                <textarea rows="3" cols="27" id="txt_factura_comentario" class="required"><%=comentarios%></textarea>
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
                                    <tbody>
                                        <%
                                            stmt = null;
                                            stmt = _connMy.createStatement();
                                            q= "";
                                            q="SELECT  "
                                                + "DISTINCT GDCAB.numero_guia AS numero_guia, "
                                                + "GDCAB.fecha_emision AS fecha_emision, "
                                                + "GDCAB.total AS total "
                                                + "FROM svm_guiadespacho_cab GDCAB INNER JOIN svm_guiadespacho_det GDDET "
                                                + "ON GDCAB.numero_guia = GDDET.numero_guia "
                                                + "WHERE GDCAB.numero_guia IN (select nro_guia_desp from svm_factura_det where nro_factura = "+nroFact+") ";
                                            rsQuery = null;
                                            rsQuery = stmt.executeQuery(q);
                                            while(rsQuery.next())
                                            {
                                                out.print("<tr id='filaGD"+rsQuery.getString("numero_guia")+"'>"
                                                        + "<td><a href=\"javascript: onclick=SeleccionGD("+rsQuery.getString("numero_guia")+")\"> >> </a>"
                                                        + "<input type='hidden' id='hid"+rsQuery.getString("numero_guia")+"' value='"+rsQuery.getString("numero_guia")+"'></td>"
                                                        + "<td>"+rsQuery.getString("numero_guia")+"</td>"
                                                        + "<td>"+rsQuery.getString("fecha_emision")+"</td>"
                                                        + "<td>"+rsQuery.getString("total")+"</td>"
                                                        + "</tr>");
                                            }
                                        %>
                                    </tbody>
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
                                    <tbody>
                                        <%
                                            stmt = null;
                                            stmt = _connMy.createStatement();
                                            q= "";
                                            q="SELECT GDCAB.numero_guia, GDDET.detalle_guia AS nombre , GDDET.valor_unitario, GDDET.cantidad, GDDET.total_item "
                                            + "FROM svm_guiadespacho_det GDDET "
                                            + "INNER JOIN svm_guiadespacho_cab GDCAB "
                                            + "ON GDDET.numero_guia = GDCAB.numero_guia "
                                            + "WHERE GDCAB.numero_guia IN (select nro_guia_desp from svm_factura_det where nro_factura = "+nroFact+") ";
                                            rsQuery = null;
                                            rsQuery = stmt.executeQuery(q);
                                            while(rsQuery.next())
                                            {
                                                out.print("<tr class='filaDetalle"+rsQuery.getString("numero_guia")+"' id='"+rsQuery.getString("numero_guia")+"'>"
                                                        + "<td>"+rsQuery.getString("numero_guia")+"</td>"
                                                        + "<td>"+rsQuery.getString("nombre")+"</td>"
                                                        + "<td>"+rsQuery.getString("valor_unitario")+"</td>"
                                                        + "<td>"+rsQuery.getString("cantidad")+"</td>"
                                                        + "<td>"+rsQuery.getString("total_item")+"</td>"
                                                        + "</tr>");
                                            }
                                        %>
                                    </tbody>
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
       <input style="font-size:12px; height: 23px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Guias" onclick="cargaGuiasM()" />
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
<div id="dialog_msg" title="Mensaje" style="display:none;" ></div>
    <input type="hidden" value="<%out.print(secuencia);%>" id="secuencia" name="secuencia" />
</body>
</html>
