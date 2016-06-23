<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.awt.Button"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PORTAL DUROCROM</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link href="css/style_tabla.css" type="text/css" rel="stylesheet" />
<link href="css/solutel.css" type="text/css" rel="stylesheet" />
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" /> 
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/CRUD_Clientes.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>

<script src="js/ValidacionCliente.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<script src="js/label.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<%
    HttpSession s = request.getSession();

    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }
    String rutCli ="";
    String nomCli ="";
    String contacto ="";
    String direccion="";
    String nomEje="";
    String estado="";
    String tipoUser = "";
    String supervisor = "";
    String rutUser = "";
    String nom= "";
    String codigo="";
    String sigla="";
    String comuna="";
    String ciudad="";
    String fono1="";
    String fono2="";
    String fax="";
    String rubro="";
    String casilla="";
    
    Connection _connMy = null;
    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }
    nom = (String)s.getAttribute("nom");
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
         rutUser = (String)s.getAttribute("rut");
    }
    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
//    if(_connMy == null)
//    {
//        response.sendRedirect("login.jsp");
//    }
//    
    int id = Integer.parseInt(request.getParameter("par"));  
%>

<%
    if(id == 3 ||id == 2)
    {        
        String rut = request.getParameter("opcion");
        String opcion = "select";
        
        CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_cliente(?,?,?,?,?,'','','','','','','','','','','','','','')}");
        sp_usu.setString(1,opcion);
        sp_usu.setString(2,"");
        sp_usu.setString(3,"");
        sp_usu.setString(4, "");
        sp_usu.setString(5, rut);
        
        sp_usu.execute();
        
        final ResultSet rs = sp_usu.getResultSet();
        while(rs.next())            
        {
             rutCli = rs.getString("rut");
             nomCli = rs.getString("razon_social");
             contacto = rs.getString("contacto");
             direccion = rs.getString("direccion");
             nomEje  = rs.getString("rut_eje");
             estado = rs.getString("estado");
             
             codigo=rs.getString("codigo");
             sigla=rs.getString("sigla");
             comuna=rs.getString("comuna");
             ciudad=rs.getString("ciudad");
             fono1=rs.getString("fono_uno");
             fono2=rs.getString("fono_dos");
             fax=rs.getString("fax");
             rubro=rs.getString("rubro");
             casilla=rs.getString("casilla");
        }
        
    %>
<script type="text/javascript">
    $(document).ready(function (){    

        $("#txt_cliente_rut").val("<%=rutCli%>");
        $("#txt_cliente_nombre").val("<%=nomCli%>");
        $("#txt_cliente_contacto").val("<%=contacto%>");
        $("#txt_cliente_direccion").val("<%=direccion%>");
        $("#txt_cliente_ejecutivo").val("<%=nomEje%>");
        $("#txt_cliente_estado").val("<%=estado%>");

        $("#txt_cliente_codigo").val("<%=codigo%>");
        $("#txt_sigla_cliente").val("<%=sigla%>");
        $("#txt_cliente_comuna").val("<%=comuna%>");
        $("#txt_cliente_ciudad").val("<%=ciudad%>");
        $("#txt_cliente_fono1").val("<%=fono1%>");
        $("#txt_cliente_fono2").val("<%=fono2%>");
        $("#txt_cliente_fax").val("<%=fax%>");
        $("#txt_cliente_rubro").val("<%=rubro%>");
        $("#txt_cliente_casilla").val("<%=casilla%>");

        if(3==<%=id%>){
          $("#btn_ingresar").css("display","none");
        }
        

    }
    );

</script>

    <%
    }
%>
</head>

