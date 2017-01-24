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
<!--<link type="text/css" rel="stylesheet" media="screen" href="css/jquery.ui.all.css"/>-->
<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap.min.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap-theme.min.css"/>
<link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>
<link type="text/css" rel="stylesheet" href="css/bootstrap-3.3.5.min.css"/>

<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/jquery-ui.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap-3.3.5.min.js"></script>
<script type="text/javascript" src="js/jquery.validate-1.14.0.min.js"></script>
<script type="text/javascript" src="js/jquery-validate.bootstrap-tooltip.js"></script>        

<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/Funcion_Errores.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<!-- Librerias Jquery -->
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<script src="js/CargarCombo.js" type="text/javascript" ></script>
<script src="js/CRUD_cotizacion.js" type="text/javascript"></script>
<script src="js/CRUD_cotizacion_det.js" type="text/javascript"></script>
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
    String fecha = "";
    String Estado = "";
    String rutCli = "";
    String corrCotiza = "0";
    String corrCotizaDet = "0";
    corrCotiza=request.getParameter("secuencia") != null ? request.getParameter("secuencia") : "0";
    
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
     cargaMoneda();
     cargaCotEspecial();
     cargaPresupuesto();
     cargaCondicion();
     cargaPLazoEntrega();
     cargaCotizacion();
     $("#txt_cotizacion_cantidad").keyup(function (){calculaTotal();});
     $("#txt_cotizacion_valUniCrom").keyup(function (){calculaTotal();});
     $("#txt_cotizacion_cantHrs").keyup(function (){calculaTotal();});     
     $("#txt_cotizacion_valor").keyup(function (){calculaTotal();});          
});

