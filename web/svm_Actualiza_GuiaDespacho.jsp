<%-- 
    Document   : svm_Actualiza_GuiaDespacho
    Created on : 22-06-2016, 17:38:24
    Author     : Ivan
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
<title>Ingreso Actividad Comercial</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link href="css/style_tabla.css" type="text/css" rel="stylesheet" />
<link href="css/solutel.css" type="text/css" rel="stylesheet" />
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" /> 

<link type="text/css" rel="stylesheet" media="screen" href="css/jquery.ui.all.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap.min.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap-theme.min.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>

<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap-theme.min.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="css/bootstrap-3.3.5.min.css"/>

<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap-3.3.5.min.js"></script>
<script type="text/javascript" src="js/jquery.validate-1.14.0.min.js"></script>
<script type="text/javascript" src="js/jquery-validate.bootstrap-tooltip.js"></script> 
<script src="js/validaciones.js" type="text/javascript"></script>        

<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<script src="js/CargarCombo.js" type="text/javascript" ></script>
<script src="js/CRUD_guiadespacho.js" type="text/javascript"></script>
<script src="js/CRUD_guiadespacho_det.js" type="text/javascript"></script>
<%    
    //TipoUser, Rut y Nombre Ejecutivo PAra actualiza Actividad comercial.    
    HttpSession s = request.getSession();
    Connection _connMy = null;    
    CallableStatement sp_usu = null;   
    String rut = "";
    String nom = "";
    String id= "";
    String secuencia = "";
    String var = "";
    String tipoNeg = "";
    String fecha = "";
    String NomEje= "";
    String Estado = "";
    String rutEje = "";
    String rutCli = "";
    String nomCli = "";
    String codCli = "";
    String tipCli = "";
    String corrGuia = "0";
    String codEje = "";
    String comentario = "";
    String supervisor= "";
 
    corrGuia=request.getParameter("secuencia") != null ? request.getParameter("secuencia") : "0";

    try
    {
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
        
        nom  = (String)s.getAttribute("nom"); 
        
        if(s.getAttribute("nom")== null)
        {                                  
            response.sendRedirect("login.jsp");
        }
        
        if(request.getParameter("par") != null)
        {
            id = request.getParameter("par");
        }
        if(request.getParameter("secuencia") != null)
        {
            secuencia = request.getParameter("secuencia");
        }

    }catch(Exception e)
    {
        out.println("Error:" + e.getMessage());
    }
       
%>
<script type="text/javascript">        

$(document).ready(function (){   
    cargaCondicionGuia();
    cargaGuiaDespacho();
});

function goBack(){
    location.href='svm_Seleccion_GuiaDespacho.jsp';
}

function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

function loadDialogClientes(){
    $( "#dialog_clientes" ).dialog({
        modal: true,
        width: 600,
        height:420,
        buttons: {
            Seleccionar: function() {
                $("#txt_guiadespacho_rutcli").val($("#select_cliente_filter").val());
                var text = $("#select_cliente_filter option:selected").text();
                $("#txt_guiadespacho_cli").val(text.substring(21,text.length));
                $( this ).dialog( "close" );
            },
            Cancelar: function() {
                $( this ).dialog("close");
            }            
        },
        open: function(event, ui) {
            $("#txt_filtro_cliente_rut").val("");
            $("#txt_filtro_cliente_nombre").val("");            
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            filtraClientes();
        }
    });
}

