<%-- 
    Document   : svm_Seleccion_GuiaDespacho
    Created on : 22-06-2016, 17:20:47
    Author     : Ivan
--%>


<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Types"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Seleccion Actividad Comercial</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon"/>   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css"/>
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
<link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>

<link type="text/css" rel="stylesheet" media="screen" href="css/jquery.ui.all.css"/>
<!--<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap.min.css"/>-->
<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap-theme.min.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>

<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/jquery-ui.js" type="text/javascript"></script>

<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet"/>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.dataTables.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<script src="js/CRUD_guiadespacho.js" type="text/javascript"></script>
<!--<script src="js/CRUD_cotizacion_det.js" type="text/javascript"></script>-->
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
    HttpSession s = request.getSession();
    Connection _connMy = null;
    int id= 1;
    int cont =0; 
    String supervisor = "";
    String rut = "";
    String tipoUser = "";
    String nroSecuencia="";
    String varCarga = "";
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
        if(s.getAttribute("supervisor")!= null)
        {
             supervisor = (String)s.getAttribute("supervisor");
        }
        if(s.getAttribute("rut")!= null)
        {
             rut = (String)s.getAttribute("rut");
        }
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
        String query = "select fn_secuencia() as secuencia";
        ResultSet resultQuery = _connMy.createStatement().executeQuery(query);
        while(resultQuery.next())
        {  
            nroSecuencia = resultQuery.getString("secuencia");
        }        
        s.setAttribute("secu",nroSecuencia);
        secu = (String)s.getAttribute("secu");  
    }catch(Exception e)
    {
        System.out.println("Error: "+ e.getMessage());
        response.sendRedirect("login.jsp");
    }
