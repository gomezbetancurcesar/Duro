<%@page import="java.sql.Connection"%>
<%@page import="DAL.conexionBD"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PORTAL DUROCROM</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css" />
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET" />
<link href="css/solutel.css" type="text/css" rel="STYLESHEET" />
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet" />
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/label.js" type="text/javascript"></script>
<script src="js/FuncionTablas.js" type="text/javascript"></script>
<!--Codigo Sistemas SA-->

<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>

</head>
<body id="principal" >
<table id="header" >
    <tr><%HttpSession s = request.getSession();
        if(s.getAttribute("nom")==null)
        {
            response.sendRedirect("login.jsp");
        }
        Connection _connMy = null;
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
//        if(_connMy == null)
//        {
//            response.sendRedirect("login.jsp");
//        }
          %>
        <td id="imagenInicio">
            <label id="labelWelcome">BIENVENIDO,<br /> <%=s.getAttribute("nom")%></label>
            <center><img src="images/mujer.jpg" height="250px"/></center>
        </td>
        <td id="headerTd">
            <div id="noticia">
                <table class="center">
                    <tr>
                        <td>
                            <table class="left">
                                <% 
                                    String q = "select titulo,autor,noticia,convert(fecha,char) as fecha from svm_mae_escritorio where vigencia = 'si'";
                                    ResultSet rs = _connMy.createStatement().executeQuery(q);
                                    while(rs.next())
                                    {
                                %>
                                <tr>
                                    <td colspan="2">
                                        <div class="titulos">
                                            <b>
                                              <%= rs.getString("titulo")%>  
                                            </b>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="fechas">
                                            <%=rs.getString("fecha")%>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="nombres">
                                            <b><%= rs.getString("autor")%></b>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <%= rs.getString("noticia")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <hr/>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>  
                            </table>
                        </td>
                    </tr>
                </table>							
            </div>
        </td>
        <td class="letra">
            <div id="tablaIndicadores">
                <table class="right">
                    <tr>
                        <td colspan="2" id="indicadoresTitle">
                            <b>Indicadores Económicos</b>
                        </td>	
                    </tr>				
                    <tr class="center">
                        <td class="datosIndicadores">                          
                            <script src="http://www.bci.cl/common/include/valores.js"></script>
                            <!-- Indicadores Economicos -->
                                Dolar Obs.:<script type="text/javascript">
                              if(typeof(arrValores) != "undefined")
                              if(typeof(arrValores[6])=="object")
                              document.write(formatear_numero(arrValores[55].valor2));
                              </script>
                              |
                              UF:<script type="text/javascript">
                              if(typeof(arrValores) != "undefined")
                              if(typeof(arrValores[4])=="object")
                              document.write(formatear_numero(arrValores[4].valor2));
                              </script>
                              |
                              UTM:<script type="text/javascript">
                              if(typeof(arrValores) != "undefined")
                              if(typeof(arrValores[6])=="object")
                              document.write(formatear_numero(arrValores[5].valor2));
                              </script>
                              |
                              IPC:<script type="text/javascript">
                              if(typeof(arrValores) != "undefined")
                              if(typeof(arrValores[6])=="object")
                              document.write(formatear_numero(arrValores[23].valor2));
                              </script>
                              |<!-- Fin Indicadores Economicos -->
                        </td>
                        <td>
                            <center><span id="uf"></span></center>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan = "2" id="indicadoresTitle">
                            <b>Santoral</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="datosIndicadores">
                            <iframe class="santoral" scrolling="no" src="http://pagina-del-dia.euroresidentes.es/santo-del-dia/gadget-santo-del-dia.php" frameborder="0"></iframe>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan = "2" id="indicadoresTitle">
                            <b>El Tiempo</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="datosIndicadores">
                            <!-- www.TuTiempo.net - Ancho:134px - Alto:122px -->
                            <div id="TT_RCgEkEk1EUaczehUKfrzjDzzDWuUTzB2Lt1Y1cCoa1D">El tiempo por Tutiempo.net</div>
                            <script type="text/javascript" src="http://www.tutiempo.net/widget/eltiempo_RCgEkEk1EUaczehUKfrzjDzzDWuUTzB2Lt1Y1cCoa1D"></script>															
                        </td>
                    </tr>
                </table>
            </div>			
        </td>
    </tr>
</table>
</body>
</html>