</script>
</head>
<body id="principal">
<input type="hidden" value="<%=id%>" id="parametroGuiaDespacho" />
<input type="hidden" value="<%=rut%>" id="rutUsuario" />
<div class="formularioIngresar">
    <table id="header">                           
        <tr>
            <td>
                <form action="" method="post">
                    <table >
                        <tr>
                            <td colspan =" 2" >DATOS GUIA DESPACHO<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                            <td colspan = "2">DATOS CLIENTE<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                        </tr>
                        <tr>
                            <td>N° Gu&iacute;a Despacho:</td>                            
                            <td>                                 
                                <input type="text" disabled= "disabled" id="txt_guiadespacho_numero" maxlength="11" name="txt_guiadespacho_numero" />
                            </td>                           
                            <td>Rut:</td>
                            <td><input type="text" readonly id="txt_guiadespacho_rutcli" maxlength="11" name="txt_guiadespacho_rutcli" />
                                <input class = "botonera" style="width: 70px" type="button" name="btnCancela" id="btn_guiadespacho_clientes" value="Clientes" onClick="loadDialogClientes()" /></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha emisi&oacute;n:</td>
                            <td>
                                <input type = "text" name = "txt_guiadespacho_fecha" readonly id= "txt_guiadespacho_fecha" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador"/>
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({
                                        inputField     :    "txt_guiadespacho_fecha",     // id del campo de texto 
                                        ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                        button     :    "lanzador"     // el id del boton que lanzará el calendario 
                                    }); 
                                </script>	
                            </td>                          
                            <td>Nombre</td>
                            <td rowspan="3">
                                 <textarea rows="3" cols="27" readonly id="txt_guiadespacho_cli">
                                 </textarea> 
                            </td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Cotizaci&oacute; N°:</td>
                            <td>                                 
                                <input type="text" id="txt_guiadespacho_cotizacion" maxlength="9" name="txt_guiadespacho_cotizacion" onkeypress="return validarSiNumero(event)"/>
                            </td>                             
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Condici&oacute;n pago:</td>
                            <td><select name="select_guiadespacho_condicion_pago" id="select_guiadespacho_condicion_pago">
                                    <option value="">--Seleccione--</option>
                                </select>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Acepto COT:</td>
                            <td>                                 
                                <input type="text" id="txt_guiadespacho_aceptoCOT" maxlength="45" name="txt_guiadespacho_aceptoCOT" />
                            </td> 
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Gu&iacute;a Desp. Especial:</td>
                            <td><select name="select_guiadespacho_especial" id="select_guiadespacho_especial">
                                    <option value="-1">--Seleccione--</option>
                                    <option value="SI">SI</option>
                                    <option value="NO">NO</option>
                                </select></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Total:</td>
                            <td><input type="text" id="txt_guiadespacho_total" maxlength="9" name="txt_guiadespacho_total" onkeypress="return validarSiNumero(event)"/></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>                        
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </form>
            </td>
            <td rowspan="6" >
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
                                    <%
                                                          
                                        int cont = 0;                                        
                                         var = "select";                                        
                                        //sp_usu = _connMy.prepareCall("{call sp_historial(?,?,'','')}");
                                        //sp_usu.setString(1,var);                                        
                                        //sp_usu.setLong(2,Long.parseLong(secuencia));                                          
                                        //sp_usu.execute();
                                        //final ResultSet rsHistorial = sp_usu.getResultSet();
                                        String claseGrilla = "";
                                        //while(rsHistorial.next())
                                        //{
                                        //    if(cont % 2 == 0)
                                        //    {                                                
                                        //        claseGrilla = "alt";
                                        //    }
                                        //    out.println("<tr id='filaTablaHistorial"+cont+"' class='"+claseGrilla+"'>");
                                    %>                                                                                                                                                                    
                                     <%
                                            out.print("</tr>");
                                            claseGrilla = "";
                                            cont ++;
                                        //}
                                     %>                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>      
        <tr>
            <td colspan="9">
                <table class="detalle">
                    <tr>
                        <td colspan = "14" id='margenblanco'><hr style="margin-bottom: 0px;margin-top: 4px;"/></td>
                    </tr>                    
                    <tr>
                        <td colspan = "14" id='margenblanco'>ITEMS<hr style="margin-bottom: 4px;margin-top: 0px;"/></td>
                    </tr>
                    <tr>
                        <td>N° OT:</td>
                        <td><input type="text" maxlength="9" id="txt_guiadespacho_numeroOT" name="txt_guiadespacho_numeroOT" onkeypress="return validarSiNumero(event)"/></td>                                 
                        <td>Item N°:</td>
                        <td><input type="text" maxlength="9" id="txt_guiadespacho_itemnumero" name="txt_guiadespacho_itemnumero" onkeypress="return validarSiNumero(event)"/></td>         
                        <td>Cantidad:</td>
                        <td><input type="text" maxlength="9" id="txt_guiadespacho_cantidad" name="txt_guiadespacho_cantidad" onkeypress="return validarSiNumero(event)"/></td>                                 
                        <td>Detalle Gu&iacute;a:</td>
                        <td><input type="text" maxlength="45" id="txt_guiadespacho_detalle" name="txt_guiadespacho_detalle" /></td>         
                        <td>Valor Unitario:</td>
                        <td><input type="text" maxlength="9" id="txt_guiadespacho_valor" name="txt_guiadespacho_valor" onkeypress="return validarSiNumero(event)"/></td>         
                        <td>Total Item:</td>
                        <td><input type="text" maxlength="9" readonly id="txt_guiadespacho_totalitem" name="txt_guiadespacho_totalitem" onkeypress="return validarSiNumero(event)"/></td>         
                    </tr>
                    <tr>
                        <td colspan="13" rowspan="5" id="margen">
                            <div  id = "tablaDetalleGuia" class="grillaConf">
                                <table id="tblDetalleGuia">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Correlativo</th>
                                            <th>N° OT</th>
                                            <th>Item N°</th>
                                            <th>Cantidad</th>
                                            <th>Detalle Gu&iacute;a de Despacho</th>
                                            <th>Valor Unitario</th>
                                            <th>Total Item</th>                                                 
                                        </tr>
                                    </thead>				
                                    <tbody>
                                    <%
                                        cont = 0;
                                        int ultimo =0;
                                         
                                        var = "select";                                        

                                        sp_usu = _connMy.prepareCall("{call sp_guiadespacho_det(?,?,?,?,?,?,?,?,?,?)}");
                                        sp_usu.setString(1, var);
                                        sp_usu.setInt(2,0);
                                        sp_usu.setInt(3,0);
                                        sp_usu.setInt(4,0);                
                                        sp_usu.setInt(5,0);                
                                        sp_usu.setInt(6,0);
                                        sp_usu.setString(7, "");
                                        sp_usu.setInt(8,0);
                                        sp_usu.setInt(9,0);
                                        sp_usu.setInt(10,Integer.parseInt(corrGuia));                
                                        sp_usu.registerOutParameter(1, Types.VARCHAR);
                                         
                                        sp_usu.execute();
                                        final ResultSet rsDetalle = sp_usu.getResultSet();
                                        claseGrilla = "";
                                        while(rsDetalle.next())
                                        {
                                            if(cont % 2 == 0)
                                            {                                                
                                                claseGrilla = "alt";
                                            }
                                            out.println("<tr id='filaTablaDetalle"+cont+"' class='"+claseGrilla+"'>");
                                    %>                                        
                                        <td>
                                            <a id="seleccion<%=cont%>" href="javascript: onclick=ModificaDetalleGuia(<%=cont%>)"> >></a>
                                            <input type="hidden" value="0" id="habilitaDetCom" name="habilitaDetCom" />
                                        </td>                                                                                       
                                        <td id ="guiadespachoDet_correlativo<%=cont%>"><%=rsDetalle.getString("correlativo")%></td>
                                        <td id ="guiadespachoDet_OT<%=cont%>"><%=rsDetalle.getString("numero_ordentaller")%></td>
                                        <td id ="guiadespachoDet_Item<%=cont%>"><%=rsDetalle.getString("itemOT")%></td>
                                        <td id ="guiaDet_cantidad<%=cont%>"><%=rsDetalle.getString("cantidad")%></td>"
                                        <td id ="guiaDet_detalleguia<%=cont%>"><%=rsDetalle.getString("detalle_guia")%></td>
                                        <td id ="guiaDet_valorunit<%=cont%>"><%=rsDetalle.getString("valor_unitario")%></td>
                                        <td id ="guiaDet_totalitem<%=cont%>"><%=rsDetalle.getString("total_item")%></td>
                                     <%
                                            out.print("</tr>");
                                            claseGrilla = "";
                                            cont ++;
                                        }
                                     %>
                                    </tbody>
                                </table>
                                    <input type="hidden" id="ultimo" value="<%=ultimo+1%>"></input>
                                    <input type="hidden" id="cantidad" value="<%=cont%>"></input>
                                    <input type="hidden" id="txt_correlativo" value=""></input>
                            </div>                                               
                        </td>
                        <td id="bottom" rowspan="1">
                            <img style="cursor: pointer" onclick="ingresaDetalleGuia()" id="DetalleIngresoGuia" class="ico" border="0" src="images/logotipos/agregar.png" 
                            height="48px" width="25px"/>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="DetalleModificaGuia" style="display: none" onclick="modificarDetalleGuia()" src="images/logotipos/modificar.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="CancelaModificaGuia" style="display: none" onclick="CancelaDetalleGuia()" src="images/logotipos/flecha.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>                                            
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="DetalleEliminaGuia" style="display: none" border="0" onclick="eliminarDetalleGuia()" src="images/logotipos/eliminar.png" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>            
<input class ="botonera" type="submit" id="btn_guiadespacho_grabar" name="btn_guiadespacho_grabar" value="Grabar" onclick="grabarGuiaDespacho()"/>
<input class = "botonera" type="submit" name="btnCancela" value="Cancelar" onClick="goBack()" />
        
