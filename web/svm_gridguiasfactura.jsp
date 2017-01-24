<%-- 
    Document   : svm_gridguiasfactura
    Created on : 12-01-2017, 11:27:39
    Author     : YV
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAL.conexionBD"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
        <link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
        <link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
        <link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>
        <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                
                $('#btnSalir').click(function(){
                    parent.history.back();
                    return false;
                });
            });
            function selectAllchk(){
    
                if($("#select_all").is(':checked')) {
                    $(".checkboxguias").prop('checked', true);
                } else {
                    $(".checkboxguias").prop('checked', false);
                }
            }
        </script>
        <title>Lista Guias</title>
        <%
            String fech_desde = request.getParameter("txt_fechadesde");
            String fech_hasta = request.getParameter("txt_fechahasta");
            String rut_cliente = request.getParameter("txt_factura_rutcli");
            String nro_factura = request.getParameter("txt_nrofactura");
            
            DateFormat sdfv = new SimpleDateFormat("dd-MM-yyyy");
            DateFormat sdfq = new SimpleDateFormat("yyyy-MM-dd");
            
            if((fech_desde == null || fech_desde.trim().isEmpty()) 
                || (fech_hasta == null || fech_hasta.trim().isEmpty())
                || (rut_cliente == null || rut_cliente.trim().isEmpty())
                || (nro_factura == null || nro_factura.trim().isEmpty())){
                response.sendRedirect("svm_facturautomatic.jsp");
            }
        %>
    </head>
    <body>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td><h4>N&deg; Factura <%out.print(nro_factura);%></h4></td>
            </tr>
            <tr>
                <td><center><h4>Lista Guias</h4><center/></td>
            </tr>
        </table>
        <div class="gridConf">
            <table id="tblGuiaDespSelec">
                <thead>
                    <tr>
                        <th>N° Guia de Despacho</th>
                        <th>Fecha de Emision</th>
                        <th>Especial</th>
                        <th>Total</th>
                        <th><input type="checkbox" name="chkbox" id="select_all" onchange="selectAllchk();" /></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        HttpSession s = request.getSession();
                        Connection _connMy = null;
                        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                        Statement stmt = _connMy.createStatement();
                        String q = "SELECT numero_guia, DATE_FORMAT(fecha_emision,'%d-%m-%Y') AS fecha_emision, guiadespacho_especial, total FROM svm_guiadespacho_cab WHERE 1=1 ";
                        
                        if(!fech_desde.equals("")){
                            fech_desde = sdfq.format(sdfv.parse(fech_desde));
                            q += " AND fecha_emision >= '"+fech_desde+"' ";
                        }
                        if(!fech_hasta.equals("")){
                            fech_hasta = sdfq.format(sdfv.parse(fech_hasta));
                            q += " AND fecha_emision <= '"+fech_hasta+"' ";
                        }
                        
                        String[] parts = rut_cliente.split("-");

                        if(!parts[0].equals("")){
                            q += " AND rut_cliente = '"+parts[0]+"' ";
                        }
                        
                        System.out.println("QUERY: "+ q);
                        final ResultSet rsQuery = stmt.executeQuery(q);
                        while(rsQuery.next())
                        {
                    %>
                    <tr>
                        <td><%out.print(rsQuery.getString("numero_guia"));%></td>
                        <td><%out.print(rsQuery.getString("fecha_emision"));%></td>
                        <td><%out.print(rsQuery.getString("guiadespacho_especial"));%></td>
                        <td><%out.print(rsQuery.getString("total"));%></td>
                        <td><input type='checkbox' name='<%out.print(rsQuery.getString("numero_guia"));%>' class='checkboxguias'/></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="right">
            <input class ="botonera" type="button" id="btnFacturar" name="btnFacturar" value="Facturar"/>
            <input class = "botonera" type="button" id ="btnSalir" name="btnSalir" value="Salir" />
        </div>
    </body>
</html>
