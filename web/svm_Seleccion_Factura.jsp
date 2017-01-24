<%-- 
    Document   : svm_Seleccion_Factura
    Created on : 23-06-2016, 15:46:39
    Author     : Ivan
    Modificacion : Yethro Villalon
--%>

<%@page import="java.sql.Types"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAL.conexionBD"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Facturas</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon"/>   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css"/>
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
<link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet"/>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<script src="js/CRUD_factura.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<style type="text/css">
.paging_full_numbers a.paginate_button,
.paging_full_numbers a.paginate_active {
	border: 1px solid #aaa;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	padding: 2px 5px;
	margin: 0 3px;
	cursor: pointer;
	*cursor: hand;
	color: #333 !important;
}
.paging_full_numbers a.paginate_button {
	background-color: #ddd;
}

.paging_full_numbers a.paginate_button:hover {
	background-color: #ccc;
	text-decoration: none !important;
}

.paging_full_numbers a.paginate_active {
	background-color: #99B3FF;
}

.paging_full_numbers a.paginate_button {
    color: #fff !important;
}
.paging_full_numbers a.paginate_active {
    color: #fff !important;
}
</style>
<%  
    String fech_desde = request.getParameter("txt_factura_ingreso");
    String fech_hasta = request.getParameter("txt_factura_final");
    String rut_cliente = request.getParameter("txt_fil_rutcli");
    String nombre_cliente = request.getParameter("txt_fil_nombcli");
    
    DateFormat sdfv = new SimpleDateFormat("dd-MM-yyyy");
    DateFormat sdfq = new SimpleDateFormat("yyyy-MM-dd");
    Calendar cal = Calendar.getInstance();
    cal.set(Calendar.DATE, 1);
    Date primerDiadelMes = cal.getTime();
    cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
    Date ultimoDiadelMes = cal.getTime();
    
    if(fech_desde == null || fech_desde.trim().isEmpty()){
        fech_desde = sdfv.format(primerDiadelMes);
    }
    
    if(fech_hasta == null || fech_hasta.trim().isEmpty()){
        fech_hasta = sdfv.format(ultimoDiadelMes);
    }
    
    if(rut_cliente == null || rut_cliente.trim().isEmpty()){
        rut_cliente = "";
    }
    
    if(nombre_cliente == null || nombre_cliente.trim().isEmpty()){
        nombre_cliente = "";
    }
    
    HttpSession s = request.getSession();
    Connection _connMy = null;
    int cont =0; 
    String tipoUser = "";
    String secu = "";
    try
    {
        if(s.getAttribute("nom")==null)
        {
            response.sendRedirect("login.jsp");
        }
        if(s.getAttribute("tipo") != null)
        {
            tipoUser =(String)s.getAttribute("tipo");
        }
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
    }catch(Exception e)
    {
        System.out.println("Error: "+ e.getMessage());
        response.sendRedirect("login.jsp");
    }