<div id="dialog_clientes" title="Clientes" style="display:none;" >
    <div id="contenido_clientes">
        <table>
            <tr>
                <td>Rut de cliente:</td>
                <td><input type="text" style="width: 160px" id="txt_filtro_cliente_rut" name="txt_filtro_cliente_rut" /></td>
                <td>&nbsp;&nbsp;<input style="font-size:12px; height: 23px; width: 120px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Clientes" onclick="filtraClientes()" /></td>
            </tr>
            <tr>
                <td>Nombre de cliente</td>
                <td><input type="text" style="width: 160px" id="txt_filtro_cliente_nombre" name="txt_filtro_cliente_nombre" /></td>
                <td></td>
            </tr>
        </table>
       <br/>
        <select size="10" style="width: 560px;" id="select_cliente_filter" name="select_cliente_filter" multiple>
            <%                                    
                Statement stmt = null;
                ResultSet rsQuery = null;                                       
                stmt = _connMy.createStatement();
                String q = "";
                stmt = _connMy.createStatement();
                q="SELECT concat(rut,'-',dv) rut, razon_social,replace(concat(rpad(concat(rut,'-',dv),20,' '),'|'),' ','&nbsp;') rut_pad FROM svm_mae_clientes";
                rsQuery = stmt.executeQuery(q);

                while(rsQuery.next())
                {
                    out.println("<option value='"+rsQuery.getString("rut")+"'>"+rsQuery.getString("rut_pad")+rsQuery.getString("razon_social")+"</option>");
                }
            %>
        </select>
    </div>
</div>

</body>
</html>