%>
<script type="text/javascript">
$(document).ready(function(){
   $('#tblGuiaDespacho').dataTable( {//CONVERTIMOS NUESTRO LISTADO DE LA FORMA DEL JQUERY.DATATABLES- PASAMOS EL ID DE LA TABLA
        "sPaginationType": "full_numbers", //DAMOS FORMATO A LA PAGINACION(NUMEROS)
        bFilter: false, bInfo: false,
        "bLengthChange": false,
        "bAutoWidth": false,
       "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1,2,3,4,5,6,7]}]
    });
    filtraGuiaDespacho();
});
function seleccion_registro_guiaDespacho(id){
    var numero = $("#corrGuia").val();    
    var secu = $("#secu").val();        
    
    if($("#habilitaGuiaDesp").val() == 0 || numero == null )
    {
        FuncionErrores(239);
        return false;
    }
    var accion=id==2?"modifica":"consulta";
    
    location.href='svm_Actualiza_GuiaDespacho.jsp?par='+id+'&correlativo='+numero+'&secuencia='+numero+"&accion="+accion;
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

function facturarGuia() {
    
    var check = 0;
    
    for (var i = 0; i < $("#tblGuiaDespacho tr").length; i++) {
        if($("#chk"+i).is(":checked"))  {
          check = 1;
        }  
    }

    if (check == 0)
    {
        FuncionErrores(239);
        return false;
    }
            
    $("#dialog_factura").dialog({
        modal: true,
        width: 600,
        height:400,
        buttons: {
            Cancelar: function() {
                $( this ).dialog("close");
            },
            Facturar: function() {
                
                $( this ).dialog( "close" );                
            }
        }
    });
};


</script>
</head>
<body id="principal"> 
<input type="hidden" id="secu" value="<%=secu%>" />
    <table id="header2">
        <tr>
            <td colspan="5">
                <div class="tablafiltrar">
                    <table align="center">
                        <tr>
                            <td align="right">Fecha&nbsp;Desde:</td>	
                            <td>
                                <%
                                    Date date = new Date();
                                    DateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
                                    Calendar calendario = Calendar.getInstance();
                                    calendario.setTime(date);
                                    
                                    calendario.set(Calendar.DAY_OF_MONTH, calendario.getActualMinimum(Calendar.DAY_OF_MONTH));
                                    String primerDiaMes = formato.format(calendario.getTime());
                                    
                                    calendario.set(Calendar.DAY_OF_MONTH, calendario.getActualMaximum(Calendar.DAY_OF_MONTH));
                                    String ultimoDiaMes = formato.format(calendario.getTime());
                                %>                                
                                <!--Codigo Sistemas SA-->
                                <input type = "text" readonly value="<%out.print(primerDiaMes);%>" name = "txt_filtroGuia_ingreso" id= "txt_filtroGuia_ingreso" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_filtroGuia_ingreso",     // id del campo de texto 
                                    ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanzador"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                            </td>
                            <td align="right">&nbsp;&nbsp;Fecha&nbsp; Hasta:</td>
                            <td>
                                <input type = "text" readonly value="<%out.print(ultimoDiaMes);%>" name = "txt_filtroGuia_final" id = "txt_filtroGuia_final" size="12"/>
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanza" />
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({ 
                                    inputField     :    "txt_filtroGuia_final",     // id del campo de texto 
                                    ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                    button     :    "lanza"     // el id del botón que lanzará el calendario 
                                    }); 
                                </script>
                                <!--Codigo Sistemas SA-->
                            </td>
                            <td>&nbsp;&nbsp;Estado:</td>
                            <td>
                                <select id="slt_filtroComercial_estado" name="slt_filtroComercial_estado">
                                     <option value="">--Seleccione--</option>
                                    <%                                   
                                        Statement stmt = null;
                                        ResultSet rsQuery = null;                                       
                                        stmt = _connMy.createStatement();
                                        String q = "";

                                        q="select descripcion from svm_mae_tablas where tablas='Estado_Cotizacion'";

                                        rsQuery = stmt.executeQuery(q);

                                        while(rsQuery.next())
                                        {
                                            out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                        }
                                    %>
                                </select>
                            </td>
                            <td colspan="2">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input class ="botonera" type="submit" name="btnBuscar" onclick="filtraGuiaDespacho()" value="Buscar" />                                                            
                                <input class ="botonera" type="submit" name="btnEliminaFiltro" onclick="window.location.reload()" value="Elimina Filtro" />                                
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <div class="datagrid">
                    <table id="tblGuiaDespacho">
                        <thead>
                            <tr>
                                <th width="2%"></th>
                                <th width="5%">N&uacute;mero Gu&iacute;a</th>
                                <th width="5.34%">Fecha Emisi&oacute;n</th>
                                <th width="19.03%">Cliente</th>
                                <th width="6.17%">Especial</th>
                                <th width="7.14%">Total</th>
                                <th width="6.14%">Estado</th>
                            </tr>
                        </thead>                        
                        <tbody>                            
                            <%                                
                                String var = "select_all";
                                
                                CallableStatement sp_usu = _connMy.prepareCall("{call sp_guiadespacho(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                                sp_usu.setString(1,var);
                                sp_usu.setInt(2,0);                
                                sp_usu.setInt(3,0);                                
                                sp_usu.setDate(4,null);                                                
                                sp_usu.setString(5,"");
                                sp_usu.setString(6,"");                
                                sp_usu.setInt(7,0);
                                sp_usu.setString(8,"");
                                sp_usu.setString(9,"");
                                sp_usu.setString(10,"");
                                sp_usu.setString(11,"");
                                sp_usu.setString(12,"");
                                sp_usu.setInt(13,0);
                                sp_usu.registerOutParameter(1, Types.VARCHAR);
                                sp_usu.execute();
                                
                                final ResultSet rs = sp_usu.getResultSet();
                                
                                String cla = "";
                                while(rs.next())
                                {
                                    if(cont % 2 == 0)
                                    {
                                        cla = "alt";
                                    }else
                                    {  
                                        cla = "";

                                    }
                                    out.println("<tr id='filaTablaGuiaDespacho"+cont+"' class='"+cla+"'>");
                            %>
                            <td>
                                <a href="javascript: onclick=ModificaGuiaDespacho(<%=cont%>)"> >> </a>
                                <input type="hidden" value="0" id="habilitaGuiaDesp" name="habilitaGuiaDesp" />
                                <input type="hidden" value="" id="corrGuia" />
                            </td>
                            <td id="numero_guia<%=cont%>"><%= rs.getString("numero_guia")%></td>
                            <td id="fecha_emision<%=cont%>"><%=rs.getString("fecha_emision")%></td>
                            <td id="razon_cli<%=cont%>"><%= rs.getString("razon_social")%></td>
                            <td id="especial<%=cont%>"><%= rs.getString("guiadespacho_especial")%></td>
                            <td id="total<%=cont%>"><%= rs.getString("total")%></td>
                            <td id="estado<%=cont%>"><%= rs.getString("estado")%></td>
                            <td style="display: none" id="secuencia<%=cont%>"><%= rs.getString("secuencia")%></td>
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
                    %><input class ="botonera" type="button" name="btn_actComercial_Ingresa" value="Ingresar" onClick="window.location.href='svm_Actualiza_GuiaDespacho.jsp?par=1&secuencia='+<%=secu%>"/>	<%;
                }%> 
                <input class ="botonera" type="submit" name="btn_actComercial_Modifica" id="btn_actComercial_Modifica" value="Modificar" onClick="seleccion_registro_guiaDespacho(2)" />	
                <input class ="botonera" type="submit" name="btn_actComercial_Consulta" value="Consultar" onClick="seleccion_registro_guiaDespacho(3)"  />                
            </td>	
        </tr>
    </table>
                
    <div id="dialog_factura" title="Facturar" style="display:none;">
        <div id="contenido_facturar">
            <table width="100%">
                <tr>
                    <td>Forma de Pago:</td>
                    <td>
                        <select id="select_GDFactura_formaPago" width="150px" name="select_GDFactura_formaPago">
                            <option value="-1">Seleccione...</option>
                            <%
                                stmt = _connMy.createStatement();
                                q="select descripcion from svm_mae_tablas where tablas='Condiciones_Pago'";
                                rsQuery = stmt.executeQuery(q);
                                while(rsQuery.next())
                                {
                                    out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Excenta</td>
                    <td>
                        <select id="select_GDFactura_excenta" width="150px" name="select_GDFactura_excenta">
                            <option value="-1">Seleccione...</option>
                            <option value="S">S</option>
                            <option value="N">N</option>
                        </select>                
                </tr>
                <tr>
                    <td>Adicional</td>
                    <td>
                        <select id="select_GDFactura_adicional" width="150px" name="select_GDFactura_adicional">
                            <option value="-1">Seleccione...</option>
                            <option value="Recargo">Recargo</option>
                            <option value="Descuento">Descuento</option>
                            <option value="Normal">Normal</option>
                        </select>    
                    </td>
                </tr>
                <tr>
                    <td>Comentarios:</td>
                    <td>
                        <textarea rows="3" cols="27" id="txt_GDFactura_comentario"></textarea>
                    </td>
                </tr>
            </table>        
        </div>
    </div>
</body>
</html>
    