%>
<script type="text/javascript">
$(document).ready(function(){
   $('#tblFactura').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
        "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
        bFilter: false, bInfo: false,
        "bLengthChange": false,
        "bAutoWidth": false,
       "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5] }]
    });
});
function seleccion_registro_factura(id){  
    var nroFact = $("#nroFactura").val();
    if($("#habilitaFactura").val() == 0)
    {
        FuncionErrores(239);
        return false;
    }
    
    var accion=id==2?"modifica":"consulta";
    
    if(accion == "modifica"){
        location.href='svm_Actualiza_Factura.jsp?nroFactura='+nroFact;
    }else{
        location.href='svm_Consulta_Factura.jsp?nroFactura='+nroFact;
    }
}
function anular()
{
    if($("#habilitaFactura").val() == 0)
    {
        FuncionErrores(239);
        return false;
    }
    alert("Factura Anulada");
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

function eliminaFiltro(){
    
    $("#txt_factura_ingreso").val("");
    $("#txt_factura_final").val("");
    $("#txt_fil_rutcli").val("");
    $("#txt_fil_nombcli").val("");
    
    location.href = "svm_Seleccion_Factura.jsp";
}
</script>
</head>
<body id="principal"> 
<input type="hidden" id="secu" value="<%=secu%>" />
    <table id="header2">
        <tr>
            <td colspan="5">
                <div class="tablafiltrar">
                    <form action="#" method="POST" >
                    <table align="center" border="0">
                        <tr>
                            <td align="right">Fecha&nbsp;Desde:</td>	
                            <td>
                                <input type = "text" readonly name = "txt_factura_ingreso" id= "txt_factura_ingreso" value="<%out.print(fech_desde);%>" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_factura_ingreso",     // id del campo de texto 
                                    ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanzador"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                            </td>
                            <td align="right">&nbsp;&nbsp;Fecha&nbsp; Hasta:</td>
                            <td>
                                <input type = "text" readonly name = "txt_factura_final" id = "txt_factura_final" value="<%out.print(fech_hasta);%>" size="12"/>
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanza" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_factura_final",     // id del campo de texto 
                                    ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanza"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                            </td>
                            <td>&nbsp;&nbsp;RUT:</td>
                            <td>
                                <input type = "text" name = "txt_fil_rutcli" id = "txt_fil_rutcli" value="<%out.print(rut_cliente); %>" size="10"/>
                            </td>
                            <td>&nbsp;&nbsp;Cliente:</td>
                            <td>
                                <input type = "text" name = "txt_fil_nombcli" id = "txt_fil_nombcli" value="<%out.print(nombre_cliente); %>" />
                            </td>
                            <td>
                                <input class ="botonera" type="submit" name="btnBuscar" value="Buscar" />
                            </td>
                            <td colspan="2">
                                <input class ="botonera" type="submit" name="btnEliminaFiltro" onclick="eliminaFiltro()" value="Elimina Filtro" />
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <div class="datagrid">
                    <table id="tblFactura">
                        <thead>
                            <tr>
                                <th width="2.5%"></th>
                                <th width="10%">N&uacute;mero Factura</th>
                                <th width="16.5%">Fecha Emisi&oacute;n</th>
                                <th width="31%%">Cliente</th>
                                <th width="19%">Adicional</th>
                                <th width="20%">Forma de pago</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%

                            Statement stmt = _connMy.createStatement();
                            String q ="SELECT nroFactura, DATE_FORMAT(fecha_factura,'%d-%m-%Y') AS fecha_factura, cliente, forma_pago, exenta, adicional, comentario FROM svm_factura_cab WHERE 1=1 ";
                            if(!fech_desde.equals("")){
                                fech_desde = sdfq.format(sdfv.parse(fech_desde));
                                q += " AND fecha_factura >= '"+fech_desde+"' ";
                            }
                            if(!fech_hasta.equals("")){
                                fech_hasta = sdfq.format(sdfv.parse(fech_hasta));
                                q += " AND fecha_factura <= '"+fech_hasta+"' ";
                            }
                            
                            if(!rut_cliente.equals("")){
                                q += " AND rutCli like '%"+rut_cliente+"%' ";
                            }
                            
                            if(!nombre_cliente.equals("")){
                                q += " AND cliente like '%"+nombre_cliente+"%' ";
                            }

                            final ResultSet rsQuery = stmt.executeQuery(q);

                            String cla = "";
                            while(rsQuery.next())
                            {
                                if(cont % 2 == 0)
                                    cla = "alt";
                                else
                                    cla = "";

                                out.println("<tr id='filaFactura"+cont+"' class='"+cla+"'>");

                                %>
                                <td>
                                    <a href="javascript: onclick=ModificaFactura(<%=cont%>)"> >></a>
                                    <input type="hidden" value="0" id="habilitaFactura" name="habilitaFactura" />
                                    <input type="hidden" value="" id="nroFactura"/>
                                </td>
                                <td id="numFactura<%=cont%>"><%=rsQuery.getString("nroFactura")%></td>
                                <td id="fechaFactura<%=cont%>"><%=rsQuery.getString("fecha_factura")%></td>
                                <td id="cliente<%=cont%>"><%=rsQuery.getString("cliente")%></td>
                                <td id="adicional<%=cont%>"><%=rsQuery.getString("adicional")%></td>
                                <td id="formaPago<%=cont%>"><%=rsQuery.getString("forma_pago")%></td>

                                <%
                                out.println("</tr>");
                                cont ++;
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <!--Sistemas sa 20/10/2015-->
            <td>
                <%
                if(!tipoUser.equals("Backoffice")){
                    %><input class ="botonera" type="button" name="btn_factura_Ingresa" value="Ingresar" onClick="window.location.href='svm_Ingresa_Factura.jsp'"/>	<%;
                }%> 
                <input class ="botonera" type="submit" name="btn_factura_Modifica" id="btn_factura_Modifica" value="Modificar" onClick="seleccion_registro_factura(2)" />	
                <input class ="botonera" type="submit" name="btn_factura_Consulta" value="Consultar" onClick="seleccion_registro_factura(3)"  />
            </td>	
        </tr>
    </table>
</body>
</html>