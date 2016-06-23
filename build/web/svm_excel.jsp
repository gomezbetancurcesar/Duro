<%
    HttpSession s = request.getSession();
    if(s.getAttribute("nom")==null)
    {
        response.sendRedirect("login.jsp");
    }
    response.setContentType("application/vnd.ms-excel");
    String mes = request.getParameter("mes");
    String anio = request.getParameter("anio");
    response.setHeader("Content-Disposition", "attachment; filename=\"CierreMes_"+mes+"/"+anio+".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css">
        .grillaExcel{
            font: normal 12px/150% Arial, Helvetica, sans-serif;
        }   
        .grillaExcel thead th{
            background-color:#2798D9;
            color:#FFFFFF;
            font-size: 13px;
            font-weight: bold;
            border-left: 1px solid #36752D;
        }
        .grillaExcel tbody tr td{             
            border-left: 1px solid #000000;
            border-bottom: 1px solid #000000;
        }
    </style>    
    <title>JSP Page</title>
    </head>
    <body>
        <table class="grillaExcel">
            <thead> 
                <th>RV</th>
                <th>Ejecutivo</th> 
                <th>Fecha</th>
                <th>Rut Cliente</th>
                <th>Cliente</th>             
                <th>Caso</th>                
                <th>Número de Negocio</th>
                <th>Número Móvil</th>
                <th>Servicio</th>
                <th>Servicios Móviles</th>
                <th>Port-PP-Hab</th>
                <th>Tipo Plan Antiguo</th>
                <th>Plan Antiguo</th>         
                <th>Cargo Fijo</th>
                <th>Tipo Plan Nuevo</th>
                <th>Plan Nuevo</th>
                <th>Cargo Fijo</th>
                <th>Arpu</th>
                <th>UF</th>                
                <th>Estado</th>                                             
                <th>CRM</th>
                <th>Comentario</th>  
                <th>Supervisor</th>
                <th>Estado de Cierre</th>            
            </thead>
            <tbody>
                <%=s.getAttribute("dataExcel")%>
            </tbody>
        </table>
    </body>
</html>