function goBack(){
    location.href='svm_Seleccion_Cotizacion.jsp';
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

function loadDialogPiezas(){
    $( "#dialog_pieza" ).dialog({
        modal: true,
        width: 600,
        height:400,
        resizable: false,
        buttons: {
            Seleccionar: 
                function() {
                $("#select_cotizacion_pieza").val($("#select_cotizacion_pieza_filter").val());
                $( this ).dialog( "close" );
                cargaValorDetalle();
                calculaTotal();
            },
            Cancelar: function() {
                $( this ).dialog("close");
            }            
        },
        open: function(event, ui) {
            $("#txt_cotizacion_filtro_pieza").val("");
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            filtraPiezas();
        }
    });
}

function loadDialogClientes(){
    $( "#dialog_clientes" ).dialog({
        modal: true,
        width: 600,
        height:420,
        resizable: false,
        buttons: {
            Seleccionar: function() {
                $("#txt_cotizacion_rutcli").val($("#select_cliente_filter").val());
                var text = $("#select_cliente_filter option:selected").text();
                $("#txt_cotizacion_cli").val(text.substring(21,text.length));
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
<input type="hidden" value="<%=id%>" id="parametroActComercial" />
<input type="hidden" value="<%=rut%>" id="rutUsuario" />

<div class="formularioIngresar">
    <table id="header">                           
        <tr>
            <td>
                <form action="" method="post">
                    <table >
                        <tr>
                            <td colspan =" 2" >DATOS COTIZACI&Oacute;N<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                            <td colspan = "2">DATOS CLIENTES<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                        </tr>
                        <tr>
                            <td>N° Cotizaci&oacute;n:</td>                            
                            <td>                                 
                                <input type="text" disabled= "disabled" id="txt_cotizacion_numero" maxlength="11" name="txt_cotizacion_numero" />
                            </td>                           
                            <td>Rut:</td>
                            <td><input type="text" readonly id="txt_cotizacion_rutcli" maxlength="11" name="txt_cotizacion_rutcli" />
                                <input class = "botonera" style="width: 70px" type="button" name="btnClientes" id="btnClientes" value="Clientes" onClick="loadDialogClientes()" /></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha emisi&oacute;n:</td>
                            <td>
                                <input type = "text" name = "txt_cotizacion_fecha" readonly id= "txt_cotizacion_fecha" size="12" />
                                <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador"/>
                                <!-- script que define y configura el calendario--> 
                                <script type="text/javascript"> 
                                    Calendar.setup({
                                        inputField     :    "txt_cotizacion_fecha",     // id del campo de texto 
                                        ifFormat     :     "%d-%m-%Y",     // formato de la fecha que se escriba en el campo de texto 
                                        button     :    "lanzador"     // el id del boton que lanzará el calendario 
                                    }); 
                                </script>	
                            </td>                          
                            <td>Nombre</td>
                            <td rowspan="3">
                                 <textarea rows="3" cols="27" readonly id="txt_cotizacion_cli" maxlength="40">
                                 </textarea> 
                                <!--<input type="text" id="txt_cotizacion_cli" maxlength="11" name="txt_cotizacion_cli" />-->
                            </td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Atenci&oacute;n:</td>
                            <td><select name="txt_cotizacion_atencion" id="txt_cotizacion_atencion">
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
                            <!--<td><input type="text" id="txt_cotizacion_atencion" maxlength="11" name="txt_cotizacion_atencion" /></td>-->
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Emitida Por:</td>
                            <td><select name="txt_cotizacion_emitida_por" id="txt_cotizacion_emitida_por" onchange="function (){dialogPiezas();}">
                                    <option value="">--Seleccione--</option>
                                    <%                                    
                                        stmt = _connMy.createStatement();
                                        q="select rut, nombre_user from svm_mae_usuarios";
                                        rsQuery = stmt.executeQuery(q);

                                        while(rsQuery.next())
                                        {
                                            out.println("<option value='"+rsQuery.getString("rut")+"'>"+rsQuery.getString("nombre_user")+"</option>");
                                        }
                                    %>
                                </select>
                            </td>
                            <!--<td><input type="text" id="txt_cotizacion_emitida_por" maxlength="11" name="txt_cotizacion_emitida_por" /></td>-->
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Moneda:</td>
                            <td><select name="select_cotizacion_moneda" id="select_cotizacion_moneda">
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
                            <td>Cot. Especial:</td>
                            <td><select name="select_cotizacion_especial" id="select_cotizacion_especial">
                                    <option value="">--Seleccione--</option>
                                </select></td>
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
                        <tr>
                            <td>Presupuesto V&aacute;lido:</td>
                            <td colspan="3"><select style="width: 200px" name="select_cotizacion_presupuesto_valido" id="select_cotizacion_presupuesto_valido">
                                    <option value="">--Seleccione--</option>
                                </select></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Plazo Entrega:</td>
                            <td colspan="3"><select style="width: 200px" name="select_cotizacion_plazo_entrega" id="select_cotizacion_plazo_entrega">
                                    <option value="">--Seleccione--</option>
                                </select></td>
                            <td></td>
                            <td>
                                
                            </td>
                        </tr>
                        <tr>
                            <td>Condiciones de Pago:</td>
                            <td colspan="3"><select style="width: 200px" name="select_cotizacion_condicion_pago" id="select_cotizacion_condicion_pago">
                                    <option value="">--Seleccione--</option>
                                </select></td>
                            <td></td>
                            <td>
                                
                            </td>
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
                                        sp_usu = _connMy.prepareCall("{call sp_historial(?,?,'','')}");
                                        sp_usu.setString(1,var);                                        
                                        sp_usu.setLong(2,Long.parseLong(secuencia));                                          
                                        sp_usu.execute();
                                        final ResultSet rsHistorial = sp_usu.getResultSet();
                                        String claseGrilla = "";
                                        while(rsHistorial.next())
                                        {
                                            if(cont % 2 == 0)
                                            {                                                
                                                claseGrilla = "alt";
                                            }
                                            out.println("<tr id='filaTablaHistorial"+cont+"' class='"+claseGrilla+"'>");
                                    %>                                                                                                                                                                    
                                        <td id ="historial_estAnterior<%=cont%>"><%=rsHistorial.getString("estado_anterior")%></td>
                                        <td id ="historial_estSiguiente<%=cont%>"><%=rsHistorial.getString("estado_siguiente")%></td>
                                        <td id ="historial_fecha<%=cont%>"><%=rsHistorial.getString("fecha")%></td>
                                        <td id ="historial_rutUser<%=cont%>"><%=rsHistorial.getString("rutUser")%></td>
                                        <td id ="historial_nomUser<%=cont%>"><%=rsHistorial.getString("nomUser")%></td>                                                                                   
                                     <%
                                            out.print("</tr>");
                                            claseGrilla = "";
                                            cont ++;
                                        }
                                     %>                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>      
        <tr>
            <td colspan="14">
                <table class="detalle">
                    <tr>
                        <td colspan = "10" id='margen'>PIEZAS<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                    </tr>
                    <tr>
                        <td>Pieza:</td>
                        <td colspan="1"><select style="width:120px" id="select_cotizacion_pieza" onchange="cargaValorDetalle()" name="select_cotizacion_pieza">
                                <option value="">--Seleccione--</option>
                                <%                                    
                                    stmt = _connMy.createStatement();
                                    q="select codigo, nombre from svm_mae_pieza";
                                    rsQuery = stmt.executeQuery(q);

                                    while(rsQuery.next())
                                    {
                                        out.println("<option value='"+rsQuery.getString("codigo")+"'>"+rsQuery.getString("nombre")+"</option>");
                                    }
                                %>
                            </select> 
                            <input class = "botonera" type="submit" name="btnPiezas" id="btnPiezas" value="Piezas" onClick="loadDialogPiezas()" /></td>
                        <td>Cantidad:</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_cantidad" name="txt_cotizacion_cantidad" onkeypress="return validarSiNumero(event)"/></td>         
                        <td>Valor DM:</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_dm" name="txt_cotizacion_dm" onkeypress="return validarSiNumero(event)" /></td>         
                        <td>D&iacute;ametro:</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_diametro" name="txt_cotizacion_diametro" onkeypress="return validarSiNumero(event)" /></td>         
                    </tr>
                    <tr>
                        <td>Largo:</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_largo" name="txt_cotizacion_largo" onkeypress="return validarSiNumero(event)" /></td>                        
                        <td>ValUniCrom:</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_valUniCrom" name="txt_cotizacion_valUniCrom" onkeypress="return validarSiNumero(event)" /></td>         
                        <td>C/Hora: $</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_cHora" name="txt_cotizacion_cHora" onkeypress="return validarSiNumero(event)" /></td>         
                        <td>Cant. Hrs:</td>
                        <td colspan="1"><input type="text" maxlength="9" id="txt_cotizacion_cantHrs" name="txt_cotizacion_cantHrs" onkeypress="return validarSiNumero(event)" /></td>  
                        <!--<td>Total Crom:</td>-->
                        <td><input type="hidden" id="txt_cotizacion_totalCrom" name="txt_cotizacion_totalCrom" /></td>
                        <!--<td>Valor Unitario:</td>-->
                        <td><input type="hidden" id="txt_cotizacion_valUnitario" name="txt_cotizacion_valUnitario" /></td>
                        <!--<td>Totales:</td>-->
                        <td><input type="hidden" id="txt_cotizacion_totales" name="txt_cotizacion_totales" /></td>
                        <!--<td>Total Horas$:</td>-->
                        <td><input type="hidden" id="txt_cotizacion_totalhoras" name="txt_cotizacion_totalhoras" /></td>                        
                    </tr>
                    <tr>
                        <td colspan="13" rowspan="5" id='margen'>
                            <div  id = "tablaDetalle" class="grillaConf">
                                <table id="tblDetalleComer">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Numero</th>
                                            <th>Cod. Pieza</th>
                                            <th>Pieza</th>
                                            <th>Cantidad</th>
                                            <th>Valor DM</th>
                                            <th>D&iacute;ametro</th>
                                            <th>Largo</th>
                                            <th>ValUniCrom</th>
                                            <th>Total Crom</th>
                                            <th>C/Hora</th>
                                            <th>Cant. Hrs.</th>
                                            <th>Total Hrs. $</th>                                            
                                            <th>Valor Unitario</th>
                                            <th>Totales</th>
                                        </tr>
                                    </thead>				
                                    <tbody>
                                    <%
                                         cont = 0;
                                         int ultimo =0;
                                         
                                         var = "select";                                        
                                         sp_usu = _connMy.prepareCall("{call sp_cotizaciones_det(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                                        sp_usu.setString(1,var);
                                        sp_usu.setInt(2,0);
                                        sp_usu.setInt(3,0);
                                        sp_usu.setString(4,"");
                                        sp_usu.setString(5,"");
                                        sp_usu.setInt(6,0);
                                        sp_usu.setString(7,"");
                                        sp_usu.setDouble(8,0.0);
                                        sp_usu.setDouble(9,0.0);
                                        sp_usu.setInt(10,0);
                                        sp_usu.setInt(11,0);
                                        sp_usu.setInt(12,0);
                                        sp_usu.setInt(13,0);
                                        sp_usu.setInt(14,0);
                                        sp_usu.setInt(15,0);
                                        sp_usu.setInt(16,0);                                        
                                        sp_usu.setInt(17,Integer.parseInt(corrCotiza));  
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
                                            <a id="seleccion<%=cont%>" href="javascript: onclick=ModificaDetalleComercial(<%=cont%>);CargaCorrDet();"> >></a>
                                            <input type="hidden" value="0" id="habilitaDetCom" name="habilitaDetCom" />
                                        </td>                                                                                       
                                        <td id ="cotazacionDet_correlativo<%=cont%>"><%=rsDetalle.getString("correlativo")%></td>
                                        <td id ="cotazacionDet_codPieza<%=cont%>"><%=rsDetalle.getString("cod_pieza")%></td>
                                        <td id ="cotazacionDet_pieza<%=cont%>"><%=rsDetalle.getString("desc_pieza")%></td>
                                        <td id ="cotazacionDet_cantidad<%=cont%>"><%=rsDetalle.getString("cantidad")%></td>
                                        <td id ="cotazacionDet_valorDm<%=cont%>"><%=rsDetalle.getString("valor_dm")%></td>
                                        <td id ="cotazacionDet_diametro<%=cont%>"><%=rsDetalle.getString("diametro")%></td>
                                        <td id ="cotazacionDet_largo<%=cont%>"><%=rsDetalle.getString("largo")%></td>                                            
                                        <td id ="cotazacionDet_valUniCrom<%=cont%>"><%=rsDetalle.getString("valor_uni_crom")%></td>
                                        <td id ="cotazacionDet_totalCrom<%=cont%>"><%=rsDetalle.getString("total_cromado")%></td>                                        
                                        <td id ="cotazacionDet_cHora<%=cont%>"><%=rsDetalle.getString("c_horas")%></td>                                        
                                        <td id ="cotazacionDet_cantHoras<%=cont%>"><%=rsDetalle.getString("cant_horas")%></td>                                        
                                        <td id ="cotazacionDet_totalHrs<%=cont%>"><%=rsDetalle.getString("totalhoras_pesos")%></td>
                                        <td id ="cotazacionDet_valorUnitario<%=cont%>"><%=rsDetalle.getString("valor_unitario")%></td>
                                        <td id ="cotazacionDet_totales<%=cont%>"><%=rsDetalle.getString("totales")%></td>
                                        
                                     <%
                                            out.print("</tr>");
                                            claseGrilla = "";
                                            cont ++;
                                            ultimo = Integer.parseInt(rsDetalle.getString("numero_cotizacion"));                                                                                     
                                            
                                        }
                                        out.print("<input type='hidden' id='cantidad_detalle' value="+cont+"></input>");
                                     %>
                                     
                                    </tbody>
                                </table>
                                    <input type="hidden" id="ultimo" value="<%=ultimo+1%>"></input>
                                    
                                    <input type="hidden" id="txt_correlativo" value="<%=corrCotizaDet%>"></input>
                            </div>                                               
                        </td>
                        <td id="bottom" rowspan="1">
                            <img style="cursor: pointer" onclick="ingresaDetalle()" id="DetalleIngreso" class="ico" border="0" src="images/logotipos/agregar.png" 
                            height="48px" width="25px"/>
                        </td>
                    </tr>

                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="DetalleModifica" style="display: none" onclick="modificaDetalle();LimpiaSubDetalle();" src="images/logotipos/modificar.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="CancelaModifica" style="display: none" onclick="CancelaDetalle();LimpiaSubDetalle();" src="images/logotipos/flecha.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>                            
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="DetalleElimina" style="display: none" border="0" onclick="eliminaDetalle()" src="images/logotipos/eliminar.png" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                </table>
            </td>
            <tr>                
                <td colspan="6">
                <table class="detalle">
                    <tr>
                        <td colspan="6"><hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                    </tr>       
                    <tr>
                        <td colspan = "14" id='margen'>MECANIZADO<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                    </tr>
                    <tr>
                        <td>Valor: $</td>
                        <td><input type="text" maxlength="9" id="txt_cotizacion_valor" name="txt_cotizacion_valor" onkeypress="return validarSiNumero(event)" /></td>         
                        <td>Margen%:</td>
                        <td><input type="text" maxlength="5" id="txt_cotizacion_margen" name="txt_cotizacion_margen" onkeypress="return validarSiDecimal(event)" /></td>                        
                        <!--<td>Total Material:</td>-->
                        <td><input type="hidden" id="txt_cotizacion_totalmaterial" name="txt_cotizacion_totalmaterial" /></td>                        
                        
                    </tr>
                    <tr>
                        <td colspan="13" rowspan="5" id='margen'>
                            <div  id = "tablaSubDe" class="grillaConf">
                                <table id="tablaSubDetalle">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Numero</th>
                                            <th>Item</th>
                                            <th>Valor$</th>
                                            <th>Margen %</th>
                                            <th>Total $</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>    
                                    <input type="hidden" id="txt_correlativo2" value=""></input>
                                    <input type="hidden" id="txt_subitem" value=""></input>
                            </div>        
                        </td>            
                        <td id="bottom" rowspan="1">
                            <img style="cursor: pointer" onclick="ingresaSubDetalle()" id="SubDetalleIngreso" class="ico" border="0" src="images/logotipos/agregar.png" 
                            height="48px" width="25px"/>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="SubDetalleModifica" style="display: none" onclick="modificaSubDetalle()" src="images/logotipos/modificar.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="SubDetalleCancela" style="display: none" onclick="CancelaSubDetalle()" src="images/logotipos/flecha.png" border="0" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>                      
                    <tr>
                        <td id="bottom">
                            <a href="#">
                                <img id="SubDetalleElimina" style="display: none" border="0" onclick="eliminaSubDetalle()" src="images/logotipos/eliminar.png" 
                                height="25px" width="25px" />
                            </a>
                        </td>
                    </tr>
                </table>    
                </td>    
            </tr>
        </tr>
    </table>
</div>            
<input class ="botonera" type="submit" id="btn_cotazacioncial_grabar" name="btn_cotazacioncial_grabar" value="Grabar" onclick="grabarCotizacion();"/>
<input class = "botonera" type="submit" name="btnCancela" value="Cancelar" onClick="goBack()" />
<input class = "botonera" style="width: 150px" id="btn_cotizacion_aprobar" type="submit" name="btnAprobar" id="btnAprobar" value="Aprobar Cotizacion" onClick="aprobarCotiza()" />



<div id="dialog_pieza" title="Piezas" style="display:none;">
    <div id="contenido_pieza">
        Nombre de pieza:&nbsp;&nbsp;
       <input type="text" maxlength="11" id="txt_cotizacion_filtro_pieza" name="txt_cotizacion_filtro_pieza" />
       &nbsp;&nbsp;&nbsp;
       <input style="font-size:12px; height: 23px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Piezas" onclick="filtraPiezas()" />
       <br/>
       <br/>
        <select size="10" style="width: 560px;" id="select_cotizacion_pieza_filter" name="select_cotizacion_pieza_filter" multiple>
            <%                                    
                stmt = _connMy.createStatement();
                q="select codigo, nombre from svm_mae_pieza";
                rsQuery = stmt.executeQuery(q);

                while(rsQuery.next())
                {
                    out.println("<option value='"+rsQuery.getString("codigo")+"'>"+rsQuery.getString("nombre")+"</option>");
                }
            %>
        </select>
    </div>
</div>
        
        
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