<body id="principal">
    
    <table id="header" >
        <!--Formulario Ingresar-->
        <tr>
            <td colspan="5">
                <div class="formularioIngresar">
                    <form action="" method="post">
                    <table class="tblCliActualiza">
                        <tr>
                            <td colspan = 2>FORMULARIO<hr/></td>	
                        </tr>
                        <tr>
                            <td>C&oacute;digo: </td>
                            <td><input disabled="disabled" maxlength="11" type="text" name="txt_cliente_codigo" id="txt_cliente_codigo"  /></td>
                        </tr>
                        <tr>
                            <td>Rut Cliente: </td>
                            <td><input  maxlength="11" type="text" name="txt_cliente_rut" id="txt_cliente_rut"  /></td>
                        </tr>	
                        <tr>
                            <td>Raz&oacute;n Social: </td>
                            <td><input class="contacto" type="text" id="txt_cliente_nombre" name="txt_cliente_nombre" maxlength="40" /></td>					
                        </tr>
                        <tr>
                            <td>Sigla: </td>
                            <td><input class="contacto" type="text" id="txt_sigla_cliente" name="txt_sigla_cliente" maxlength="40" /></td>					
                        </tr>
                         <tr>
                             <td>Direcci&oacute;n: </td> 
                            <td><input class="direccion" type="text" id="txt_cliente_direccion" name="txt_cliente_direccion" maxlength="50"/></td> 
                        </tr>
                        <tr>
                             <td>Comuna: </td> 
                            <td><input class="contacto" type="text" id="txt_cliente_comuna" name="txt_cliente_comuna" maxlength="50"/></td> 
                        </tr>
                        <tr>
                             <td>Ciudad: </td> 
                            <td><input class="contacto" type="text" id="txt_cliente_ciudad" name="txt_cliente_ciudad" maxlength="50"/></td> 
                        </tr>
                        <tr>
                             <td>Fono1: </td> 
                            <td><input class="contacto" type="text" id="txt_cliente_fono1" name="txt_cliente_fono1" maxlength="50"/></td> 
                        </tr>
                        <tr>
                             <td>Fono2: </td> 
                            <td><input class="contacto" type="text" id="txt_cliente_fono2" name="txt_cliente_fono2" maxlength="50"/></td> 
                        </tr>
                        <tr>
                             <td>Fax: </td> 
                            <td><input class="contacto" type="text" id="txt_cliente_fax" name="txt_cliente_fax" maxlength="50"/></td> 
                        </tr>
                        <tr>
                             <td>Rubro: </td> 
                            <td><input class="contacto" type="text" id="txt_cliente_rubro" name="txt_cliente_rubro" maxlength="50"/></td> 
                        </tr>
                        <tr>
                            <td>Contacto: </td>
                            <td><input class="contacto" type = "text" id="txt_cliente_contacto" name="txt_cliente_contacto" maxlength="20"/></td>
                        </tr>
                        <tr>
                            <td>Casilla: </td>
                            <td><input class="contacto" type = "text" id="txt_cliente_casilla" name="txt_cliente_casilla" maxlength="20"/></td>
                        </tr>
                        <tr>
                            <td>Ejecutivo: </td>
                            <td>
                                <!--<input class="contacto" disabled="disabled" name="txt_cliente_ejecutivo" id="txt_cliente_ejecutivo" />-->
                                <select name="txt_cliente_ejecutivo" id="txt_cliente_ejecutivo">
                                    <option value="">--Seleccione--</option>
                                <%
                                    Statement stmt = null;
                                    ResultSet rsQuery = null;                                       
                                    stmt = _connMy.createStatement();
                                    String q = "";

                                    q="select rut, nombre_user from svm_mae_usuarios";

                                    rsQuery = stmt.executeQuery(q);

                                    while(rsQuery.next())
                                    {
                                        out.println("<option value='"+rsQuery.getString("rut")+"'>"+rsQuery.getString("nombre_user")+"</option>");
                                    }
                                %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Estado: </td>
                            
                            <td><select class="contacto" id="txt_cliente_estado" name="txt_cliente_estado">
                                    <option value="">--Selecione--</option>
                                    <%                                
                                        stmt = _connMy.createStatement();

                                        q="SELECT descripcion FROM svm_mae_tablas where tablas='Estado_Cliente'";

                                        rsQuery = stmt.executeQuery(q);

                                        while(rsQuery.next())
                                        {
                                            out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                        }
                                    %>
                                </select>
                            </td>
                                
                            
                        </tr>
                    </table>	
                                </form>
                </div>	
            </td>
        </tr>	
    
        <tr>
            <td class="tblCliActualiza">
                <input id ="btn_ingresar" class ="botonera" type="button" name="btn_Cliente_Ingresar" value="Grabar" onClick="grabarCliente()" />
                <input id ="btn_Cancelar" class ="botonera" type="button" name="btn_Cliente_Cancelar" value="Cancelar" onClick="window.location.href='svm_Seleccion_Clientes.jsp'" />
<!--                <a class="botonera" href="svm_Seleccion_Clientes.jsp">
                    Cancelar
                </a>-->
                
            </td>
        </tr>		
    </table>
    
    <div id="dialog_pieza" title="" style="display:none;">
        <div id="dialog_pieza">

        </div>
    </div>
</body>
</html>