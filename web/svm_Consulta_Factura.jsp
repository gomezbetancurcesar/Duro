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
        } catch (Exception e) {
            System.out.println("Error:"+e.getMessage());
        }          
%>
</head>
<body id="principal">
<div class="formularioIngresar">
    <table id="header">
        <tr>
            <td>
                <form action="" method="post">
                    <table >
                        <tr>
                            <td colspan =" 2" >DATOS FACTURA<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                            <td>&nbsp;</td>
                            <td colspan = "2">DATOS CLIENTES<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>                            
                        </tr>
                        <tr>
                            <td>N° Factura:</td>                            
                            <td>                                    
                                <input type="text" value="<%=nroFact%>" disabled= "disabled" readonly="readonly" id="txt_factura_numero" maxlength="19" name="txt_factura_numero" />
                            </td> 
                            <td></td>
                            <td>Rut:</td>
                            <td><input type="text" id="txt_factura_rutcli" maxlength="11" name="txt_factura_rutcli" value="<%=rutCli%>" disabled= "disabled" readonly="readonly"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha factura:</td>
                            <td>
                                <input type = "text" name = "txt_factura_fecha" readonly id= "txt_factura_fecha"  value="<%=fechFactura%>" size="12" disabled= "disabled" readonly="readonly"/>
                            </td>     
                            <td></td>
                            <td>Nombre</td>
                            <td rowspan="3">
                                 <textarea rows="3" cols="27" id="txt_factura_cli" disabled= "disabled" readonly="readonly"><%=nomCli%>
                                 </textarea>                                
                            </td>                            
                        </tr>
                        <tr>
                            <td>Forma de Pago:</td>
                            <td>
                                <select name = "slt_factura_formaPago" id= "slt_factura_formaPago" disabled= "disabled" readonly="readonly">
                                    <option value="-1">Seleccione...</option>
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
                            <td><select name="slt_factura_excenta" id="slt_factura_excenta" disabled= "disabled" readonly="readonly">
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
                            <td><select name="select_factura_adicional" id="select_factura_adicional" disabled= "disabled" readonly="readonly">
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
                                <textarea rows="3" cols="27" id="txt_factura_comentario" class="required" disabled= "disabled" readonly="readonly"><%=comentarios%></textarea>
                            </td>
                        </tr>
                    </table>
                </form>
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
                                                out.print("<tr>"
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
                        <td>&nbsp;</td>
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
</div>
<input class = "botonera" type="submit" name="btnCancela" value="Volver" onClick="goBack()" />

</body>
</html>
